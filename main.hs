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