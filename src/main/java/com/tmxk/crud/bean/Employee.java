package com.tmxk.crud.bean;

import javax.validation.constraints.Email;
import javax.validation.constraints.Pattern;

public class Employee {
    private Integer empId;

    @Pattern(regexp="(^[a-zA_Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]+$)",message="用户名可以是2-5位中文或6-16位大小写英文字母")
    private String empName;

    private String gender;

    @Pattern(regexp="^[a-z\\d]+(\\.[a-z\\d]+)*@([\\da-z](-[\\da-z])?)+(\\.{1,2}[a-z]+)+$",message="邮箱格式不正确")
    private String email;

    private Integer dId;
    
    private Department department;
    
    public Employee() {
		super();
	}

	public Employee(Integer empId, String empName, String gender, String email, Integer dId) {
		this.empId = empId;
		this.empName = empName;
		this.gender = gender;
		this.email = email;
		this.dId = dId;
	}

	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName == null ? null : empName.trim();
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender == null ? null : gender.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public Integer getdId() {
        return dId;
    }

    public void setdId(Integer dId) {
        this.dId = dId;
    }
}