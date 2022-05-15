package Controllers;

import Entities.Mark;
import Service.CryptoService;
import Service.MarkService;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.Node;
import javafx.scene.control.Alert;
import javafx.scene.control.TextField;
import javafx.stage.Stage;

import java.net.URL;
import java.sql.SQLException;
import java.util.ResourceBundle;

public class MarkController implements Initializable {
    @FXML
    private TextField markTxt;

    private Mark mark;
    private String maSV;
    private String maHP;
    private String diem;
    @FXML
    void cancelHandler(ActionEvent event) {
        Stage window=(Stage) ((Node)event.getSource()).getScene().getWindow();
        window.close();
    }

    @FXML
    void confirmHandler(ActionEvent event) throws SQLException {
        if(!isValidInput()){
            Alert alert = new Alert(Alert.AlertType.ERROR);
            alert.setTitle("Lỗi");
            alert.setContentText("Dữ liệu nhập không hợp lệ!");
            alert.showAndWait();
        }
        else{
            MarkService markService=new MarkService();
            CryptoService cryptoService=new CryptoService();

            if(Float.parseFloat(markTxt.getText())<=10.0 && Float.parseFloat(markTxt.getText())>=0.0){
                markService.updateMark(maSV,maHP,cryptoService.encryptRSA(MainViewController.pubKey,markTxt.getText(), MainViewController.priKey));
                Stage window=(Stage) ((Node)event.getSource()).getScene().getWindow();
                window.close();
            }
            else {
                Alert alert = new Alert(Alert.AlertType.ERROR);
                alert.setTitle("Lỗi");
                alert.setContentText("Điểm không hợp lệ!");
                alert.showAndWait();
            }

        }
    }

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        markTxt.setText(diem);
    }
    public void setValue(String maSV,String maHP,String diem){
        this.maSV=maSV;
        this.maHP=maHP;
        this.diem=diem;
    }
    public boolean isValidInput(){
        if(markTxt.getText().isEmpty()){
            return false;

        }
        return true;
    }

}
