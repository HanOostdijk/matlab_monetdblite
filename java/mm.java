
package nl.hanoostdijk.monetdblite_matlab;

import nl.cwi.monetdb.embedded.env.MonetDBEmbeddedException;
import nl.cwi.monetdb.embedded.resultset.QueryResultSet;

public class mm {
    
    public static int[] getIntColumnByIndex(QueryResultSet rs,int index,int numint) throws MonetDBEmbeddedException {
        /* call from matlab : 
            import nl.hanoostdijk.monetdblite_matlab.*
            retcounts = mm.getIntColumnByIndex(qrs,2,numberOfRows) 
        */
        int[] intvec = new int[numint];
        rs.getIntColumnByIndex(index,intvec); 
        return intvec;
    }
   
}

