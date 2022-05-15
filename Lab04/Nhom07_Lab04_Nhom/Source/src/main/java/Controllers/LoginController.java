package Controllers;

import Entities.Employee;
import Service.AuthenService;
import Utils.HashUtil;
import javafx.beans.value.ChangeListener;
import javafx.beans.value.ObservableValue;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.scene.control.TextField;
import javafx.stage.Stage;

import java.io.IOException;
import java.net.URL;
import java.util.List;
import java.util.ResourceBundle;

public class LoginController implements Initializable {
    @FXML
    private TextField password;

    @FXML
    private TextField username;

    @FXML
    void cancelHandler(ActionEvent event) {
        Stage window=(Stage) ((Node)event.getSource()).getScene().getWindow();
        window.close();
    }

    @FXML
    void loginHandler(ActionEvent event) throws IOException {
        if(!isValidInput()){
            Alert alert = new Alert(Alert.AlertType.ERROR);
            alert.setTitle("Lỗi");
            alert.setContentText("Dữ liệu nhập không hợp lệ!");
            alert.showAndWait();
        }else{
//            EmployeeDAO dao=new EmployeeDAO();
            AuthenService authenService=new AuthenService();
            HashUtil hashUtil=new HashUtil();
            try{
                List<Employee> employeeList = authenService.authenticateEmployee(username.getText(),hashUtil.getSHA1(password.getText()));
                if(employeeList.isEmpty()){
                    Alert alert = new Alert(Alert.AlertType.ERROR);
                    alert.setTitle("Lỗi");
                    alert.setContentText("Tên đăng nhập và mật khẩu không hợp lệ!");
                    alert.showAndWait();
                    return;
                }
                else{
                    Stage window=(Stage) ((Node)event.getSource()).getScene().getWindow();
                    window.close();
                    Stage newWindnow = new Stage();

                    FXMLLoader loader=new FXMLLoader(getClass().getResource("/Layouts/main-view.fxml"));
                    MainViewController controller=new MainViewController();
                    controller.setValue(username.getText());
                    loader.setController(controller);

                    Parent root=loader.load();
//        UserEditDialogController controller=loader.getController();

//        window.setUserData(username.getText());

                    Scene editScene = new Scene(root, 500, 350);
                    newWindnow.setScene(editScene);
                    newWindnow.show();
                }
            }
            catch (Exception e){
                Alert alert = new Alert(Alert.AlertType.ERROR);
                alert.setTitle("Lỗi");
                alert.setContentText("Tên đăng nhập và mật khẩu không hợp lệ!");
                alert.showAndWait();
            }

        }

    }

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        password.textProperty().addListener(new ChangeListener<String>() {
            @Override
            public void changed(final ObservableValue<? extends String> ov, final String oldValue, final String newValue) {
                if (password.getText().length() > 35) {
                    String s = password.getText().substring(0, 35);
                    password.setText(s);
                }
            }
        });
        username.textProperty().addListener(new ChangeListener<String>() {
            @Override
            public void changed(final ObservableValue<? extends String> ov, final String oldValue, final String newValue) {
                if (username.getText().length() > 35) {
                    String s = username.getText().substring(0, 35);
                    username.setText(s);
                }
            }
        });
    }
    public boolean isValidInput(){
        if(username.getText().isEmpty()){
            return false;
        }
        else if(password.getText().isEmpty()){
            return false;
        }
        return true;
    }
}
