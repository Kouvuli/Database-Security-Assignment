package DAO;

import Entities.Class;
import Interfaces.DAOInterface;
import Utils.HibernateUtils;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import org.hibernate.Session;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;

public class ClassDAO implements DAOInterface<Class> {
    @Override
    public int addData(Class data) {
        return 0;
    }

    @Override
    public int delData(Class data) {
        return 0;
    }

    @Override
    public int updateData(Class oldData, Class newData) {
        return 0;
    }

    @Override
    public ObservableList<Class> getAll() {
        Session session = HibernateUtils.getFACTORY().openSession();
        CriteriaBuilder cb=session.getCriteriaBuilder();
        CriteriaQuery query=cb.createQuery(Class.class);
        query.from(Class.class);
        List<Class> list=session.createQuery(query).getResultList();
        session.close();
        return FXCollections.observableArrayList(list);
    }
    public Class getClassById(String id){
        Session session=HibernateUtils.getFACTORY().openSession();
        CriteriaBuilder cb=session.getCriteriaBuilder();
        CriteriaQuery query=cb.createQuery(Class.class);
        Root<Class> root=query.from(Class.class);
        String str=String.format("%%%s%%",id);
        query.where(cb.like(root.get("id").as(String.class),str));
        Class aClass =(Class) session.createQuery(query).getSingleResult();
        session.close();
        return aClass;
    }
}
