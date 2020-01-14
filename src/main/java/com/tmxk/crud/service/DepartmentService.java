package com.tmxk.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tmxk.crud.bean.Department;
import com.tmxk.crud.dao.DepartmentMapper;

/**
 * 
 * @author thl
 * @time 2019-03-19 上午7:59:13
 * @packageName com.tmxk.crud.service
 * @description 部门业务逻辑处理类
 */
@Service
public class DepartmentService {

	@Autowired
	private DepartmentMapper departmentMapper;
	
	/**
	 * @return List
	 * @time 2019-03-19 上午7:59:09
	 * @description 获取所有部门信息
	 */
	public List<Department> getDepts() {
		return departmentMapper.selectByExample(null);
	}



}
