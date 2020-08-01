{-# LANGUAGE BangPatterns #-}
module Main where
import Test.Tasty


import           Control.Monad
import           Data.Semigroup
import Data.Text  (Text)
import qualified Data.Text  as Text
import qualified Data.Text.IO     as Text
import           Text.Printf

import Test.Hspec
import GHC.Base 
import Checker
import Foreign.Marshal.Unsafe
--import Test

readExamples :: IO [(Text, Text,Text,Text)]
readExamples =
  Control.Monad.mapM asPair =<< Text.lines <$> Text.readFile "tests.csv"
  where
    asPair line =
      case Text.splitOn (Text.pack ",") line of
        [input1,input2,input3,expected] -> pure (input1,input2,input3,expected)
        _ -> fail ("Invalid example line: " <> Text.unpack line)

main :: IO ()
main = hspec $ do
  describe "Prelude.read" $ do
    examples <- runIO readExamples
    forM_ examples $ \(input1,input2,input3,expected) ->
        it (printf "picoplaca '%s' '%s' '%s' to '%s'" input1 input2 input3 expected) $
        unsafeLocalState (picoplaca (Text.unpack input1) (Text.unpack input2) (Text.unpack input3))  `shouldBe` (Text.unpack expected)
   