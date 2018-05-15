# matlab_monetdblite
MATLAB functions that use the java driver for access to MonetDBLite database

## MonetDB
The [Wikipedia entry](https://en.wikipedia.org/wiki/MonetDB) says the following about [MonetDB](https://www.monetdb.org/):  
MonetDB is an open source column-oriented database management system developed at the Centrum Wiskunde & Informatica (CWI) 
in the Netherlands. It was designed to provide high performance on complex queries against large databases, 
such as combining tables with hundreds of columns and millions of rows. 
MonetDB has been applied in high-performance applications for online analytical processing, data mining, 
geographic information system (GIS), Resource Description Framework (RDF), text retrieval and sequence alignment processing.  
Web

## MonetDBLite for Java
[MonetDBLite-for-Java](https://www.monetdb.org/blog/monetdblite-for-java) is one of the 'Lite' versions of MonetDB. These versions load as a library into R, Python, and Java, where they can be used as an alternative for SQLite.  
The [blog entry](https://www.monetdb.org/blog/monetdblite-for-java) mentions two APIs: an embedded API (non-standard) and the standard JDBC API. I have only looked at the first one (because I did not want to use a full MonetDB database).

## MonetDBLite 'for' MATLAB
When trying to use the Java version in MATLAB, I noticed that, probably due to the peculiarities of the MATLAB-JAVA interface,  some methods did not work. As an example: it was possible to open a recordset and read a string column (field) but an accompanying integer column could not be read. This was caused by the fact that it is not possible in MATLAB to pass an array of integers (by reference and not by value) as a parameter.
I solved this by programming a small Java package that does the conversion for this particular method and act as a wrapper.

This repository is not a full MATLAB solution for working with a MonetDBLite database, but shows how this problem can be circumvented. The user should handle other 'problem' methodes in the same way. 

I did not succeed in finding a solution in MATLAB that directly uses the MonetDBLite software without intermediary Java code. I would appreciate such solution.

The following extract shows :  

     numberOfRows  = 2 ;
     words         = javaArray('java.lang.String',numberOfRows);
     qrs.getStringColumnByIndex(1,words) ;
     words
     counterValues = zeros(numberOfRows,1) ;
     qrs.getIntColumnByIndex(2, counterValues);
     counterValues
The `getStringColumnByIndex` method works fine, but the `getIntColumnByIndex` does not do anything. The conversion methods is called like:  

     counterValues = package.getIntColumnByIndex(qrs,2,numberOfRows) ;
and works fine.

This repository shows 