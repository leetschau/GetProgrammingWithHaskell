main = do
  print (patientInfo ("John", "Doe") 43 74)
  print (showName (name jackSmith))
  print (show (canDonateTo lily stan))
  print (show (canDonateTo stan lily))
  print (show (canDonateTo jackSmith tom))
  print (show (canDonateTo bob betty))
  print (patientSummary tom)

-- QC 12.1

type Age = Int
type Height = Int
type PatientName = (String, String)

firstName :: PatientName -> String
firstName patient = fst patient

lastName :: PatientName -> String
lastName patient = snd patient

patientInfo :: PatientName -> Age -> Height -> String
patientInfo name age height = firstName name ++ ", " ++ lastName name ++
                              " " ++ "(" ++ show age ++ "yrs, " ++
                              show height ++ "in.)"

-- QC 12.2

type FirstName = String
type LastName = String
type MiddleName = String
data Name = Name FirstName LastName
          | NameWithMiddle FirstName MiddleName LastName

data Sex = Male | Female

data ABOType = A | B | AB | O
data RhType = Pos | Neg
data BloodType = BloodType ABOType RhType

data Patient = Patient Name Sex Int Int Int BloodType

jes :: Patient
jes = Patient (NameWithMiddle "Jane" "Eli" "Smith") Female 20 50 60 (BloodType B Neg)

data PatientR = PatientR { name :: Name
                         , sex :: Sex
                         , age :: Int
                         , height :: Int
                         , weight :: Int
                         , bloodType :: BloodType }

-- QC 12.3

showName :: Name -> String
showName (Name f l) = "Patient Name: " ++ f ++ " " ++ l
showName (NameWithMiddle f m l) = "Patient Name: " ++ f ++ " " ++ m ++ " " ++ l

showRh :: RhType -> String
showRh Pos = "+"
showRh Neg = "-"

showABO :: ABOType -> String
showABO A = "A"
showABO B = "B"
showABO AB = "AB"
showABO O = "O"

showBloodType :: BloodType -> String
showBloodType (BloodType abo rh) = "Blood Type: " ++ showABO abo ++ showRh rh

jackSmith :: PatientR
jackSmith = PatientR { name = Name "Jackie" "Smith"
                     , age = 43
                     , sex = Female
                     , height = 62
                     , weight = 115
                     , bloodType = BloodType O Neg }

-- Q12.1

canDonateTo :: PatientR -> PatientR -> Bool
canDonateTo (PatientR { bloodType = BloodType O _ }) _ = True
canDonateTo _ (PatientR { bloodType = BloodType AB _ }) = True
canDonateTo (PatientR { bloodType = BloodType A _ }) (PatientR { bloodType = BloodType A _ }) = True
canDonateTo (PatientR { bloodType = BloodType B _ }) (PatientR { bloodType = BloodType B _ }) = True
canDonateTo _ _ = False

betty :: PatientR
betty = PatientR { name = Name "Betty" "Lu"
                 , age = 13
                 , sex = Female
                 , height = 20
                 , weight = 40
                 , bloodType = BloodType A Pos }

tom :: PatientR
tom = PatientR { name = Name "Tom" "Lee"
                 , age = 13
                 , sex = Male
                 , height = 20
                 , weight = 40
                 , bloodType = BloodType B Pos }

bob :: PatientR
bob = PatientR { name = Name "Bob" "Kay"
                 , age = 13
                 , sex = Male
                 , height = 20
                 , weight = 40
                 , bloodType = BloodType B Neg }

lily :: PatientR
lily = PatientR { name = Name "Lily" "Don"
                 , age = 13
                 , sex = Female
                 , height = 20
                 , weight = 40
                 , bloodType = BloodType A Pos }

stan :: PatientR
stan = PatientR { name = Name "Stan" "Moose"
                 , age = 13
                 , sex = Male
                 , height = 20
                 , weight = 40
                 , bloodType = BloodType AB Neg }

-- Q12.2

showSex :: Sex -> String
showSex Male = "Sex: Male"
showSex Female = "Sex: Female"

patientSummary :: PatientR -> String
patientSummary patient = "**********\n" ++ showName (name patient) ++ "\n" ++
                         showSex (sex patient) ++  "\nAge: " ++
                         show (age patient) ++ "\nHeight: " ++ show (height patient) ++
                         "\nWeight: " ++ show (weight patient) ++ "\n" ++
                         showBloodType (bloodType patient) ++ "\n" ++
                         "**********"
