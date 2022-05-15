package Entities;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "BANGDIEM")
public class Mark implements Serializable {


    @Column(name = "DIEMTHI")
    private String mark;

    @Id
    @ManyToOne
    @JoinColumn(name="MASV", nullable=false)
    private Student student;

    @Id
    @ManyToOne
    @JoinColumn(name="MAHP", nullable=false)
    private Course course;
    public Mark() {
    }

    public Mark(String mark, Student student, Course course) {
        this.mark = mark;
        this.student = student;
        this.course = course;
    }

    public String getMark() {
        return mark;
    }

    public void setMark(String mark) {
        this.mark = mark;
    }

    public Student getStudent() {
        return student;
    }

    public void setStudent(Student student) {
        this.student = student;
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }
}
