proc ds2;
package intRange /overwrite=yes;
	dcl int lowerBound;
	dcl int upperBound;
	dcl int pointer;
	forward isvalid;
	forward reset;
	
	method intrange();
		lowerBound=0;
		upperBound=0;
		pointer=0;	
	end;
	
	method intrange(int new_start, int new_end);
		reset(new_start,new_end);
	end;

	method isValid(int test_start, int test_end) returns int;
		if test_end >= test_start then return 1;
		else return 0;
	end;
	
	method max() returns int;
		return upperBound;	
	end;
	
	method min() returns int;
		return lowerbound;
	end;
	
	method reset();
		upperBound=0;
		lowerBound=0;
	end;
	
	method reset(int new_start, int new_end);
		if isvalid(new_start, new_end) then do;
			lowerBound=new_start;
			upperBound=new_end;
			pointer=new_start;
		end;
		else do;
			put 'ERROR: end point of range must not be less than start point';
			stop;
		end;
	end;

/* Tests if a single value is inside the range	 */

	method inRange(int testval) returns int;
		if min() <= testval <= max() then return 1;
		else return 0;
	end;
	
	method isequal(int test_start, int test_end) returns int;
		if test_start=min() and test_end=max() then return 1;
		else return 0;
	end;

/* Tests if a supplied range is inside this range	 */

	method containsRange(int test_start, int test_end) returns int;
		if isvalid(test_start, test_end) then do;
			if inrange(test_start) and inrange(test_end) then return 1;
			else return 0;
		end;
		else return 0;
	end;

/* tests if this range is wholly inside the supplied range	 */

	method isInsideRange(int test_start, int test_end) returns int;
		if isvalid(test_start, test_end) then do;
			if (test_start<=min()) and (test_end >= max()) then return 1;
			else return 0;
		end;
		else return 0;	
	end;
	
	method overlaps(int test_start, int test_end) returns int;
		if isvalid(test_start, test_end) then do;
			if (containsrange(test_start, test_end)) or (isinsiderange(test_start, test_end)) or (inrange(test_start)) or (inrange(test_end))
				then return 1;
			else return 0;
		end;
	end;
	
	method foreach() returns int;
		if pointer<=max() then pointer=pointer+1;
		return pointer-1;
	end;
	
	method reset_pointer(int new_pointer);
		if inrange(new_pointer) then pointer=new_pointer;
	end;
	
run;
quit;


proc ds2;
	
	data _null_;

	
		method run();		
			dcl package intrange years(2000,2005);
			dcl int rc1;
			dcl int rc2;
			if years.inrange(2005) then put 'right';
			else put 'wrong';
			if years.containsrange(2000,2005) then put 'OK';
			else put 'outside';
			if years.isinsiderange(2001,2010) then put 'inside';
			else put 'outside';
			years.reset(2001,2006);
			if years.inrange(2006) then put 'right';
			else put 'wrong';
			if years.overlaps(1998,1999) then put 'overlaps';
			else put 'does not overlap';
			
			do i = years.min() to years.max();
				rc1=years.foreach();
				put rc1=;
			
			end;
/* 			years.coalesce(1800,2004); */
/* 			rc1=years.min(); */
/* 			rc2=years.max(); */
/* 			put rc1=; */
/* 			put rc2=; */
			
			
		end;
	enddata;
	
	

run;
quit;
