package com.cosmeticstore.dao;

import java.util.List;

import javax.swing.text.html.parser.Entity;

public interface CrudDao<Entity, ID> {
	int create(Entity entity);

	int update(Entity entity);

	int delete(Entity entity);

	List<Entity> findAll();

	Entity findById(ID id);

	List<Entity> findBySql(String sql, Object... value);
}
