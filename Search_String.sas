%let search_string = Libname;
%let suffix = sas;
/* %let prefix=    */
%let path=C:\sas ;
filename finp ("&path\*.&suffix" ); /* det går att skriva flera sökväg */
*filename finp( "&path\*.&suffix" , "C:\Users\sweroz\*.&suffix"); 
options symbolgen;

data results;
     length fname _filepath $200;
     infile finp filename = _filepath eov=_eov truncover;
     input a_line $200.;
     fname = _filepath;
     
     if _eov=1 then do;
       _n=0;
       _eov=0;
     end;
     _n+1;
     
     if find(a_line,"&search_string",'i')
     then output;
     keep _n a_line fname;
run;     
