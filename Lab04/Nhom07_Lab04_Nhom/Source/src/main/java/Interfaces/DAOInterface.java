package Interfaces;


import javafx.collections.ObservableList;

public interface DAOInterface<T> {
    public int addData(T data);
    public int delData(T data);
    public int updateData(T oldData,T newData);
    ObservableList<T> getAll();
}
