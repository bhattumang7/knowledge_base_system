
package in.umang;

import java.sql.*;

/**
 *
 * @author umang
 */
public class Database
{

    public static Connection getConnection()
    {
        Connection aConnection = null;
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            aConnection = DriverManager.getConnection("jdbc:mysql://localhost:3306/WDAJ", "root", "");
            if(aConnection==null)
            {
                throw new Exception();
            }
        }
        catch (Exception e)
        {
            RuntimeException aRuntimeException = new RuntimeException("Could not load connection");
            aRuntimeException.setStackTrace(e.getStackTrace());
            System.out.println("Error " + e );
        }
        return aConnection;

    }
}
