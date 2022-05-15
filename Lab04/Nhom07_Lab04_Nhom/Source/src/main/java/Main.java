import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.stage.Stage;

import java.io.IOException;
import java.security.*;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;
import java.util.HexFormat;

public class Main extends Application {
        Stage window;
        Scene scene;
        @Override
        public void start(Stage stage) throws IOException, NoSuchAlgorithmException, InvalidKeySpecException {
            window =stage;
            FXMLLoader loader = new FXMLLoader(Main.class.getResource("/Layouts/login.fxml"));
            scene = new Scene(loader.load());
            stage.setTitle("Đăng nhập");
            stage.setScene(scene);
            stage.show();



        }
        public static void main(String[] args) {
            launch();
        }

    }
