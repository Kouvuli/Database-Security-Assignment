package Entities;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Set;

@Entity
@Table(name = "LOP")
public class Class implements Serializable {
    @Id
    @Column(name = "MALOP")
    private String id;

    @Column(name = "TENLOP")
    private String name;

//    @Column(name = "MANV")
//    private String maNV;
    @ManyToOne
    @JoinColumn(name="MANV", nullable=false)
    private Employee employee;

    @OneToMany(mappedBy="classroom",fetch = FetchType.EAGER)
    private Set<Student> studentSet;

    public Class() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Employee getEmployee() {
        return employee;
    }

    public void setEmployee(Employee employee) {
        this.employee = employee;
    }

    public Set<Student> getStudentSet() {
        return studentSet;
    }

    public void setStudentSet(Set<Student> studentSet) {
        this.studentSet = studentSet;
    }
}
