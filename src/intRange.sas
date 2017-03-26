

proc ds2;
package intRange /overwrite=yes;
	dcl private int lowerBound;
	dcl private int upperBound;
	dcl private int pointer;
	forward isvalid;
	forward reset;

/* Constructor	 */

	method intrange(int new_start, int new_end);
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

/* Start must be before end */

	method isValid(int test_start, int test_end) returns int;
		if test_end >= test_start then return 1;
		else return 0;
	end;
	
	method getUpperBound() returns int;
		return upperBound;	
	end;
	
	method getLowerBound() returns int;
		return lowerbound;
	end;

/* Tests if a single value is inside the range	*/

	method inRange(int testval) returns int;
		if lowerBound <= testval <= upperBound then return 1;
		else return 0;
	end;

/* Check for complete equality	 */

	method isequal(int test_start, int test_end) returns int;
		if test_start=lowerBound and test_end=upperBound then return 1;
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

	
	method isInsideRange(package intrange inrange) returns int;
		if ((inrange.getLowerBound() <= lowerBound) and (inrange.getUpperBound() >= upperBound)) then return 1;
		else return 0;
	end;

/* Check for overlap	 */
	method overlaps(package intrange inrange) returns int;
		if (inrange.getLowerBound() <= upperBound) and (inrange.getUpperBound() >= lowerBound) then return 1;
		else return 0;
	end;

/* Iterate through the range	 */

	method foreach() returns int;
		if pointer<=getUpperBound() then pointer=pointer+1;
		return pointer-1;
	end;
	
	method reset_pointer(int new_pointer);
		if inrange(new_pointer) then pointer=new_pointer;
	end;
	
	method print();
		put '**********************************';
		put 'lowerBound =' lowerBound;
		put 'upperBound =' upperBound;
		put '**********************************';
	end;
	
run;
quit;


proc ds2;
	
	data _null_;

	
		method run();		
			dcl package intrange yearsa(2000,2005);
			dcl package intrange yearsb(2006,2010);
			dcl int i;
			
			if yearsa.overlaps(yearsb) then put 'overlap';

			
			do i = yearsa.getLowerBound() to yearsa.getUpperBound();
				rc1=yearsa.foreach();
				put rc1=;
			
			end;

			
		end;
	enddata;
	
	

run;
quit;
