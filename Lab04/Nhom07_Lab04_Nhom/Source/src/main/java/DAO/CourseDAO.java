package DAO;

import Entities.Course;
import Interfaces.DAOInterface;
import Utils.HibernateUtils;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import org.hibernate.Session;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;

public class CourseDAO implements DAOInterface<Course> {
    @Override
    public int addData(Course data) {
        return 0;
    }

    @Override
    public int delData(Course data) {
        return 0;
    }

    @Override
    public int updateData(Course oldData, Course newData) {
        return 0;
    }

    @Override
    public ObservableList<Course> getAll() {
        Session session = HibernateUtils.getFACTORY().openSession();
        CriteriaBuilder cb=session.getCriteriaBuilder();
        CriteriaQuery query=cb.createQuery(Course.class);
        query.from(Course.class);
        List<Course> list=session.createQuery(query).getResultList();
        session.close();
        return FXCollections.observableArrayList(list);
    }
    public Course getCourseById(String id){
        Session session=HibernateUtils.getFACTORY().openSession();
        CriteriaBuilder cb=session.getCriteriaBuilder();
        CriteriaQuery query=cb.createQuery(Course.class);
        Root<Course> root=query.from(Course.class);
        String str=String.format("%%%s%%",id);
        query.where(cb.like(root.get("id").as(String.class),str));
        Course course =(Course) session.createQuery(query).getSingleResult();
        session.close();
        return course;
    }
}
