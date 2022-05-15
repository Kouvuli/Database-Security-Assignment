package Entities;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Set;

@Entity
@Table(name = "HOCPHAN")
public class Course implements Serializable {
    @Id
    @Column(name = "MAHP")
    private String id;

    @Column(name = "TENHP")
    private String name;

    @Column(name = "SoTC")
    private int certNum;

    @OneToMany(mappedBy="course")
    private Set<Mark> markSet;
    public Course() {
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

    public int getCertNum() {
        return certNum;
    }

    public void setCertNum(int certNum) {
        this.certNum = certNum;
    }

    public Set<Mark> getMarkSet() {
        return markSet;
    }

    public void setMarkSet(Set<Mark> markSet) {
        this.markSet = markSet;
    }
}
