package DAO;

import Entities.Employee;
import Interfaces.DAOInterface;
import Utils.HibernateUtils;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.NativeQuery;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.List;

public class EmployeeDAO implements DAOInterface<Employee> {
    @Override
    public int addData(Employee data) {
        Session session=HibernateUtils.getFACTORY().openSession();
        Transaction transaction=session.beginTransaction();
        session.save(data);
        transaction.commit();
        session.close();
        return 0;
    }

    @Override
    public int delData(Employee data) {
        return 0;
    }

    @Override
    public int updateData(Employee oldData, Employee newData) {
        return 0;
    }

    @Override
    public ObservableList<Employee> getAll() {
        Session session = HibernateUtils.getFACTORY().openSession();
        CriteriaBuilder cb=session.getCriteriaBuilder();
        CriteriaQuery query=cb.createQuery(Employee.class);
        query.from(Employee.class);
        List<Employee> list=session.createQuery(query).getResultList();
        session.close();
        return FXCollections.observableArrayList(list);
    }
    public Employee getEmployeeById(String id){
        Session session=HibernateUtils.getFACTORY().openSession();
        CriteriaBuilder cb=session.getCriteriaBuilder();
        CriteriaQuery query=cb.createQuery(Employee.class);
        Root<Employee>root=query.from(Employee.class);
        String str=String.format("%%%s%%",id);
        query.where(cb.like(root.get("id").as(String.class),str));
        Employee employee =(Employee) session.createQuery(query).getSingleResult();
        session.close();
        return employee;
    }

    public Employee getEmployeeByUserName(String username){
        Session session=HibernateUtils.getFACTORY().openSession();
        CriteriaBuilder cb=session.getCriteriaBuilder();
        CriteriaQuery query=cb.createQuery(Employee.class);
        Root<Employee>root=query.from(Employee.class);
        String str=String.format("%%%s%%",username);
        Predicate p1=cb.equal(root.get("username"),username);
        query.where(p1);
        Employee employee =(Employee) session.createQuery(query).getSingleResult();
        session.close();
        return employee;
    }

}
