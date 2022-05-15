package Controllers;

import Entities.Employee;
import Service.CryptoService;
import Utils.HashUtil;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.text.Text;

import java.net.URL;
import java.sql.SQLException;
import java.util.ResourceBundle;

public class EmpDetailController implements Initializable {
    @FXML
    private Text empEmail;

    @FXML
    private Text empId;

    @FXML
    private Text empName;

    @FXML
    private Text empSal;

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {

    }

    public void setValue(Employee employee) throws SQLException {
        CryptoService cryptoService=new CryptoService();
        HashUtil hashUtil=new HashUtil();
        String sal=null;
        try{

            sal=cryptoService.decryptRSA(MainViewController.pubKey,hashUtil.bytesToHex(employee.getSalary()),MainViewController.priKey);
        }
        catch (Exception e){

        }
        if(sal==null){
            empSal.setText("Không hiển thị");
        }else{

            empSal.setText(sal);
        }
        empId.setText(employee.getId());
        empName.setText(employee.getName());
        empEmail.setText(employee.getEmail());
    }
}
