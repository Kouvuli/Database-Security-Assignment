package Controllers;

import DAO.MarkDAO;
import DAO.CourseDAO;
import DAO.StudentDAO;
import Entities.Course;
import Entities.Student;
import Models.MarkRow;
import Service.CryptoService;
import Utils.HashUtil;
import javafx.collections.FXCollections;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.text.Text;
import javafx.stage.Modality;
import javafx.stage.Stage;

import java.io.IOException;
import java.net.URL;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.ResourceBundle;

public class InsertItemController implements Initializable {
    @FXML
    private TableColumn<MarkRow, String> courseIdCol;

    @FXML
    private TableColumn<MarkRow, String> courseNameCol;

    @FXML
    private TableColumn<MarkRow, Button> editCol;

    @FXML
    private TableColumn<MarkRow, Float> markCourseCol;

    @FXML
    private TableView<MarkRow> markTable;

    @FXML
    private Text studentId;

    @FXML
    private Text classId;

    private String maSV;
    private Student student;
    @FXML
    private TableColumn<MarkRow, String> tcCourseCol;

    @FXML
    void cancelHandler(ActionEvent event) {
        Stage window=(Stage) ((Node)event.getSource()).getScene().getWindow();
        window.close();
    }


    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        studentId.setText(student.getId());
        classId.setText(student.getClassroom().getId());
        MarkDAO markDAO =new MarkDAO();
        HashUtil hashUtil=new HashUtil();
        ;
        CryptoService cryptoService=new CryptoService();
        List<Object[]> bangDiemList= markDAO.getMarkByStudentId(student.getId());

        List<MarkRow> rowList=new ArrayList<>();

        for (Object[] i:bangDiemList) {
            String maSV=(String)i[0];
            String maHP=(String)i[1];
            byte[] diemEncrypt=(byte[])i[2];
            String a=hashUtil.bytesToHex(diemEncrypt);
            String diem=null;
            try {
                diem= cryptoService.decryptRSA(MainViewController.pubKey,a, MainViewController.priKey);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            Image img = new Image("/Images/Pencil.png");
            ImageView imageView=new ImageView(img);
            imageView.setFitHeight(14);
            imageView.setPreserveRatio(true);
            Button editBtn=new Button();
            editBtn.setGraphic(imageView);
            addEditBtnHandler(editBtn,maSV,maHP,diem);

            CourseDAO courseDAO =new CourseDAO();
            Course course = courseDAO.getCourseById(maHP);
            MarkRow r = new MarkRow(course.getId(), course.getName(), course.getCertNum(), Float.parseFloat(diem), editBtn);
            rowList.add(r);
        }

        courseIdCol.setCellValueFactory(new PropertyValueFactory<MarkRow,String>("id"));
        courseNameCol.setCellValueFactory(new PropertyValueFactory<MarkRow,String>("name"));
        markCourseCol.setCellValueFactory(new PropertyValueFactory<MarkRow, Float>("mark"));
        tcCourseCol.setCellValueFactory(new PropertyValueFactory<MarkRow,String>("certNum"));
        editCol.setCellValueFactory(new PropertyValueFactory<MarkRow,Button>("editBtn"));

        markTable.setItems(FXCollections.observableArrayList(rowList));

    }

    public void addEditBtnHandler(Button editBtn,String maSV,String maHP,String diem){
        editBtn.setOnAction(event -> {
            Stage window = new Stage();
            window.initModality(Modality.APPLICATION_MODAL);
            FXMLLoader loader=new FXMLLoader(getClass().getResource("/Layouts/mark-view.fxml"));
            MarkController controller=new MarkController();
            controller.setValue( maSV, maHP, diem);
//            controller.setValue(bangDiem);
            loader.setController(controller);

            Parent root= null;
            try {
                root = loader.load();
            } catch (IOException e) {
                e.printStackTrace();
            }

            Scene editScene = new Scene(root);
            window.setScene(editScene);
            window.show();
        });
    }
    @FXML
    void saveHandler(ActionEvent event) {

        Stage window=(Stage) ((Node)event.getSource()).getScene().getWindow();
        window.close();
    }
    public void setValue(String maSV){
        this.maSV=maSV;
        StudentDAO dao=new StudentDAO();
        student =dao.getStudentById(maSV);
    }
}
