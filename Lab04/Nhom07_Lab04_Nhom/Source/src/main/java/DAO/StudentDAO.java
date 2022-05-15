package DAO;

import Entities.Class;
import Entities.Student;
import Interfaces.DAOInterface;
import Utils.HibernateUtils;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import org.hibernate.Session;
import org.hibernate.Transaction;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;

public class StudentDAO implements DAOInterface<Student> {
    @Override
    public int addData(Student data) {
        return 0;
    }

    @Override
    public int delData(Student data) {
        return 0;
    }

    @Override
    public int updateData(Student oldData, Student newData) {
        Session session=HibernateUtils.getFACTORY().openSession();
        Transaction transaction=session.beginTransaction();
        Student student =session.get(Student.class, oldData.getId());
        student.setBirthday(newData.getBirthday());
        student.setAddress(newData.getAddress());
        student.setName(newData.getName());
        session.saveOrUpdate(student);
        transaction.commit();
        session.close();
        return 0;
    }

    @Override
    public ObservableList<Student> getAll() {
        Session session= HibernateUtils.getFACTORY().openSession();
        CriteriaBuilder cb= session.getCriteriaBuilder();
        CriteriaQuery query = cb.createQuery(Student.class);
        query.from(Student.class);
        List<Student> list=session.createQuery(query).getResultList();

        return FXCollections.observableArrayList(list);
    }
    public Student getStudentById(String id){
        Session session=HibernateUtils.getFACTORY().openSession();
        CriteriaBuilder cb=session.getCriteriaBuilder();
        CriteriaQuery query=cb.createQuery(Student.class);
        Root<Class> root=query.from(Student.class);
        String str=String.format("%%%s%%",id);
        query.where(cb.like(root.get("id").as(String.class),str));
        Student student =(Student) session.createQuery(query).getSingleResult();
        session.close();
        return student;
    }
    public ObservableList<String> getAllStudentOfClass(String maLop){
        Session session = HibernateUtils.getFACTORY().openSession();
        CriteriaBuilder cb= session.getCriteriaBuilder();
        CriteriaQuery query=cb.createQuery(Student.class);
        Root<Student> root=query.from(Student.class);
        query.select(root.get("username"));
        List<String> list=session.createQuery(query).getResultList();
        session.close();
        return FXCollections.observableArrayList(list);
    }
}
