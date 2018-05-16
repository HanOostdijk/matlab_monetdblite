# matlab_monetdblite
MATLAB functions that use the Java driver for access to MonetDBLite database. 
See also [matlab_mongodb](https://github.com/HanOostdijk/matlab_mongodb).

Hannes Mühleisen has made available a Java driver for the MonetDBLite database (details below).
Some methods are not directly usable in the MATLAB environment. In those cases a wrapper method has to be used.
This repository shows how a Java wrapper function can be created and how to use the original driver software and 
the wrapper method(s). 

If you think to find here a full MATLAB solution to access a MonetDBLite database, you will probably be disappointed: 
in most cases you will need to create some additional wrapper methods for methods that do not work out of the box.

## MonetDB
The [Wikipedia entry](https://en.wikipedia.org/wiki/MonetDB) says the following about [MonetDB](https://www.monetdb.org/):  
MonetDB is an open source column-oriented database management system developed at the Centrum Wiskunde & Informatica (CWI) 
in the Netherlands. It was designed to provide high performance on complex queries against large databases, 
such as combining tables with hundreds of columns and millions of rows. 
MonetDB has been applied in high-performance applications for online analytical processing, data mining, 
geographic information system (GIS), Resource Description Framework (RDF), text retrieval and sequence alignment processing.  

## MonetDBLite for Java
[MonetDBLite-for-Java](https://www.monetdb.org/blog/monetdblite-for-java) is one of the 'lite' versions of MonetDB. 
These versions load as a library into R, Python, and Java, where they can be used as an alternative for SQLite.  
The [blog entry](https://www.monetdb.org/blog/monetdblite-for-java) mentions two APIs: an embedded API (non-standard) and 
the standard JDBC API. I have only looked at the first one (because I did not want to use a full MonetDB database).
The [repository of MonetDBLite for Java](https://github.com/hannesmuehleisen/MonetDBLite-Java)  is on [GitHub] and it contains 
a lot of examples in the README.md file
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
The `getStringColumnByIndex` method works fine, but the `getIntColumnByIndex` does not do anything. Therefore we have created a Java package with a static method with the same name that we call in the following way:  

     counterValues = mm.getIntColumnByIndex(qrs,2,numberOfRows) ;
and this works fine. In the call you see the following changes in the parameters:

* the new method is static instead of a class method for QueryResultSet and therefore we insert the result set it is working on as the first parameter
* the second parameter in the old method `counterValues` should be an array of `int`s. Because this is not possible in MATLAB we replace this parameter with the size of the array and we will create this array in the Jave code
* the output parameter will now contain the array after processing by the original `getIntColumnByIndex`
 
