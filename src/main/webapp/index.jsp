<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>员工列表</title>
<%
	pageContext.setAttribute("ROOTPATH",request.getContextPath());
%><!-- The path starts with a "/" character but does not end with a "/" -->
<!-- 
	不以/开始的相对路径，寻找资源以当前资源路径为准 容易出错
	以/开始的路径 找资源以服务器路径（http://localhost:8080/curd）为基准,可以加上项目根路径
 -->
<!-- Bootstrap -->
<link href="${ROOTPATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script type="text/javascript" src="${ROOTPATH}/static/js/jquery.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="${ROOTPATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
	<!-- Modal 员工修改弹框-->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" >员工修改</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal">
			  <div class="form-group">
			    <!-- for="empName_add_input" 可以不用指定 只是通知和那个输入框 -->
			    <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
			    <div class="col-sm-10">
			     <p class="form-control-static" id="empName_update_static"></p>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="email_add_input" class="col-sm-2 control-label">email</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" name="email" id="email_update_input" placeholder="email">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label  class="col-sm-2 control-label">gender</label>
			    <div class="col-sm-10">
			      	<label class="radio-inline">
				  		<input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
					</label>
					<label class="radio-inline">
				  		<input type="radio" name="gender" id="gender2_update_input" value="F"> 女
					</label>
			    </div>
			  </div>
			  <div class="form-group">
			    <label  class="col-sm-2 control-label">deptName</label>
			    <div class="col-sm-4">
			    	<!-- 提交部门id -->
			      	<select class="form-control" name="dId" id="dept_add_select">
					</select>
			    </div>
			  </div>
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- Modal 员工新增弹框-->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal">
			  <div class="form-group">
			    <!-- for="empName_add_input" 可以不用指定 只是通知和那个输入框 -->
			    <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" name="empName" id="empName_add_input" placeholder="name">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="email_add_input" class="col-sm-2 control-label">email</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" name="email" id="email_add_input" placeholder="email">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label  class="col-sm-2 control-label">gender</label>
			    <div class="col-sm-10">
			      	<label class="radio-inline">
				  		<input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
					</label>
					<label class="radio-inline">
				  		<input type="radio" name="gender" id="gender2_add_input" value="F"> 女
					</label>
			    </div>
			  </div>
			  <div class="form-group">
			    <label  class="col-sm-2 control-label">deptName</label>
			    <div class="col-sm-4">
			    	<!-- 提交部门id -->
			      	<select class="form-control" name="dId" id="dept_add_select">
					</select>
			    </div>
			  </div>
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
	      </div>
	    </div>
	  </div>
	</div>


	<!-- 搭建展示页面 -->
	<div class="container">
		<!-- 标题 -->
		<div class="row"> 
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row"> 
			<!-- col-md-offset-4 偏移4列 -->
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button class="btn btn-danger" id="emp_del_all_btn">删除</button>
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row"> 
			<div class="col-md-12">
				<table class="table table-hover table-bordered" id="emps_tables">
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="check_all"/>
							</th>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
		<!-- 显示分页信息 -->
		<div class="row"> 
			<!-- 分页文字信息 -->
			<div class="col-md-6" id="page_info_area">
			</div>
			<!-- 分页条信息 -->
			<div class="col-md-6" id="page_nav_area">
			</div>
		</div>
	</div>
	<script type="text/javascript">
	var allNums , currentPage;//总的记录数（查询最后一页数据使用）,当前页码
	//页面加载完成之后 直接发送一个ajax请求 取分页数据
	$(function(){
		to_page(1);
	});
	
	function to_page(pageNum){
		$.ajax({
			url:"${ROOTPATH}/emps",
			data:"pageNum="+pageNum,
			type:"get",
			success:function(result){
				console.log(result);
				//1、解析数据
				build_emps_table(result);
				//2、解析分页信息
				build_page_info(result);
				//3、解析分页条信息
				build_page_nav(result);
			}
		});
	}
	
	
	function build_emps_table(result){
		//先清空原有数据
		$("#emps_tables tbody").empty();
		var emps = result.extend.pageInfo.list;
		$.each(emps,function(index,item){
			var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
			var empIdTd = $("<td></td>").append(item.empId);
			var empNameTd = $("<td></td>").append(item.empName);
			var genderTd = $("<td></td>").append(item.gender=='M'?"男":"女");
			var emailTd = $("<td></td>").append(item.email);
			var deptNameTd = $("<td></td>").append(item.department.deptName);
			/* 
			<button class="btn btn-primary btn-sm">
			<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
			</button>
			*/
			var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
							.append($("<span></span>").addClass("glyphicon glyphicon-pencil").append("编辑"));
			//为编辑按钮添加自定义属性，表示当前员工
			editBtn.attr("edit-id",item.empId);
			var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
							.append($("<span></span>").addClass("glyphicon glyphicon-trash").append("删除"));
			delBtn.attr("del-id",item.empId);
			var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
			//append方法执行之后依然是返回原来的元素
			$("<tr></tr>").append(checkBoxTd)
				.append(empIdTd)
				.append(empNameTd)
				.append(genderTd)
				.append(emailTd)
				.append(deptNameTd)
				.append(btnTd)
				.appendTo("#emps_tables tbody");
		});
	}
	//解析显示分页信息
	function build_page_info(result){
		$("#page_info_area").empty();
		$("#page_info_area").append("当前第"
				+ result.extend.pageInfo.pageNum + "页,总"
				+ result.extend.pageInfo.pages + "页,总共"
				+ result.extend.pageInfo.total + "条记录");
		allNums = result.extend.pageInfo.total;
		currentPage = result.extend.pageInfo.pageNum;
		}
	//解析显示分页条
	function build_page_nav(result){
		$("#page_nav_area").empty();
		var ul = $("<ul></ul>").addClass("pagination");
		var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
		var previousPageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
		if(result.extend.pageInfo.hasPreviousPage == false){
			firstPageLi.addClass("disabled");//如果没有前一页，禁止点击
			previousPageLi.addClass("disabled");//如果没有前一页，禁止点击
		}else{
			//为元素添加点击事件
			firstPageLi.click(function(){
				to_page(1);
			});
			previousPageLi.click(function(){
				to_page(result.extend.pageInfo.pageNum-1);
			});
		}
		
		var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
		var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
		if(result.extend.pageInfo.hasNextPage == false){
			nextPageLi.addClass("disabled");//如果没有后一页，禁止点击
			lastPageLi.addClass("disabled");//如果没有后一页，禁止点击
		}else{
			//为元素添加点击事件
			lastPageLi.click(function(){
				to_page(result.extend.pageInfo.pages);
			});
			nextPageLi.click(function(){
				to_page(result.extend.pageInfo.pageNum+1);
			});
		}
		
		//加入首页和上一页
		ul.append(firstPageLi).append(previousPageLi);
		$.each(result.extend.pageInfo.navigatepageNums, function(index,item) {
			var numLi = $("<li></li>").append($("<a></a>").append(item));
			if(result.extend.pageInfo.pageNum == item){
				numLi.addClass("active");
			}
			numLi.click(function(){
				to_page(item);
			});
			
			//加入页码
			ul.append(numLi);
		});
		//加入下一页和莫邪
		ul.append(nextPageLi).append(lastPageLi);
		//加入ul
		var navEle = $("<nav></nav>").append(ul);
		navEle.appendTo("#page_nav_area");
	}
	
	//清空表单样式及内容
	function reset_form(ele){
		$(ele)[0].reset();
		//清空表单样式
		$(ele).find("*").removeClass("has-error has-success");
		$(ele).find(".help-block").text("");
		
	}
	
	
	//新增弹框点击事件   新增按钮
	$("#emp_add_modal_btn").click(function(){
		//清除表单数据（表单重置）
		//$("#empAddModal form")[0].reset();//jquary灭有重置方法 只有去除DOM对象
		reset_form("#empAddModal form");
		//首先ajax查找部门信息 显示下拉列表
		getDepts("#empAddModal select");
		
		$("#empAddModal").modal({
			backdrop:"static" //背景删除为否
		});
	});
	//查找所有部门信息
	function getDepts(ele){
		//先清空下拉列表信息
		$(ele).empty();
		$.ajax({
			url:"${ROOTPATH}/depts",
			type:"get",
			success:function(result){
				//console.log(result)
				//显示所有下拉列表
				//$("dept_add_select").
				//$("#empAddModal select").
				$.each(result.extend.depts,function(){
					var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
					optionEle.appendTo(ele);
				});
			}
		});
	};
	//校验表单数据
	function validate_add_form(){
		//1 拿到数据
		var empName = $("#empName_add_input").val();
		var regx= /(^[a-zA_Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]+$)/;
		if(!regx.test(empName)){
			//alert("用户名可以是2-5位中文或6-16位大小写英文字母");
			show_validate_msg("#empName_add_input","error","用户名可以是2-5位中文或6-16位大小写英文字母");
			//$("#empName_add_input").parent().addClass("has-error");//父节点添加样式
			//为当前节点的紧邻的span标签添加错误信息
			//$("#empName_add_input").next("span").text("用户名可以是2-5位中文或6-16位大小写英文字母");
			return false;
		}else{
			show_validate_msg("#empName_add_input","success","");
			//$("#empName_add_input").parent().addClass("has-success");//父节点添加样式
			//$("#empName_add_input").next("span").text("");
		}
		//检验邮箱
		var email = $("#email_add_input").val();
		var regEmail= /^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/;
		if(!regEmail.test(email)){
			//alert("邮箱格式不正确");
			//清除之前的样式
			show_validate_msg("#email_add_input","error","邮箱格式不正确");
			//$("#email_add_input").parent().addClass("has-error");//父节点添加样式
			//为当前节点的紧邻的span标签添加错误信息
			//$("#email_add_input").next("span").text("邮箱格式不正确");
			return false;
		}else{
			show_validate_msg("#email_add_input","success","");
			//$("#email_add_input").parent().addClass("has-success");//父节点添加样式
			//$("#email_add_input").next("span").text("");
		}
		return true;
	}
	
	function show_validate_msg(ele,status,msg){
		//先清除校验状态信息
		$(ele).parent().removeClass("has-success has-error");
		$(ele).next("span").text("");
		if("success"==status){
			$(ele).parent().addClass("has-success");//父节点添加样式
			$(ele).next("span").text("");
			return true;
		}else if("error"==status){
			$(ele).parent().addClass("has-error");//父节点添加样式
			$(ele).next("span").text(msg);
		}
	}
	//校验用户名是否可用
 	$("#empName_add_input").change(function(){
		//发送ajax请求校验用户名是否可以使用
		var empName = this.value;
		$.ajax({
			url:"${ROOTPATH}/checkuser",
			data:"empName=" + empName,
			type:"POST",
			success:function(result){
				if(result.code==100){
					console.log(result);
					show_validate_msg("#empName_add_input","success","用户名可以使用");
					$("#emp_save_btn").attr("ajax_va","success");//自定义属性值
				}else{
					show_validate_msg("#empName_add_input","error",result.extend.va);
					$("#emp_save_btn").attr("ajax_va","error");
				}
			}
		});
	}); 
	
	
	//点击保存员工信息
	$("#emp_save_btn").click(function(){
		//1 表单数据提交给服务器进行保存
		//先对数据进行校验
		 if(!validate_add_form()){
			return false;
		}; 
		//判断之前的ajax返回值是否成功,禁止提交
		if($(this).attr("ajax_va")=="error"){
			show_validate_msg("#empName_add_input","error","用户名不可以使用");
			return false;
		}
		
		//2 发送ajax请求保存员工
		
		//$("#empAddModal form").serialize() 表格序列化后的数据类似于 &app=XX&
		 $.ajax({
			url:"${ROOTPATH}/emp",
			type:"POST",
			data:$("#empAddModal form").serialize(),
			success:function(result){
				if(result.code==100){
					//alert(result.msg);
					//1 关闭模态框
					$("#empAddModal").modal('hide');
					//2 来到最后一页 显示保存的数据
					//发送ajax请求现货四最后一页数据
					to_page(allNums);
				}else{
					//显示不同的字段的错误信息
					if(undefined != result.extend.errorFileds.email){
						//显示邮箱错误信息
						show_validate_msg("#email_add_input","error",result.extend.errorFileds.email);
					}
					if(undefined != result.extend.errorFileds.empName){
						//显示名字错误信息
						show_validate_msg("#empName_add_input","error",result.extend.errorFileds.empName);
					}
				}
			}
		}); 
	});
	</script>
	<script type="text/javascript">
		//创建编辑按钮之前绑定点击事件，故失效
		/* $(".edit_btn").click({
			alert("hhh");
			
		}); */
		//使用on事件替代之前老版本的live事件
		$(document).on("click",".edit_btn",function(){
			//查出部门信息 查询胡员工信息
			getDepts("#empUpdateModal select");
			getEmp($(this).attr("edit-id"));
			//传递编辑按钮的员工id到更新按钮上
			$("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
			$("#empUpdateModal").modal({
				backdrop:"static",
			})
			
		});
		function getEmp(id){
			$.ajax({
				url:"${ROOTPATH}/emp/"+id,
				type:"get",
				success:function(result){
					var emp = result.extend.employee;
					$("#empName_update_static").text(emp.empName);
					$("#email_update_input").val(emp.email);
					$("#empUpdateModal input[name=gender]").val([emp.gender]);
					$("#empUpdateModal select").val([emp.dId]);
				}
			});
		}
		
		//点击更新按钮
		$("#emp_update_btn").click(function(){
			//验证邮箱合法
			var email = $("#email_update_input").val();
			var regEmail= /^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/;
			if(!regEmail.test(email)){
				show_validate_msg("#email_update_input","error","邮箱格式不正确");
				return false;
			}else{
				show_validate_msg("#email_update_input","success","");
			}
			
			//发送ajax请求 保存数据
			$.ajax({
				url:"${ROOTPATH}/emp/"+$(this).attr("edit-id"),
				type:"PUT",
				data:$("#empUpdateModal form").serialize(),
				success:function(result){
					//alert(result.msg);
					//关闭弹框
					$("#empUpdateModal").modal("hide");
					to_page(currentPage);
				}
			});
		});
	</script>
	<script type="text/javascript">
	//单个删除scrip
	$(document).on("click",".delete_btn",function(){
		//弹出是否删除确认框\
		var empName = $(this).parents("tr").find("td:eq(1)").text();
		var empId = $(this).attr("del-id");
		//alert($(this).parents("tr").find("td:eq(1)").text());
		if(confirm("确认删除【"+empName +"】吗？")){
			$.ajax({
				url:"${ROOTPATH}/emp/"+empId,
				type:"DELETE",
				success:function(result){
					to_page(currentPage);
				}
			});
		}
	});
	//批量删除
	//全选/全不选功能
	$("#check_all").click(function(){
		//attr获取到checked是undefined
		//获取原生的dom属性用prop，attr获取自定义的属性
		//alert($(this).attr("checked"))
		//使用prop修改和读取dom原生的属性
		//alert($(this).prop("checked"))
		$(".check_item").prop("checked",$(this).prop("checked"));
	});
	//选满之后反选
	$(document).on("click",".check_item",function(){
		//判断当前选中的元素是否5个
		//alert($(".check_item:checked").length);
		var flag = $(".check_item:checked").length==$(".check_item").length;
		$("#check_all").prop("checked",flag);
		
	});
	$("#emp_del_all_btn").click(function(){ 
		var empNames= "";
		var empIds= "";
		$.each($(".check_item:checked"),function(){
			//this代表当前正在遍历的元素
			//alert($(this).parents("tr").find("td:eq(2)").text());
			empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
			empIds+=$(this).parents("tr").find("td:eq(1)").text()+"-";
		});
		
		empNames = empNames.substring(0,empNames.length-1);
		empIds = empIds.substring(0,empNames.length-1);
		if(confirm("确认批量删除【"+empNames +"】吗？")){
			$.ajax({
				url:"${ROOTPATH}/emp/"+empIds,
				type:"DELETE",
				success:function(result){
					to_page(currentPage);
				}
			});
		}
		
		
	});
	
	</script>



</body>
</html>