package Controllers;

import DAO.ClassDAO;
import Entities.Class;
import Entities.Student;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Hyperlink;
import javafx.scene.text.Text;
import javafx.stage.Modality;
import javafx.stage.Stage;

import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.ResourceBundle;

public class ClassDetailController implements Initializable {
    @FXML
    private Text classId;

    @FXML
    private Text className;

    @FXML
    private Hyperlink studentListHL;

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {


    }

    public void setValue(Class cl){
        className.setText(cl.getName());
        classId.setText(cl.getId());
        studentListHL.setOnAction(new EventHandler<ActionEvent>() {
            @Override
            public void handle(ActionEvent event) {
                Stage window = new Stage();
                window.initModality(Modality.APPLICATION_MODAL);
                FXMLLoader loader=new FXMLLoader(getClass().getResource("/Layouts/stu-list.fxml"));
                StudentListController controller=new StudentListController();
                List<Student> h=new ArrayList<>(cl.getStudentSet());
                controller.setValue(h);
                loader.setController(controller);

                Parent root= null;
                try {
                    root = loader.load();
                } catch (IOException e) {
                    e.printStackTrace();
                }

                Scene editScene = new Scene(root);
                window.setTitle("Danh sách sinh viên");
                window.setScene(editScene);
                window.show();
            }
        });
    }
}
