package com.cosmeticstore.dao;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.cosmeticstore.utils.JdbcUtil;

import entity.News;

public class NewsDAO implements CrudDao<News, Integer> {

    String INSERT = "INSERT INTO News(title,summary,content,image,createdDate) VALUES(?,?,?,?,?)";
    String UPDATE = "UPDATE News SET title=?,summary=?,content=?,image=?,createdDate=? WHERE id=?";
    String DELETE = "DELETE FROM News WHERE id=?";
    String SELECT_ALL = "SELECT * FROM News ORDER BY createdDate DESC";
    String SELECT_ID = "SELECT * FROM News WHERE id=?";

    @Override
    public int create(News n) {
//Thêm Try-catch vào
    	try {
        return JdbcUtil.executeUpdate(INSERT,
                n.getTitle(),
                n.getSummary(),
                n.getContent(),
                n.getImage(),
                n.getCreatedDate());
    } catch (Exception e) {
        e.printStackTrace(); 
        return 0; 
    }
}

    @Override
    public int update(News n) {
//Thêm Try-catch vào
    	try {
        return JdbcUtil.executeUpdate(UPDATE,
                n.getTitle(),
                n.getSummary(),
                n.getContent(),
                n.getImage(),
                n.getCreatedDate(),
                n.getId());
    } catch (Exception e) {
        e.printStackTrace(); 
        return 0;
    }
}

    @Override
    public int delete(News n) {
//Thêm Try-catch vào
    	try {
        return JdbcUtil.executeUpdate(DELETE, n.getId());
    } catch (Exception e) {
        e.printStackTrace();
        return 0;
    }
}

    @Override
    public List<News> findAll() {
        return findBySql(SELECT_ALL);
    }

    @Override
    public News findById(Integer id) {
        List<News> list = findBySql(SELECT_ID, id);
        return list.isEmpty() ? null : list.get(0);
    }

    @Override
    public List<News> findBySql(String sql, Object... args) {

        List<News> list = new ArrayList<>();

        try {
            ResultSet rs = JdbcUtil.executeQuery(sql, args);

            while (rs.next()) {
                News n = new News();
                n.setId(rs.getInt("id"));
                n.setTitle(rs.getString("title"));
                n.setSummary(rs.getString("summary"));
                n.setContent(rs.getString("content"));
                n.setImage(rs.getString("image"));
                n.setCreatedDate(rs.getTimestamp("createdDate"));
                list.add(n);
            }

            rs.getStatement().getConnection().close();

        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return list;
    }
}
