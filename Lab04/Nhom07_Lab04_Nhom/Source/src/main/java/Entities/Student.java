package Entities;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.Set;

@Entity
@Table(name = "SINHVIEN")
public class Student implements Serializable {
    @Id
    @Column(name = "MASV",nullable = false)
    private String id;

    @Column(name = "HOTEN",nullable = false)
    private String name;


    @Column(name = "NGAYSINH")
    @Temporal(TemporalType.DATE)
    private Date birthday;


    @Column(name = "DIACHI")
    private String address;

    @Column(name = "TENDN",nullable = false)
    private String username;

    @Column(name = "MATKHAU",nullable = false)
    private Byte[] password;

    @ManyToOne
    @JoinColumn(name="MALOP", nullable=false)
    private Class classroom;

    @OneToMany(mappedBy="student",fetch = FetchType.EAGER)
    private Set<Mark> markSet;
    public Student() {
    }

    public Student(String name, Date birthday, String address) {
        this.name = name;
        this.birthday = birthday;
        this.address = address;
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

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Byte[] getPassword() {
        return password;
    }

    public void setPassword(Byte[] password) {
        this.password = password;
    }

    public Class getClassroom() {
        return classroom;
    }

    public void setClassroom(Class classroom) {
        this.classroom = classroom;
    }

    public Set<Mark> getMarkSet() {
        return markSet;
    }

    public void setMarkSet(Set<Mark> markSet) {
        this.markSet = markSet;
    }
}
