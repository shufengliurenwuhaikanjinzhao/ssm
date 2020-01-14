package com.tmxk.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tmxk.crud.bean.Department;
import com.tmxk.crud.bean.Msg;
import com.tmxk.crud.service.DepartmentService;

/**
 * 
 * @author thl
 * @time 2019-03-19 上午7:56:35
 * @packageName com.tmxk.crud.controller
 * @description 部门控制器
 */
@Controller
@ResponseBody
public class DepartmentController {

	@Autowired
	private DepartmentService departmentService;
	
	
	@RequestMapping("/depts")
	public Msg getDepts() {
		//所有部门信息
		List<Department> depts = departmentService.getDepts();
		return Msg.success().add("depts", depts);
	}
	
}
