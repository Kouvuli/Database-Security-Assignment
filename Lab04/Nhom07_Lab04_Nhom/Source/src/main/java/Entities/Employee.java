package Entities;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Set;

@Entity
@Table(name = "NHANVIEN")
public class Employee implements Serializable {
    @Id
    @Column(name = "MANV")
    private String id;

    @Column(name = "HOTEN")
    private String name;

    @Column(name = "EMAIL")
    private String email;

    @Column(name = "LUONG")
    private byte[] salary;

    @Column(name = "TENDN")
    private String username;

    @Column(name = "MATKHAU")
    private byte[] password;

    @Column(name = "PUBKEY")
    private String pubKey;

    @OneToMany(mappedBy="employee",fetch = FetchType.EAGER)
    private Set<Class> classSet;

    public Employee() {
    }

    public Employee(String id, String name, String email, byte[] salary, String username, byte[] password, String pubKey) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.salary = salary;
        this.username = username;
        this.password = password;
        this.pubKey = pubKey;

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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public byte[] getSalary() {
        return salary;
    }

    public void setSalary(byte[] salary) {
        this.salary = salary;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public byte[] getPassword() {
        return password;
    }

    public void setPassword(byte[] password) {
        this.password = password;
    }

    public String getPubKey() {
        return pubKey;
    }

    public void setPubKey(String pubKey) {
        this.pubKey = pubKey;
    }

    public Set<Class> getClassSet() {
        return classSet;
    }

    public void setClassSet(Set<Class> classSet) {
        this.classSet = classSet;
    }
}
