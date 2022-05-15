package DAO;

import Entities.Mark;
import Interfaces.DAOInterface;
import Utils.HibernateUtils;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import org.hibernate.Session;
import org.hibernate.query.NativeQuery;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import java.util.List;

public class MarkDAO implements DAOInterface<Mark> {
    @Override
    public int addData(Mark data) {
        return 0;
    }

    @Override
    public int delData(Mark data) {
        return 0;
    }

    @Override
    public int updateData(Mark oldData, Mark newData) {

        return 0;
    }

    @Override
    public ObservableList<Mark> getAll() {
        Session session = HibernateUtils.getFACTORY().openSession();
        CriteriaBuilder cb=session.getCriteriaBuilder();
        CriteriaQuery query=cb.createQuery(Mark.class);
        query.from(Mark.class);
        List<Mark> list=session.createQuery(query).getResultList();
        session.close();
        return FXCollections.observableArrayList(list);
    }
    public List<Object[]> getMarkByStudentId(String id){
        Session session=HibernateUtils.getFACTORY().openSession();
        NativeQuery query=session.createNativeQuery("EXEC SP_SEL_BANGDIEM_SINHVIEN "+id);
//        Query query=session.createSQLQuery("EXEC SP_SEL_PUBLIC_NHANVIEN(:usrename,:password)").addEntity(NhanVien.class).setParameter("username",username).setParameter("password",password);
        List<Object[]> bangDiemList= query.getResultList();
        return bangDiemList;
    }
}
