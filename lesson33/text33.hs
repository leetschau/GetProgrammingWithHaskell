import Control.Monad
import Control.Applicative

main :: IO ()
main = do
    print (_where (startsWith 'J' . firstName) (_select studentName students))
    print (_join teachers courses teacherId teacher)
    print (runHINQ query1)
    print (runHINQ query2)
    print (runHINQ maybeQuery1)
    print (runHINQ maybeQuery2)
    print studentEnrollments
    print (getEnrollments "English")
    print (getEnrollments "French")

-- section 33.1

data Name = Name
          { firstName :: String
          , lastName :: String }

instance Show Name where
    show (Name first last) = mconcat [first, " ", last]

data GradeLevel = Freshman
                | Sophmore
                | Junior
                | Senior deriving (Eq, Ord, Enum, Show)

data Student = Student
             { studentId :: Int
             , gradeLevel :: GradeLevel
             , studentName :: Name } deriving Show

students :: [Student]
students = [(Student 1 Senior (Name "Audre" "Lorde"))
           ,(Student 2 Junior (Name "Leslie" "Silko"))
           ,(Student 3 Freshman (Name "Judith" "Butler"))
           ,(Student 4 Senior (Name "Guy" "Debord"))
           ,(Student 5 Sophmore (Name "Jean" "Baudrillard"))
           ,(Student 6 Junior (Name "Julia" "Kristeva"))]

-- section 33.2

_select :: Monad m => (a -> b) -> m a -> m b    -- z1
_select prop vals = do
    val <- vals
    return (prop val)

_where :: (Monad m, Alternative m) => (a -> Bool) -> m a -> m a
_where test vals = do
    val <- vals
    guard (test val)
    return val

startsWith :: Char -> String -> Bool
startsWith char string = char == (head string)

-- section 33.3

data Teacher = Teacher
             { teacherId :: Int
             , teacherName :: Name } deriving Show

teachers :: [Teacher]
teachers = [Teacher 100 (Name "Simone" "De Beauvior")
           ,Teacher 200 (Name "Susan" "Sontag")]

data Course = Course
            { courseId :: Int
            , courseTitle :: String
            , teacher :: Int} deriving Show

courses :: [Course]
courses = [Course 101 "French" 100
          ,Course 201 "English" 200]

_join :: (Monad m, Alternative m, Eq c) => m a -> m b -> (a -> c) -> (b -> c) -> m (a, b)
_join data1 data2 prop1 prop2 = do  -- a property of a record is essentially a function
    d1 <- data1
    d2 <- data2
    let joinedPairs = (d1, d2)
    guard ((prop1 (fst joinedPairs)) == (prop2 (snd joinedPairs)))
    return joinedPairs

-- section 33.4

_hinq selectQuery joinQuery whereQuery = (\joinData ->
                                           (\whereResult ->
                                             selectQuery whereResult)
                                           (whereQuery joinData)
                                         ) joinQuery

finalResult :: [Name]
finalResult = _hinq (_select (teacherName . fst))
                    (_join teachers courses teacherId teacher)
                    (_where ((== "English") . courseTitle . snd))

teacherFirstName :: [String]
teacherFirstName = _hinq (_select firstName)
                         finalResult
                         (_where (\_ -> True))

-- section 33.5

data HINQ m a b =                          -- x1
     HINQ (m a -> m b) (m a) (m a -> m a)  -- x2
   | HINQ_ (m a -> m b) (m a)              -- x3

runHINQ :: (Monad m, Alternative m) => HINQ m a b -> m b
runHINQ (HINQ sClause jClause wClause) = _hinq sClause jClause wClause
runHINQ (HINQ_ sClause jClause) = _hinq sClause jClause (_where (\_ -> True))

-- section 33.6

query1 :: HINQ [] (Teacher, Course) Name                    -- y1
query1 = HINQ (_select (teacherName . fst))                 -- y2
              (_join teachers courses teacherId teacher)    -- y3
              (_where ((== "English") . courseTitle . snd)) -- y4

-- y1 行对应 x1 行，所以:
-- m: []
-- a: (Teacher, Course)
-- b: Name

-- 根据 z1 行中 _select 的定义，它的参数是一个函数和一个 m a 类型的值，
-- 由于 y2 行中 _select 后只有一个函数 (teacherName . fst)，
-- 所以 (_select (teacherName . fst)) 的返回值是一个函数，
-- 类型是 m a -> m b，与 x2 行 HINQ 的第一个参数类型匹配。
-- 那么 (teacherName . fst) 的类型是不是符合上述 x1-y1 形成的对应关系，
-- 也就是 a -> b 对应着 (Teacher, Course) -> Name 呢？
-- 在 ghci 中执行 :t (teacherName . fst)，结果为：
-- (teacherName . fst) :: (Teacher, b) -> Name
-- 符合要求，具体推导过程是：
-- 对于一个类型为 (Teacher, Course) 的输入值，fst 取出第一个值，类型为 Teacher，
-- 然后交给 teacherName 处理，teacherName 再把它转换为 Name 类型的值。
-- 下面的 y3, y4 行可以用相同的方法分析

query2 :: HINQ [] Teacher Name
query2 = HINQ_ (_select teacherName) teachers

possibleTeacher :: Maybe Teacher
possibleTeacher = Just (head teachers)

possibleCourse :: Maybe Course
possibleCourse = Just (head courses)

maybeQuery1 :: HINQ Maybe (Teacher, Course) Name
maybeQuery1 = HINQ (_select (teacherName . fst))
                   (_join possibleTeacher possibleCourse teacherId teacher)
                   (_where ((== "French") . courseTitle . snd))

missingCourse :: Maybe Course
missingCourse = Nothing

maybeQuery2 :: HINQ Maybe (Teacher, Course) Name
maybeQuery2 = HINQ (_select (teacherName . fst))
                   (_join possibleTeacher missingCourse teacherId teacher)
                   (_where ((== "French") . courseTitle . snd))

-- section 33.6.2

data Enrollment = Enrollment
                { student :: Int
                , course :: Int } deriving Show

enrollments :: [Enrollment]
enrollments = [(Enrollment 1 101)
              ,(Enrollment 2 101)
              ,(Enrollment 2 201)
              ,(Enrollment 3 101)
              ,(Enrollment 4 201)
              ,(Enrollment 4 101)
              ,(Enrollment 5 101)
              ,(Enrollment 6 201)]

studentEnrollmentsQ = HINQ_ (_select (\(st, en) -> (studentName st, course en))) -- 书中此处有误：丢了一个右括号
                            (_join students enrollments studentId student)

studentEnrollments :: [(Name, Int)]
studentEnrollments = runHINQ studentEnrollmentsQ

englishStudentsQ = HINQ (_select (fst . fst))
                        (_join studentEnrollments courses snd courseId)
                        -- 这里 snd 不是列名，而是函数名，这里是取 studentEnrollments 每个元素元组的第2个值
                        (_where ((== "English") . courseTitle . snd))

englishStudents :: [Name]
englishStudents = runHINQ englishStudentsQ

getEnrollments :: String -> [Name]
getEnrollments courseName = runHINQ courseQuery
  where courseQuery = HINQ (_select (fst . fst))
                           (_join studentEnrollments courses snd courseId)
                           (_where ((== courseName) . courseTitle . snd))