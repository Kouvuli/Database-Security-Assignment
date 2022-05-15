package Service;

import Entities.Employee;
import Utils.HibernateUtils;
import Utils.JDBCUtils;
import org.hibernate.Session;
import org.hibernate.query.NativeQuery;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HexFormat;
import java.util.List;

public class AuthenService {
    public List<Employee> authenticateEmployee(String username, String password) throws SQLException {
        JDBCUtils utils=new JDBCUtils();
        Connection connection = utils.getConnection();
        Statement stmt = null;
        List<Employee> resultList=new ArrayList<>();
        try {
            stmt = connection.createStatement();
            String query = "EXEC SP_AUTHEN_NHANVIEN " + username + "," + password;
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                Employee e=new Employee(rs.getString("MANV"),rs.getString("HOTEN"),rs.getString("EMAIL"),HexFormat.of().parseHex(rs.getString("LUONG").substring(2)),rs.getString("TENDN"), HexFormat.of().parseHex(rs.getString("MATKHAU").substring(2)),rs.getString("PUBKEY"));
                resultList.add(e);
            }
        }catch (SQLException exception) {
            exception.printStackTrace();
        }finally {
            stmt.close();
        }
        return resultList;

    }
}
