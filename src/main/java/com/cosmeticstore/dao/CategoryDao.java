package com.cosmeticstore.dao;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import entity.Category;

import com.cosmeticstore.utils.JdbcUtil;

public class CategoryDao implements CrudDao<Category, Integer> {

    private static final String INSERT_SQL =
            "INSERT INTO Category(CategoryName, Description) VALUES(?, ?)";

    private static final String UPDATE_SQL =
            "UPDATE Category SET CategoryName=?, Description=? WHERE CategoryID=?";

    private static final String DELETE_SQL =
            "DELETE FROM Category WHERE CategoryID=?";

    private static final String SELECT_ALL_SQL =
            "SELECT * FROM Category";

    private static final String SELECT_BY_ID_SQL =
            "SELECT * FROM Category WHERE CategoryID=?";

    @Override
    public List<Category> findAll() {
        return findBySql(SELECT_ALL_SQL);
    }

    @Override
    public Category findById(Integer id) {
        List<Category> list = findBySql(SELECT_BY_ID_SQL, id);
        return list.isEmpty() ? null : list.get(0);
    }

    @Override
    public int create(Category entity) {
        try {
            return JdbcUtil.executeUpdate(
                    INSERT_SQL,
                    entity.getCategoryName(),
                    entity.getDescription());
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public int update(Category entity) {
        try {
            return JdbcUtil.executeUpdate(
                    UPDATE_SQL,
                    entity.getCategoryName(),
                    entity.getDescription(),
                    entity.getCategoryID());
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public int delete(Category entity) {
        try {
            return JdbcUtil.executeUpdate(
                    DELETE_SQL,
                    entity.getCategoryID());
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public List<Category> findBySql(String sql, Object... args) {

        List<Category> list = new ArrayList<>();

        try {

            ResultSet rs = JdbcUtil.executeQuery(sql, args);

            while (rs.next()) {

                Category c = new Category();

                c.setCategoryID(rs.getInt("CategoryID"));
                c.setCategoryName(rs.getString("CategoryName"));
                c.setDescription(rs.getString("Description"));

                list.add(c);
            }

            if (rs != null && rs.getStatement() != null
                    && rs.getStatement().getConnection() != null) {
                rs.getStatement().getConnection().close();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}