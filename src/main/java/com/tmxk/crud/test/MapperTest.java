package com.tmxk.crud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.tmxk.crud.bean.Department;
import com.tmxk.crud.bean.Employee;
import com.tmxk.crud.dao.DepartmentMapper;
import com.tmxk.crud.dao.EmployeeMapper;


/**
 * 测试mapperCRUD
 * @author thl
 * @date 2019-03-16
 * Spring项目使用spring的单元测试
 * 1、导入单元测试功能jar
 * 2、@ContextConfiguration 配置指定的文件
 * 3、@Autowired 自动注入
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:applicationContext.xml"})
public class MapperTest {
	
	@Autowired
	DepartmentMapper departmentMapper;
	
	@Autowired
	EmployeeMapper employeeMapper;
	
	@Autowired
	SqlSession sqlSession;
	/**s
	 * 测试DepartmentMapper
	 * 
	 */
	@Test
	public void test1() {
		/*//1. 创建SpringIOC容器
		ApplicationContext ioc= new ClassPathXmlApplicationContext("applicationContext.xml");
		//2. 从容器中获取mapper
		DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);*/
		
		System.out.println(departmentMapper);
		//1 测试部门插入
//		departmentMapper.insertSelective(new Department(null,"外交部"));
//		departmentMapper.insertSelective(new Department(null,"国防部"));
		//2 测试员工数据插入
//		employeeMapper.insertSelective(new Employee(null, "tmxk", "M", "131377@163.com", 1));
		
		
		//3 批量插入使用sqlSession
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		for (int i = 0; i < 1000; i++) {
			String uuid = UUID.randomUUID().toString().substring(0, 5)+i;
			mapper.insertSelective(new Employee(null,uuid,i%2==0?"M":"F",uuid+"@tmxk.com",1));
		}
		System.out.println("BATCH SUCCESS");
		
		
	}
	
	public static void main(String[] args) {
//		System.out.println(departmentMapper);
	}
	
	
}
