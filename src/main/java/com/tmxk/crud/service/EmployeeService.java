package com.tmxk.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tmxk.crud.bean.Employee;
import com.tmxk.crud.bean.EmployeeExample;
import com.tmxk.crud.bean.EmployeeExample.Criteria;
import com.tmxk.crud.dao.EmployeeMapper;
/**
 * 
 * @author thl
 * @time 2019-03-17 下午7:49:16
 * @packageName com.tmxk.crud.service
 * @description 员工的业务逻辑实现层
 */
@Service
public class EmployeeService {

	@Autowired
	EmployeeMapper employeeMapper; 
	
	/**
	 * @param @return
	 * @return List<Employee>
	 * @time 2019-03-17 下午7:49:44
	 * @description 查询所有员工
	 */
	public List<Employee> getAll() {
		return employeeMapper.selectByExampleWithDept(null);
		
	}

	public void saveEmp(Employee employee) {
		employeeMapper.insertSelective(employee);
	}

	/**
	 * @param empName
	 * @return boolean
	 * @time 2019-03-19 下午9:43:19
	 * @description 检测员工姓名重复性
	 */
	public boolean checkUser(String empName) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long count = employeeMapper.countByExample(example);
		return count == 0;
		
	}

	/**
	 * @param id
	 * @time 2019-03-22 下午10:22:50
	 * @description 获取单个员工信息
	 */
	public Employee getEmp(Integer empId) {
		Employee employee = employeeMapper.selectByPrimaryKey(empId);
		return employee;
	}

	/**
	 * @param employee
	 * @time 2019-03-22 下午10:56:55
	 * @description 更新员工信息
	 */
	public void updateEmp(Employee employee) {
		employeeMapper.updateByPrimaryKeySelective(employee);
	}

	/**
	 * 
	 * @param empId
	 * @time 2019-03-23 上午9:40:14
	 * @description 删除员工逻辑
	 */
	public void deleteEmpById(Integer empId) {
		employeeMapper.deleteByPrimaryKey(empId);
	}

	/**
	 * 
	 * @param empIds
	 * @time 2019-03-23 上午11:02:56
	 * @description 批量删除
	 */
	public void deleteBatch(List<Integer> empIds) {
		// TODO Auto-generated method stub
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		//delete  from tbl_emp where empId in ()
		criteria.andEmpIdIn(empIds);
		employeeMapper.deleteByExample(example);
	}

}
