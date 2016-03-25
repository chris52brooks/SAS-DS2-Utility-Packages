libname _all_ clear ;

libname bin "/folders/myfolders/UtilityPackages/bin";

filename src "/folders/myfolders/UtilityPackages/src";
%let overwrite_mode=yes;

%include src(counter.sas);