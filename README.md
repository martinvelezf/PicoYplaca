# PicoYplaca
To test this program you must install hspec, you can do it with this command

cabal update && cabal install hspec

There are 3 principal files, 
	>Check.hs contains all the functions to check if a vehicle can road.
	>Main.hs Runs the test case write in csv
	>test.csv has all the case, and its is possible to add other test case follow the next structure {plate,date,time,expected} 
	(ex: 1dr-p435,20-10-12,9:20,Puede manejar)
	
		*the plate is a string of 8(cars) or 6(motocycle) caracters, in the case of cars the last caracter is a number, in the case of motocycle is one before the last one. The car format plate is (xxx-xxxd)
		
		*the time is any number which follows this format hh:mm, however the program accept strings of this format to hh:mm:ss
		
		*the date follows clasical format 'yyyy-mm-dd' or 'yy-mm-dd' or variantion any variation with 'yy*-mm*-dd*'. HOWEVER if the year is representate with just a number for example  9-09-08, the program take the last year which ends with 9 as 2009, in the case that the mounth >12 the program will take as 12. The same happens for day, it will rake the last day of the mounth, for example 2020-13-32 is equivalent to this date 2020-12-31.
 		
		* the expected  is the answer that give the program, in case that the car can road is "Puede manejar", if not "No puede manejar". In the case the hour is not real, or plate do not follow the rule, or bad format of date the expected is "Datos mal ingresados".


*** Run the file *****

cabal exec runhaskell Main.hs (It will show the answers of the test write in csv file)

*** Running with gchi *****

ghci Checker.hs

*Checker> picoplaca "123-4567" "2020-07-30" "23:45"


