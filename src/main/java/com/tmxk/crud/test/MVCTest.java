package com.tmxk.crud.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.github.pagehelper.PageInfo;
import com.tmxk.crud.bean.Employee;

/**
 * 
 * @author thl
 * @time 2019-03-17 下午8:16:45
 * @packageName com.tmxk.crud.test
 * @description 使用spring模仿前端发送请求
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = { "classpath:applicationContext.xml",
		"file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml" })
public class MVCTest {

	// 传入Spring MVC的ioc
	@Autowired
	WebApplicationContext applicationContext;
	// 虚拟的mvc请求，获取到处理结果
	MockMvc mockMvc;

	@Before
	public void initMokcMVC() {
		mockMvc = MockMvcBuilders.webAppContextSetup(applicationContext).build();
	}

	@Test
	public void testpage() throws Exception {
		MvcResult mvcResult = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pageNum", "7")).andReturn();
		// 请i去成功之后 请求域中含有pageInfo信息
		MockHttpServletRequest request = mvcResult.getRequest();
    	PageInfo pi=(PageInfo)  request.getAttribute("pageInfo");
    	System.out.println(pi);
    	System.out.println("当前页："+pi.getPageNum());
    	System.out.println("总页码："+pi.getPages());
    	System.out.println("总记录数："+pi.getTotal());
    	int[] num = pi.getNavigatepageNums();
    	for(int i:num){
    		System.out.print(" "+i);
    	}
    	//获取员工数据
    	List<Employee> list = pi.getList();
    	for(Employee employee : list){
    		System.out.println("ID:"+employee.getdId()+"=====>>name:"+employee.getEmpName());
    	}
    }
		
	
	}

