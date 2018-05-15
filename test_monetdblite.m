% matlab_monetdblite software is distributed under the MIT License (MIT): see LICENSE file 
% monetdb software copyrighted: https://www.monetdb.org/blog/monetdblite-for-java

% inspired and/or copied from https://github.com/hannesmuehleisen/MonetDBLite-Java

monetdblite_java_driver

import nl.cwi.monetdb.embedded.env.MonetDBEmbeddedDatabase.*
import nl.hanoostdijk.monetdblite_matlab.*

startDatabase("D:\\data\\R\\Open_Data_Aveen\\MonetDBLitedatabase", true, false);
connection = createConnection();
connection.executeUpdate("CREATE TABLE examplex (words text, counter int)");
connection.close();
stopDatabase();

startDatabase("D:\\data\\R\\Open_Data_Aveen\\MonetDBLitedatabase", true, false);
connection = createConnection();

connection.startTransaction();
numberOfInsertions = connection.executeUpdate( ...
    " INSERT INTO examplex VALUES ('monetdb', 1), ('java', 2) ") ;
numberOfInsertions
connection.commit();

connection.startTransaction();
numberOfInsertions = connection.executeUpdate( ...
    " INSERT INTO examplex VALUES ('han', 3), ('may', 4),('bert', 5), ('aukje', 6)");
numberOfInsertions
connection.rollback();

qrs = connection.executeQuery("SELECT * FROM examplex");
numberOfRows = qrs.getNumberOfRows() , numberOfColumns = qrs.getNumberOfColumns() 
% methods(qrs)
% methodsview(qrs)

ctypes  = javaArray('java.lang.String',numberOfRows);
qrs.getColumnTypes(ctypes);
ctypes

words  = javaArray('java.lang.String',numberOfRows);
qrs.getStringColumnByIndex(1,words);
words

methods('nl.hanoostdijk.monetdblite_matlab.mm','-full')

retcounts = mm.getIntColumnByIndex(qrs,2,numberOfRows) 

qrs.close(); % or close(qrs)

connection.close();
stopDatabase();