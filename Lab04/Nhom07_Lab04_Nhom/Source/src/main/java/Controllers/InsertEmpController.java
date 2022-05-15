package Controllers;

import DAO.EmployeeDAO;
import Entities.Employee;
import Service.CryptoService;
import Utils.HashUtil;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.Node;
import javafx.scene.control.Alert;
import javafx.scene.control.TextField;
import javafx.stage.Stage;

import java.net.URL;
import java.sql.SQLException;
import java.util.HexFormat;
import java.util.ResourceBundle;

public class InsertEmpController implements Initializable {
    @FXML
    private TextField empEmail;

    @FXML
    private TextField empId;

    @FXML
    private TextField empName;

    @FXML
    private TextField empSal;

    @FXML
    private TextField empPassword;

    @FXML
    private TextField empUsername;
    @FXML
    void cancelHandler(ActionEvent event) {
        Stage window=(Stage) ((Node)event.getSource()).getScene().getWindow();
        window.close();
    }

    @FXML
    void saveHandler(ActionEvent event) throws SQLException {
        if(!isValidInput()){
            Alert alert = new Alert(Alert.AlertType.ERROR);
            alert.setTitle("Lỗi");
            alert.setContentText("Input không hợp lệ!");
            alert.showAndWait();
        }else{
            EmployeeDAO dao=new EmployeeDAO();
            Employee employee=null;
            try {
                employee = dao.getEmployeeById(empId.getText());
            }
            catch (Exception e){
                if (employee!=null){
                    Alert alert = new Alert(Alert.AlertType.ERROR);
                    alert.setTitle("Lỗi");
                    alert.setContentText("Mã nhân viên đã tồn tại!");
                    alert.showAndWait();
                }
                else{
                    CryptoService cryptoService=new CryptoService();
                    HashUtil hashUtil=new HashUtil();
                    String hashPassword=hashUtil.getSHA1(empPassword.getText());
                    cryptoService.createKey(empId.getText(), hashPassword);
                    String encryptSal=cryptoService.encryptRSA(empId.getText(),empSal.getText(),hashPassword);
                    Employee newEmployee = new Employee(empId.getText(), empName.getText(), empEmail.getText(), HexFormat.of().parseHex(encryptSal.substring(2)), empUsername.getText(), HexFormat.of().parseHex(hashPassword.substring(2)), empId.getText());
                    dao.addData(newEmployee);
                    Stage window=(Stage) ((Node)event.getSource()).getScene().getWindow();
                    window.close();
                }
            }
            if(employee!=null){
                Alert alert = new Alert(Alert.AlertType.ERROR);
                alert.setTitle("Lỗi");
                alert.setContentText("Username đã tồn tại!");
                alert.showAndWait();
            }

        }


    }

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {

    }
    public boolean isValidInput(){
        if(empId.getText().isEmpty()){
            return false;
        }
        else if(empEmail.getText().isEmpty()){
            return false;
        }
        else if(empName.getText().isEmpty()){
            return false;
        }
        else if(empUsername.getText().isEmpty()){
            return false;
        }
        else if (empPassword.getText().isEmpty()){
            return false;
        }
        else if (empSal.getText().isEmpty()){
            return false;
        }
        return true;
    }
}
