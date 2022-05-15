package Controllers;

import DAO.StudentDAO;
import Entities.Student;
import javafx.collections.FXCollections;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.ListView;
import javafx.scene.input.MouseEvent;
import javafx.scene.text.Text;
import javafx.stage.Modality;
import javafx.stage.Stage;

import java.io.IOException;
import java.net.URL;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.ResourceBundle;

public class StudentListController implements Initializable {
    @FXML
    private ListView<String> studentList;
    @FXML
    private Text studentAddress;

    @FXML
    private Text studentBirthday;

    @FXML
    private Text studentClassId;

    @FXML
    private Text studentName;

    private List<Student> stuList;

    private Student student;
    @FXML
    void backHandler(ActionEvent event) {
        Stage window=(Stage) ((Node)event.getSource()).getScene().getWindow();
        window.close();
    }

    @FXML
    void editHandler(ActionEvent event) {
        Stage window = new Stage();
        window.initModality(Modality.APPLICATION_MODAL);
        FXMLLoader loader=new FXMLLoader(getClass().getResource("/Layouts/edit-item.fxml"));
        EditItemController controller=new EditItemController();
        controller.setValue(student.getId());
        loader.setController(controller);

        Parent root= null;
        try {
            root = loader.load();
        } catch (IOException e) {
            e.printStackTrace();
        }


        Scene editScene = new Scene(root);
        window.setTitle("Sửa sinh viên");
        window.setScene(editScene);
        window.show();
    }

    @FXML
    void markHandler(ActionEvent event) {
        Stage window = new Stage();
        window.initModality(Modality.APPLICATION_MODAL);
        FXMLLoader loader=new FXMLLoader(getClass().getResource("/Layouts/insert-item.fxml"));
        InsertItemController controller=new InsertItemController();
        controller.setValue(student.getId());
        loader.setController(controller);

        Parent root= null;
        try {
            root = loader.load();
        } catch (IOException e) {
            e.printStackTrace();
        }


        Scene scene = new Scene(root);
        window.setTitle("Điểm sinh viên");
        window.setScene(scene);
        window.show();
    }

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        List<String> studentIdList=new ArrayList<>();
        for (Student sv:stuList) {
            studentIdList.add(sv.getId());
        }
        studentList.setItems(FXCollections.observableArrayList(studentIdList));
        studentList.setOnMouseClicked(new EventHandler<MouseEvent>() {
            @Override
            public void handle(MouseEvent mouseEvent) {
                StudentDAO dao=new StudentDAO();
                String maSV = (String) studentList.getSelectionModel().getSelectedItem();
                student =dao.getStudentById(maSV);
                studentName.setText(student.getName());
                studentAddress.setText(student.getAddress());
                DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
                studentBirthday.setText( dateFormat.format(student.getBirthday()));
                studentClassId.setText(student.getClassroom().getId());

            }
        });
    }
    public void setValue(List<Student> list){
        stuList=list;
    }
}
