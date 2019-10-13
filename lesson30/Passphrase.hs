-- 基于 Monad transformers 一文中例子，详见 notes.md 文件
import Data.Char
import Control.Applicative
import Control.Monad
import Control.Monad.Trans.Class

main :: IO ()
-- main = askPassphrase2
main = do
    res <- runMaybeT askPassphrase
    case res of
      Just rr -> return rr
      Nothing -> putStrLn "Invalid passphrase"

-- An example validation test implementaton
isValid :: String -> Bool
isValid s = length s >= 8
            && any isAlpha s
            && any isNumber s
            && any isPunctuation s

-- 嵌套 Monad 实现 --

askPassphrase2 :: IO ()
askPassphrase2 = do
  putStrLn "Insert your new passphrase:"
  maybe_value <- getPassphrase2
  -- 第一次拆箱，从 IO(Maybe String) 变成 Maybe String
  case maybe_value of
  -- 用 pattern matching 做第二次拆箱
    Just value -> do
      putStrLn $ "Your passphrase is: " ++ value
      putStrLn "Storing in database..."
    Nothing -> putStrLn "Passphrase invalid."

getPassphrase2 :: IO (Maybe String)
getPassphrase2 = do
  s <- getLine
  if isValid s then return $ Just s
               else return Nothing

-- Monad Transformer 实现 --

newtype MaybeT m a = MaybeT { runMaybeT :: m (Maybe a) }
-- 此处使用了 record 语法，MaybeT 是一个 record，包含一个名为 runMaybeT 的字段，
-- 类型为 m (Maybe a)，MaybeT 的 kind 为 (* -> *) -> * -> * （ghci 中执行 :k MaybeT）

instance Monad m => Monad (MaybeT m) where
  return  = MaybeT . return . Just

  -- The signature of (>>=), specialized to MaybeT m:
  -- (>>=) :: MaybeT m a -> (a -> MaybeT m b) -> MaybeT m b
  -- 所以 f 的类型是 a -> MaybeT m b，f value 的类型是 MaybeT m b
  -- runMaybeT 的类型是 MaybeT m a -> m (Maybe a)
  -- 所以 runMaybeT $ f value 的类型是 m (Maybe b)（用类型变量 b 替换了 a）
  x >>= f = MaybeT $ do maybe_value <- runMaybeT x
                        case maybe_value of
                           Nothing    -> return Nothing
                           Just value -> runMaybeT $ f value

instance Monad m => Applicative (MaybeT m) where
    pure = return
    (<*>) = ap

instance Monad m => Functor (MaybeT m) where
    fmap = liftM

instance Monad m => Alternative (MaybeT m) where
    empty   = MaybeT $ return Nothing
    x <|> y = MaybeT $ do maybe_value <- runMaybeT x
                          case maybe_value of
                               Nothing    -> runMaybeT y
                               Just _     -> return maybe_value

instance Monad m => MonadPlus (MaybeT m) where 
    mzero = empty
    mplus = (<|>)

instance MonadTrans MaybeT where
    lift = MaybeT . (liftM Just)

getPassphrase :: MaybeT IO String
getPassphrase = do s <- lift getLine
                   guard (isValid s) -- Alternative provides guard.
                   return s

askPassphrase :: MaybeT IO ()
askPassphrase = do lift $ putStrLn "Insert your new passphrase:"
                   value <- getPassphrase
                   lift $ putStrLn "Storing in database..."
