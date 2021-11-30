<%--
  Created by IntelliJ IDEA.
  User: Mars
  Date: 2021/11/28
  Time: 20:55
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <!--<meta http-equiv="Content-Type" content="text/html;charset=utf-8">-->
    <title>显示用户信息</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <!--引入jQuery-->
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
    <!--引入样式-->
    <link href="${APP_PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>
</head>
<body>
<!--添加用户的模态框-->
<div class="modal fade" id="empAddModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">添加用户</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input"
                                   placeholder="empName">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input"
                                   placeholder="emial">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="W"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">所在部门</label>
                        <div class="col-sm-4">
                            <!--提交部门id即可-->
                            <select class="form-control" name="dId" id="dept_add_select">

                            </select>
                        </div>
                    </div>


                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary">添加</button>
            </div>
        </div>
    </div>
</div>
<!--搭建显示页面-->
<div class="container">
    <!--标题-->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!--按钮-->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button type="button" class="btn btn-success" id="emp_add_model_btn">添加</button>
            <button type="button" class="btn btn-danger">删除</button>
        </div>
    </div>
    <!--显示表格数据-->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>#</th>
                    <th>姓名</th>
                    <th>性别</th>
                    <th>邮箱</th>
                    <th>部门</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </div>
    <!--显示分页信息-->
    <div class="row">
        <!--显示分页文字信息-->
        <div class="col-md-3 col-md-offset-3" id="page_info_area"></div>
        <!--显示分页条信息-->
        <div class="col-md-6" id="page_nav_area"></div>
    </div>
</div>

<script type="text/javascript">
    // 1、页面加载完成以后，直接去发送ajax请求，要到分页数据
    $(function () {
        // 去首页
        to_page(1)
    });

    function to_page(pn) {
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pn=" + pn,
            type: "GET",
            success: function (result) {
                // console.log(result);
                // 解析JSON并显示员工数据
                build_emps_table(result);
                // 解析Json并显示分页信息
                build_page_info(result);
                // 解析JSON并显示分页条
                build_page_nav(result)
            }
        });
    }

    // 构建单元格数据
    function build_emps_table(result) {
        $("#emps_table tbody").empty();
        var emps = result.extendMap.pageInfo.list;
        // 遍历list,emps要遍历的元素，每次遍历的回调函数就是function(索引，当前对象)
        $.each(emps, function (index, item) {
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == "M" ? "男" : "女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-success")
                .append($("<span><span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            var delBtn = $("<button></button>").addClass("btn btn-danger")
                .append($("<span><span>").addClass("glyphicon glyphicon-remove")).append("删除");

            // append方法完成后还会返回原来的元素
            $("<tr></t>").append(empIdTd).append(empNameTd)
                .append(genderTd).append(emailTd)
                .append(deptNameTd).append(editBtn).append("&nbsp;")
                .append(delBtn).appendTo("#emps_table tbody");

        });
    }

    // 构建分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前第" + result.extendMap.pageInfo.pageNum + "页 共"
            + result.extendMap.pageInfo.pages + "页 共"
            + result.extendMap.pageInfo.total + "条记录")
    }

    // 构建分页条
    function build_page_nav(result) {
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");

        // 首页
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页")
            .attr("href", "#"));

        // 末页
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));

        // 前一页
        var prePageLi = $("<li></li>").append($("<a></a>").append($("<span></span>")
            .append("&laquo;").attr("aria-hidden", "true")).attr("href", "#"));
        if (result.extendMap.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            // 绑定点击事件
            prePageLi.click(function () {
                to_page(result.extendMap.pageInfo.pageNum - 1);
            });
            firstPageLi.click(function () {
                to_page(1);
            });
        }

        // 后一页
        var nextPageLi = $("<li></li>").append($("<a></a>").append($("<span></span>")
            .append("&raquo;").attr("aria-hidden", "true")).attr("href", "#"));
        if (result.extendMap.pageInfo.hasNextPage == false) {
            lastPageLi.addClass("disabled");
            nextPageLi.addClass("disabled")
        } else {
            // 绑定事件
            nextPageLi.click(function () {
                to_page(result.extendMap.pageInfo.pageNum + 1);

            });
            lastPageLi.click(function () {
                to_page(result.extendMap.pageInfo.pages);
            });
        }


        ul.append(firstPageLi).append(prePageLi);

        var pageNums = result.extendMap.pageInfo.navigatepageNums;
        // item指当前页
        $.each(pageNums, function (index, item) {
            var pageLi = $("<li></li>").append($("<a></a>").append(item).attr("href", "#"));
            if (result.extendMap.pageInfo.pageNum == item) {
                pageLi.addClass("active");
            }
            // 绑定点击事件
            pageLi.click(function () {
                to_page(item);
            });
            ul.append(pageLi);
        });

        ul.append(nextPageLi).append(lastPageLi);
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }

    // 绑定用户添加的事件，点击新增按钮弹出模态框
    $("#emp_add_model_btn").click(function () {
        // 发送Ajax请求，查出部门信息，显示在下拉列表中
        getDepts();
        // 弹出模态框
        $('#empAddModel').modal({
            backdrop: "static"
        });
    });

    // 查出所有部门信息，并显示在下拉列表中
    function getDepts() {
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success:function (result){
                // {"code":100,"msg":"处理成功！","extendMap":{"depts":[{"deptId":1,"deptName":"财务部"},{"deptId":2,"deptName":"开发部"}]}}
                $.each(result.extendMap.depts,function(){
                    // console.log(result);
                    // this也可以代表当前对象
                    var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                    optionEle.appendTo("#dept_add_select");
                });
            }
        });
    }

</script>
</body>
</html>
