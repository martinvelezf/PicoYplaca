import Data.Time
import Data.Time.Calendar.WeekDate
import Data.List.Split
import Text.Read

getLastNumber=head.reverse

--getDay [year,mounth,day] = fromGregorian year mounth day 

        
covertDatetoDay date=x 
    where 
        arraydate=(splitOn "-" date)
        tls=map (read::String->Int) $tail arraydate
        hd=(read::String->Integer) (head arraydate)
        x=toWeekDate (fromGregorian hd (tls!!0) (tls!!1) )



checktime time=x
    where 
        arraytime=map (read::String->Int)(splitOn ":" time)
        x=timeRoad  $((arraytime!!0)*100)+(arraytime!!1) 
        
timeRoad x
    | ((x>=700) && (x<=930)) || ((x>=1600) && (x<=1930)) =False    
    |otherwise = True