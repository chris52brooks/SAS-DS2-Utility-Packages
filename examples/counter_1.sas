data class;
	set sashelp.class;
run;
libname bin "/folders/myfolders/UtilityPackages/bin";

proc ds2;

data _null_;
  dcl package bin.counter boycounter();
  dcl package bin.counter girlcounter();
    
  method run();
  	dcl int nummales;
  	dcl int numfemales;
  	
    set class;
    if sex='M' then boycounter.add();
    else girlcounter.add();
  end;

  method term();
  	dcl int nummales;
  	dcl int numfemales;
  	
  	nummales=boycounter.tally();
  	numfemales=girlcounter.tally();
  	put nummales=;
  	put numfemales=;
  end;
enddata;
run;
quit;
