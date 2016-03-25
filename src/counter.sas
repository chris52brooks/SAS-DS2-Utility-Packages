/************************************************************************/
/*																		*/
/* Name: Counter.sas 													*/
/*  																	*/
/* Author: Chris Brooks, Copyright 2015									*/
/*  																	*/
/* Purpose: To facilitate the creation and use of counter variables 	*/
/*																		*/
/* Notes: Before compilation decalre a libaray called bin to hold the	*/
/* 		  Compioled package and set the macro variable overwite_mode	*/
/*        To yes 														*/
/*																		*/
/************************************************************************/

proc ds2;
package bin.counter /overwrite=&overwrite_mode;
	dcl int count;
	dcl int increment;

/* Default constructor   */
	method counter();
		count=0;
		increment=1;
	end;

/* Full constructor   */
	method counter(int startvalue, int startincrement);
		count=startvalue;
		increment=startincrement;
	end;

/* Add and subtract methods   */
	method add();
		count=count+increment;
	end;
  
	method subtract();
		count=count-increment;
	end;

/* Reset method to return to default constructor state   */
	method reset();
    	count=0;
    	increment=1;
	end;
	
/* Full reset method to set counter to arbitrary state	 */
	method reset(int startvalue, int startincrement);
    	count=startvalue;
		increment=startincrement;
	end;

/* Method to return current value of count - sometimes */
/* this will be preferable to using get_count() method */
	
	method tally() returns int;
		return count;
	end; 

endpackage;
run;
quit;