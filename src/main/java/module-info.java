module com.example.pract {
    requires javafx.controls;
    requires javafx.fxml;


    opens com.example.pract to javafx.fxml;
    exports com.example.pract;
}