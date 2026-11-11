package com.cosmeticstore.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.cosmeticstore.utils.JdbcUtil;
import entity.User;

public class AccountDAO implements CrudDao<User, Integer> {
    String INSERT = "INSERT INTO Employee (EmployeeName, Gender, Phone, Address, Position, Email, Password) VALUES (?, 1, '0000000000', N'Chưa cập nhật', N'Nhân viên', ?, ?)";
    String UPDATE = "UPDATE Employee SET EmployeeName = ?, Email = ? WHERE EmployeeID = ?";
    String DELETE = "DELETE FROM Employee WHERE EmployeeID = ?";
    String SELECT_ALL = "SELECT EmployeeID AS id, EmployeeName AS name, Email AS email FROM Employee";
    String SELECT_ID = "SELECT EmployeeID AS id, EmployeeName AS name, Email AS email FROM Employee WHERE EmployeeID = ?";

    @Override 
    public int create(User entity) {
        try {
            return JdbcUtil.executeUpdate(INSERT, entity.getName(), entity.getEmail(), entity.getPassword());
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public int update(User entity) {
        try {
            return JdbcUtil.executeUpdate(UPDATE, entity.getName(), entity.getEmail(), entity.getId());
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public int delete(User entity) {
        try {
            return JdbcUtil.executeUpdate(DELETE, entity.getId());
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public List<User> findAll() {
        return findBySql(SELECT_ALL);
    }

    @Override 
    public User findById(Integer id) {
        List<User> list = findBySql(SELECT_ID, id);
        return list.isEmpty() ? null : list.get(0);
    }

    @Override
    public List<User> findBySql(String sql, Object... values) {
        List<User> listUser = new ArrayList<>();
        try {
            ResultSet rs = JdbcUtil.executeQuery(sql, values);
            while (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setName(rs.getString("name"));
                u.setEmail(rs.getString("email"));
                u.setPassword("123"); 
                listUser.add(u);
            }
            rs.getStatement().getConnection().close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listUser;
    }

    public boolean register(User newUser) {
        String checkSql = "SELECT CustomerID FROM Customer WHERE LOWER(Email) = LOWER(?)";
        try {
            ResultSet rs = JdbcUtil.executeQuery(checkSql, newUser.getEmail().trim());
            if (rs.next()) {
                System.out.println("Email đã được sử dụng");
                rs.getStatement().getConnection().close();
                return false;
            }
            rs.getStatement().getConnection().close();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return create(newUser) > 0;
    }

    public User login(String email, String password) {
        if (email == null || password == null) return null;
        String cleanEmail = email.trim();
        String cleanPassword = password.trim();
        String sqlEmployee = "SELECT EmployeeID AS id, EmployeeName AS name, Email AS email, Password AS password " +
                "FROM Employee WHERE LOWER(Email) = LOWER(?) AND Password = ?";
        try {
            ResultSet rs = JdbcUtil.executeQuery(sqlEmployee, cleanEmail, cleanPassword);
            if (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setName(rs.getString("name"));
                u.setEmail(rs.getString("email"));
                u.setPassword(cleanPassword);
                System.out.println("Đăng nhập thành công" + u.getName());
                rs.getStatement().getConnection().close();
                return u;
            }
            rs.getStatement().getConnection().close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        String sqlCustomer = "SELECT CustomerID AS id, CustomerName AS name, Email AS email, Password AS password " +
                             "FROM Customer WHERE LOWER(Email) = LOWER(?) AND Password = ?";
        try {
            ResultSet rs = JdbcUtil.executeQuery(sqlCustomer, cleanEmail, cleanPassword);
            if (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setName(rs.getString("name"));
                u.setEmail(rs.getString("email"));
                u.setPassword(cleanPassword);
                System.out.println("Đăng nhập thành công" + u.getName());
                rs.getStatement().getConnection().close();
                return u;
            }
            rs.getStatement().getConnection().close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.println("Sai Email hoặc Password");
        return null;
    }
}