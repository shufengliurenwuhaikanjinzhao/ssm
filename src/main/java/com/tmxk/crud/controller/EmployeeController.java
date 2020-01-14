package com.tmxk.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.tmxk.crud.bean.Employee;
import com.tmxk.crud.bean.EmployeeExample;
import com.tmxk.crud.bean.EmployeeExample.Criteria;
import com.tmxk.crud.bean.Msg;
import com.tmxk.crud.dao.EmployeeMapper;
import com.tmxk.crud.service.EmployeeService;

/**
 * 
 * @author thl
 * @time 2019-03-17 下午7:43:24
 * @packageName com.tmxk.crud.controller
 * @description 员工的控制层
 */
@RestController
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;
	@Autowired
	EmployeeMapper employeeMapper;
	/**
	 * 
	 * @param 
	 * @return void
	 * @time 2019-03-17 下午7:43:16
	 * @description 员工数据分页查询
	 */
//	@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pageNum",defaultValue="1") Integer pageNum,Model model) {
		//分页查询引入PageHelper插件
		//查询之前调用startPage函数 传入 页码数 和 每页个数
		PageHelper.startPage(pageNum,5);
		//接着调用分页查询,
		List<Employee> emps = employeeService.getAll();
		// 结果由PageInfo 包装传给前端
		//封装了详细的分页信息;5 代表连续显示的页码数
		PageInfo pageInfo = new PageInfo(emps,5);
		model.addAttribute("pageInfo", pageInfo);
		return "list";
	}
	
	/**
	 * @param  pageNum
	 * @return PageInfo
	 * @time 2019-03-18 上午8:07:42
	 * @description 直接返回json形式
	 */
	//导入Jackson
	@RequestMapping("/emps")
	public Msg getEmpsByJson(@RequestParam(value="pageNum",defaultValue="1") Integer pageNum) {
		//分页查询引入PageHelper插件
		//查询之前调用startPage函数 传入 页码数 和 每页个数
		PageHelper.startPage(pageNum,5);
		//接着调用分页查询,
		List<Employee> emps = employeeService.getAll();
		// 结果由PageInfo 包装传给前端
		//封装了详细的分页信息;5 代表连续显示的页码数
		PageInfo pageInfo = new PageInfo(emps,5);
		return Msg.success().add("pageInfo", pageInfo);
	}
	
	/**
	 * @return
	 * @time 2019-03-19 上午8:27:22
	 * @description REST风格的员工保存
	 */
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	public Msg saveEmp(@Valid Employee employee,BindingResult result) {
		if(result.hasErrors()) {
			Map<String, Object> map =new HashMap<>();
			//返回失败前端展示返回的失败信息
			for(FieldError fe : result.getFieldErrors()) {
				map.put(fe.getField(), fe.getDefaultMessage());
			}
			return Msg.fail().add("errorFileds", map);
		}else {
			employeeService.saveEmp(employee);
			return Msg.success();
		}
	}
	/**
	 * 
	 * @param empName
	 * @return Msg
	 * @time 2019-03-19 下午9:37:53
	 * @description 用户名校验
	 */
	@RequestMapping("/checkuser")
	public Msg checkuser(@RequestParam("empName")String empName){
		//先判断用户名是否合法
		String regex = "(^[a-zA_Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]+$)";
		if(!empName.matches(regex)) {
			return Msg.fail().add("va", "用户名是6-16位数字字母或者2-5位中文");
		}
		boolean flag = employeeService.checkUser(empName);
		if(flag) {
			return Msg.success();
		}else {
			Msg msg = Msg.fail().add("va", "用户名不可用");
			return msg;
		}
	}
	/**
	 * 
	 * @return
	 * @time 2019-03-22 下午10:21:05
	 * @description 获取单个员工信息
	 */
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	public Msg getEmp(@PathVariable("id") Integer id) {
		
		Employee employee = employeeService.getEmp(id);
		
		return Msg.success().add("employee", employee);
	}
	/**
	 * @param employee
	 * @return
	 * @time 2019-03-22 下午10:55:23
	 * @description 更新员工
	 * 如果直接发送ajax=PUT形式的请求
	 * 封装的数据
	 * Employee
	 * [empId=1001,empName=null,gender=null,email=null,dId=null]
	 * 问题：
	 * 	请求体中的数据：
	 * 		但是Employee对象封装不上：
	 * 		update tbl_emp where emp_id = 1010
	 * reason:
	 * 	Tomcat:
	 * 		1. 会封装请求体中数据为一个map
	 * 		2. request.getParameter("empName"),就会从map中获取
	 * 		3. SpringMVC封装POJO对象的时候
	 * 					会把POJO中每一个属性的值 取出来即以方式request.getParameter("email")方式
	 * 
	 * AJAX发送PUT请求方式：
	 * 		PUT请求，请求体中数据根据request.getParameter("empName")获取
	 * 		对于TOMCAT来说若是PUT请求就不会封装数据为map，只有POST请求才会封装为map
	 * 
	 * org.apache.catalina.connector.Request
	 * 
	 * 
	 * 支持ajax的PUT请求还要封装请求体中的数据
	 * 配置上HttpPutFormContentFilter
	 * 作用是将请求体中数据解析包装为map
	 * 重写request.getParameter()方法，会从自己封装的数据map中获取
	 */
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	public Msg saveEmp(Employee employee) {
		employeeService.updateEmp(employee);
		return Msg.success();
	}
	
	/**
	 * 
	 * @param empId
	 * @return
	 * @time 2019-03-23 上午9:39:17
	 * @description 删除员工信息  批量和单个删除融合
	 */
	@RequestMapping(value="/emp/{empIds}",method=RequestMethod.DELETE)
	public Msg deleteEmpById(@PathVariable("empIds")String empIds) {
		if(empIds.contains("-")) {
			List<Integer> list = new ArrayList<>();
			for (String empId : empIds.split("-")) {
				list.add(Integer.parseInt(empId));
			}
			employeeService.deleteBatch(list);
			return Msg.success();
		}
		employeeService.deleteEmpById(Integer.valueOf(empIds));
		return Msg.success();
	}
	
	
}
