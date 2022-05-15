package Models;

import Entities.Course;
import javafx.scene.control.Button;


public class MarkRow extends Course {

    private float mark;
    private Button editBtn;

    public MarkRow(String maHP, String tenHP, int soTC, float diem, Button editBtn) {
        this.setName(tenHP);
        this.setId(maHP);
        this.setCertNum(soTC);
        this.mark=diem;
        this.editBtn = editBtn;
    }

    public float getMark() {
        return mark;
    }

    public void setMark(float mark) {
        this.mark = mark;
    }

    public Button getEditBtn() {
        return editBtn;
    }

    public void setEditBtn(Button editBtn) {
        this.editBtn = editBtn;
    }
}
