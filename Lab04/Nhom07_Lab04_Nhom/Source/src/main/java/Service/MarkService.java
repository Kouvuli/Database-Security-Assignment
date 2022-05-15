package Service;

import Utils.JDBCUtils;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class MarkService {

    public void updateMark(String maSV, String maHP, String diem) throws SQLException {
        JDBCUtils utils=new JDBCUtils();
        Connection connection = utils.getConnection();
        Statement stmt = null;
        try {
            stmt = connection.createStatement();
            String query = "EXEC SP_UPDATE_BANGDIEM_SINHVIEN "+maSV+","+maHP+","+diem;
            stmt.execute(query);
        }finally {
            stmt.close();
        }

    }
}
