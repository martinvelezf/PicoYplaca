module Checker where
import Data.Time
import Data.Time.Calendar.WeekDate
import Data.List.Split
import Text.Read
import Control.DeepSeq
import Control.Exception.Base
import Control.Monad.IO.Class

getLastNumber :: String -> Int
getLastNumber x
    |length x== 8 = (read::String->Int) [(head.reverse) x] --get las number of a plate car
    |length x== 6 = (read::String->Int) [(head.tail.reverse) x] --get las number of a plate motcycle

--get the day of weekend of a date
covertDatetoDay :: [Char] -> Int
covertDatetoDay date=x  
    where 
        arraydate=(splitOn "-" date)
        tls=map (read::String->Int) $tail arraydate
        hd=(read::String->Integer) (head arraydate)
        (_,_,x)=toWeekDate (fromGregorian hd (tls!!0) (tls!!1) ) --return just the number of day in days of weeks (1-7)

--check if the time is correct 
checktime :: [Char] -> Bool
checktime time
    |(arraytime!!1)<60 = x
    where 
        arraytime=map (read::String->Int)(splitOn ":" time)
        x=timeRoad  $((arraytime!!0)*100)+(arraytime!!1) 

--check if the time has some restriction
timeRoad :: Int-> Bool        
timeRoad x
    | ((x>=700) && (x<=930)) || ((x>=1600) && (x<=1930)) =False    
    | x<2400 && x>=0 = True

    --ckeck if the plate have a restriction in the current day
checkDayPlate ::  Int -> Int -> Bool
checkDayPlate day last
    | foldr (\x y -> (x==(day,last))|| y) False [(x,y)|x<-[1..5],y<-[0..10],y==(2*x) `mod` 10 ||y==(2*x)-1 ] =False --check all the posible combination of day that the user cannot road according to the number of plate and the number of day
    | otherwise = True

--check if it is possible road
checkRoad :: String -> [Char] -> [Char] -> [Char]
checkRoad plate day time =
    let n = ( getLastNumber plate)
        dayweek = covertDatetoDay day
        ans= checkDayPlate dayweek n
        in  if ( ans)
            then  (checktime time) `deepseq` "Puede manejar" --force the evaluation, to notify if the user write a bad element
            else 
                if (checktime time)
                    then "Puede manejar"
                    else  "No puede manejar" 

--Check if the user write good the data
picoplaca :: String -> [Char] -> [Char] -> IO [Char]
picoplaca plate day time= do
    let handler :: SomeException -> IO [Char]
        handler e = do
           return "Datos mal ingresados"
    res <- (evaluate ((checkRoad plate day time)) ) `catch` handler
    return res



