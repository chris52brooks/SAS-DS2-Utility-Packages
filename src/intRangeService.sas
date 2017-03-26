proc ds2;
	package intRangeService / overwrite=yes;
	
/* 	Returns an exact copy of the input parameter package */
		method clone(package intRange toclone) returns package intRange;
			dcl int lowerBound;
			dcl int upperBound;
			dcl private package intRange outRange;
			
			upperBound=toclone.getUpperBound();
			lowerBound=toclone.getlowerBound();
			outRange = _new_ [this] intRange(lowerBound,upperBound);
			
			return outRange;	
		end;
	endpackage;
run;
quit;