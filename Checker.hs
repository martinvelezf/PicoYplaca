module Checker where
import Data.Time
import Data.Time.Calendar.WeekDate
import Data.List.Split
import Text.Read

import Control.Exception.Base


getLastNumber :: String -> Int
getLastNumber x
    |length x== 8 = (read::String->Int) [(head.reverse) x] --get las number of a plate car
    |length x== 6 = (read::String->Int) [(head.tail.reverse) x] --get las number of a plate motcycle

--get the day of weekend of a date
covertDatetoDay date=x  
    where 
        arraydate=(splitOn "-" date)
        tls=map (read::String->Int) $tail arraydate
        hd=(read::String->Integer) (head arraydate)
        (_,_,x)=toWeekDate (fromGregorian hd (tls!!0) (tls!!1) )

--check if the time is correct 
checktime time
    |(arraytime!!1)<60 = x
    where 
        arraytime=map (read::String->Int)(splitOn ":" time)
        x=timeRoad  $((arraytime!!0)*100)+(arraytime!!1) 

--check if the time has some restriction        
timeRoad x
    | ((x>=700) && (x<=930)) || ((x>=1600) && (x<=1930)) =False    
    | x<2400 && x>=0 = True

    --ckeck if the plate have a restriction in the current day
checkDayPlate day last
    | foldr (\x y -> (x==(day,last))|| y) False [(1,1),(1,2),(2,3),(2,4),(3,5),(3,6),(4,7),(4,8),(5,9),(5,0)] =False
    | otherwise = True

--check if it is possible road
checkRoad plate day time =
    let n = getLastNumber plate
        dayweek = covertDatetoDay day
        ans= checkDayPlate dayweek n
        in  if (checktime time)
             then if (ans)
                 then "Puede manajar"
                 else  "No puede manajar" 
             else "Puede manajar"

--Check if the user write good the data
handleErrors plate day time= do
    let handler :: SomeException -> IO [Char]
        handler e = do
           return "Datos mal ingresados:"
    res <- (evaluate ((checkRoad plate day time)) ) `catch` handler
    return res



