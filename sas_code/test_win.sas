libname f ".\";
proc import
	%put ~~~~~~~~~~~~ INPUT &fname ~~~~~~~~~~~~;
	datafile = "C:\Users\yzhang96\Downloads\PUMS_5percent\PUMS5_01.TXT"
	out = f.tmp
	DBMS = dlm
	replace;
	delimiter='09'x;
	run;