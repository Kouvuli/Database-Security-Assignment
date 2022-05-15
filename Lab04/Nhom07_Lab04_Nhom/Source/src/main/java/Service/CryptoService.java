package Service;

import Utils.HashUtil;
import Utils.JDBCUtils;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class CryptoService {
    //    genkey
//
//    public String encryptRSA(String pubKey,String value,String password) throws SQLException {
//
//    }
    public void createKey(String keyName, String keyPassword) throws SQLException {
        JDBCUtils utils=new JDBCUtils();
        Connection connection = utils.getConnection();
        Statement stmt = null;
        String encryptResult=null;
        try{
            stmt = connection.createStatement();
            String query="EXEC SP_CREATE_ASYM_KEY '"+keyName+"','"+keyPassword+"'";
            stmt.execute(query);
        } catch (SQLException exception) {
            exception.printStackTrace();
        }finally {
            stmt.close();
        }

    }
    public String encryptRSA(String pubKey,String value,String password) throws SQLException {
        JDBCUtils utils=new JDBCUtils();
        Connection connection = utils.getConnection();
        Statement stmt = null;
        String encryptResult=null;
        try{
            stmt = connection.createStatement();
            String query="EXEC ENCRYPT_RSA_512 '"+pubKey+"',"+value+",'"+password+"'";

            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                String prefix="0x";
                encryptResult=prefix.concat(rs.getString("ENCRYPTVALUE"));
            }

        } catch (SQLException exception) {
            exception.printStackTrace();
        }finally {
            stmt.close();
        }
        return encryptResult;
    }
    public  String decryptRSA(String pubKey,String value,String password) throws SQLException {
        JDBCUtils utils=new JDBCUtils();
        Connection connection = utils.getConnection();
        Statement stmt = null;
        String decryptResult=null;
        try{
            stmt = connection.createStatement();
            String query="EXEC DECRYPT_RSA_512 '"+pubKey+"',"+value+",'"+password+"'";

            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {

                decryptResult=rs.getString("DECRYPTVALUE");
            }

        } catch (SQLException exception) {
            exception.printStackTrace();
        }finally {
            stmt.close();
        }
        return decryptResult;
    }

//    public String encryptAES(String pubKey,String value,String password) throws SQLException {
//        JDBCUtils utils=new JDBCUtils();
//        Connection connection = utils.getConnection();
//        Statement stmt = null;
//        String encryptResult=null;
//        try{
//            stmt = connection.createStatement();
//            String query="EXEC ENCRYPT_AES_256 "+pubKey+","+value+","+password;
//
//            ResultSet rs = stmt.executeQuery(query);
//            while (rs.next()) {
//                String prefix="0x";
//                encryptResult=prefix.concat(rs.getString("ENCRYPTVALUE"));
//            }
//
//        } catch (SQLException exception) {
//            exception.printStackTrace();
//        }finally {
//            stmt.close();
//        }
//        return encryptResult;
//    }
//    public String decryptAES(String pubKey,String value,String password) throws SQLException {
//        JDBCUtils utils=new JDBCUtils();
//        Connection connection = utils.getConnection();
//        Statement stmt = null;
//        String decryptResult=null;
//        try{
//            stmt = connection.createStatement();
//            String query="EXEC DECRYPT_AES_256 "+pubKey+","+value+","+password;
//
//            ResultSet rs = stmt.executeQuery(query);
//            while (rs.next()) {
//
//                decryptResult=rs.getString("DECRYPTVALUE");
//            }
//
//        } catch (SQLException exception) {
//            exception.printStackTrace();
//        }finally {
//            stmt.close();
//        }
//        return decryptResult;
//    }
}
