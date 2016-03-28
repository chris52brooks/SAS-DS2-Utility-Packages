proc ds2;
package intRange /overwrite=yes;
	dcl int lowerBound;
	dcl int upperBound;
	forward isvalid;
	
	method intrange();
		lowerBound=0;
		upperBound=0;	
	end;
	
	method intrange(int new_start, int new_end);
		if isvalid(new_start, new_end) then do;
			lowerBound=new_start;
			upperBound=new_end;
		end;
		else do;
			put 'ERROR: end point of range must not be less than start point';
			stop;
		end;
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
run;
quit;


proc ds2;
	
	data _null_;

	
		method run();		
			dcl package intrange years(2000,2005);
			if years.inrange(2005) then put 'right';
			else put 'wrong';
			if years.containsrange(2000,2005) then put 'OK';
			else put 'outside';
			if years.isinsiderange(2001,2010) then put 'inside';
			else put 'outside';
		end;
	enddata;
	
	

run;
quit;
