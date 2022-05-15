package Utils;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class JDBCUtils {
    private Connection connection;
    public JDBCUtils(){

    }
    public Connection getConnection() {

        try {
            // Load the JDBC driver
            String driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
            Class.forName(driverName);

            // Create a connection to the database
            String url="jdbc:sqlserver://"+ InetAddress.getLocalHost().getHostName()+";databaseName=QLSVNhom;integratedSecurity=true;encrypt=true;trustServerCertificate=true;";
//            String url="jdbc:sqlserver://"+ InetAddress.getLocalHost().getHostName()+";databaseName=QLSV;integratedSecurity=true;";
            String username = "";
            String password = "";
            connection = DriverManager.getConnection(url);


        } catch (SQLException exception) {
            exception.printStackTrace();
        } catch (ClassNotFoundException exception) {
            exception.printStackTrace();
        } catch (UnknownHostException e) {
            e.printStackTrace();
        }
        return connection;
    }

}
