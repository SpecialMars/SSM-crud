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
<!--编辑用户的模态框-->
<div class="modal fade" id="empUpdateModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">编辑用户</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input"
                                   placeholder="emial">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked">
                                男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="W"> 女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">所在部门</label>
                        <div class="col-sm-4">
                            <!--提交部门id即可-->
                            <select class="form-control" name="dId" id="dept_update_select"></select>
                        </div>
                    </div>
                </form>

            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">修改</button>
            </div>

        </div>
    </div>
</div>

<!--添加用户的模态框-->
<div class="modal fade" id="empAddModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">添加用户</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input"
                                   placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input"
                                   placeholder="emial">
                            <span class="help-block"></span>
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
                <button type="button" class="btn btn-primary" id="emp_save_btn">添加</button>
            </div>

        </div>
    </div>
</div>

<!--搭建显示页面-->
<div class="container">
    <!--标题-->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD BY Mars</h1>
        </div>
    </div>
    <!--按钮-->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button type="button" class="btn btn-success" id="emp_add_model_btn">添加</button>
            <button type="button" class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <!--显示表格数据-->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
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

    // 定义全局变量，用来显示总记录数，和当前页
    var pageTotals, currrentPage;
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
            var checkBoxTd = $("<td></td>").append($("<input type='checkbox' class='check_item'/>"));
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == "M" ? "男" : "女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-success edit_btn")
                .append($("<span><span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            editBtn.attr("edit-id", item.empId);
            var delBtn = $("<button></button>").addClass("btn btn-danger delete_btn")
                .append($("<span><span>").addClass("glyphicon glyphicon-remove")).append("删除");
            delBtn.attr("del-id", item.empId);

            // append方法完成后还会返回原来的元素
            $("<tr></t>").append(checkBoxTd).append(empIdTd).append(empNameTd)
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
            + result.extendMap.pageInfo.total + "条记录");
        pageTotals = result.extendMap.pageInfo.total;
        currrentPage = result.extendMap.pageInfo.pageNum;
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

    // 重置表单内容及样式
    function reset_form(ele) {
        $(ele)[0].reset();
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }

    // 绑定用户添加的事件，点击新增按钮弹出模态框
    $("#emp_add_model_btn").click(function () {
        // 表单提交后重置表单
        reset_form("#empAddModel form");
        // 发送Ajax请求，查出部门信息，显示在下拉列表中
        getDepts("#dept_add_select");
        // 弹出模态框
        $('#empAddModel').modal({
            backdrop: "static"
        });
    });

    // 查出所有部门信息，并显示在下拉列表中
    function getDepts(ele) {
        $(ele).empty();
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success: function (result) {
                $.each(result.extendMap.depts, function () {
                    // this也可以代表当前对象
                    var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    optionEle.appendTo(ele);
                });
            }
        });
    }

    // 为添加绑定点击事件，保存员工信息
    $("#emp_save_btn").click(function () {
        // 先对要提交给服务器的数据进行校验
        if (!validate_add_form()) {
            return false;
        }

        //判断之前的ajax校验是否成功，如果成功，继续执行。不成功则返回
        if ($(this).attr("ajax-va") == "error") {
            return false;
        }

        // 模态框中填写表单数据提交给服务器进行保存
        // 发送ajax请求保存员工
        // 使用序列化
        $.ajax({
            url: "${APP_PATH}/emp",
            type: "POST",
            // 发送的数据就是表格序列化后的数据
            data: $("#empAddModel form").serialize(),
            success: function (result) {
                if (result.code == 100) {
                    // 完成请求后需要将模态框关闭，并到末页
                    $("#empAddModel").modal("hide");
                    // 到最后一页
                    // 发送ajax请求显示最后一页数据
                    to_page(pageTotals);
                } else {
                    // 显示失败信息
                    // console.log(result);
                    // 显示姓名错误信息
                    if (undefined != result.extendMap.errorFields.empName) {
                        // 显示姓名的错误信息
                        show_validate_msg("#empName_add_input", "error", result.extendMap.errorFields.empName);
                    }
                    if (undefined != result.extendMap.errorFields.email) {
                        // 显示邮箱的错误信息
                        show_validate_msg("#email_add_input", "error", result.extendMap.errorFields.email);

                    }
                }

            }
        });
    });

    // 定义校验表单数据方法
    function validate_add_form() {
        // 拿到要校验的数据，使用正则表达式

        // 校验用户姓名
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF}]{2,5})/;
        if (!regName.test(empName)) {
            // alert("用户名格式错误");
            show_validate_msg("#empName_add_input", "error", "用户名必须为2-5位中文，或6-16位英文");
            return false;
        } else {
            show_validate_msg("#empName_add_input", "success", "");
        }
        // 校验用户邮箱
        var email = $("#email_add_input").val();
        var regEmail = /([a-z)-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            // alert("邮箱格式错误");
            show_validate_msg("#email_add_input", "error", "邮箱格式错误");
            return false;
        } else {
            show_validate_msg("#email_add_input", "success", "");
        }
        // 校验成功，返回true
        return true;
    }

    // 信息展示方法
    function show_validate_msg(ele, status, msg) {
        // 先清除原始状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if ("success" == status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if ("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    // 校验用户名是否可用
    $("#empName_add_input").change(function () {
        // 发送ajax请求校验用户名是否可用
        var empName = this.value;
        $.ajax({
            url: "${APP_PATH}/checkuser",
            data: "empName=" + empName,
            type: "POST",
            success: function (result) {
                if (result.code == 100) {
                    show_validate_msg("#empName_add_input", "success", "用户名可用");
                    $("#emp_save_btn").attr("ajax-va", "success");
                } else {
                    show_validate_msg("#empName_add_input", "error", result.extendMap.va_msg);
                    $("#emp_save_btn").attr("ajax-va", "error");
                }
            }
        });
    });


    // 不能用.click绑定因为.click绑定在js加载时绑定事件而编辑按钮是ajax请求带过来的
    // 给编辑按钮绑定事件
    $(document).on("click", ".edit_btn", function () {
        // 查出员工信息，显示员工信息
        getDepts("#dept_update_select");
        // 查出部门信息，显示部门列表
        getEmp($(this).attr("edit-id"));
        // 把用户的id传递给模态框的更新按钮
        $("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));
        // 弹出模态框
        $("#empUpdateModel").modal({
            backdrop: "static"
        });
    });

    // 获取员工信息
    function getEmp(id) {
        $.ajax({
            url: "${APP_PATH}/emp/" + id,
            type: "GET",
            success: function (result) {
                var empData = result.extendMap.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModel input[name = gender]").val([empData.gender]);
                $("#empUpdateModel select").val([empData.dId]);
            }
        });
    }

    // 点击更新按钮，更新员工数据
    $("#emp_update_btn").click(function () {
        // 校验邮箱信息
        var email = $("#email_update_input").val();
        var regEmail = /([a-z)-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            show_validate_msg("#email_update_input", "error", "邮箱格式错误");
            return false;
        } else {
            show_validate_msg("#email_update_input", "success", "");
        }

        // 发送ajax请求保存用户的更新信息
        $.ajax({
            url: "${APP_PATH}/emp/" + $(this).attr("edit-id"),
            // 请求类型应该为PUT，但不能直接定义为PUT
            // 因为Tomcat看到请求为PUT时不会将请求体中的数据封装为Map
            // SpringMVC通过调用request.getParameter()方法就获取不到值
            // 只有POST形式的请求才封装请求体为map

            // 解决方法：添加HttpPutFormContentFilter
            type: "POST",
            data: $("#empUpdateModel form").serialize() + "&_method=PUT",
            success: function (result) {
                // alert(result.msg);
                // 关闭对话框
                $("#empUpdateModel").modal("hide");
                // 回到当前页
                to_page(currrentPage);
            }
        });
    });

    // 单个删除绑定事件
    $(document).on("click", ".delete_btn", function () {
        // 弹出是否确认删除对话框
        // 删除员工姓名
        var del_empName = $(this).parent("tr").find("td:eq(2)").text();
        if (confirm("确认删除【" + del_empName + "】的信息吗?")) {
            // 确认则发送ajax请求删除数据
            $.ajax({
                url: "${APP_PATH}/emp/" + $(this).attr("del-id"),
                type: "POST",
                data: "_method=DELETE",
                success: function (result) {
                    to_page(currrentPage);
                }
            });
        }
    });

    // 完成全选/全不选功能
    $("#check_all").click(function () {
        // attr获取自定义属性的值
        // prop读取dom原生的值
        $(".check_item").prop("checked", $(this).prop("checked"));
    });
    // 如果当前页面选择框全部选中则全选框也要选中
    $(document).on("click", ".check_item", function () {
        var flag = $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked", flag);
    });

    // 给批量删除设定点击事件
    $("#emp_delete_all_btn").click(function () {
        // 获取要删除用户的姓名
        var empNames = "";
        var del_idstr = "";
        $.each($(".check_item:checked"), function () {
            empNames += $(this).parents("tr").find("td:eq(2)").text() + ", ";
            // 组装员工id字符串
            del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-"
        });
        // 去除末尾字符
        empNames = empNames.substring(0, empNames.length - 2);
        del_idstr = del_idstr.substring(0, del_idstr.length - 1);
        if (confirm("您确定要删除【" + empNames + "】这些用户信息吗？")) {
            ""
            // 发送ajax请求删除用户信息
            $.ajax({
                url: "${APP_PATH}/emp/" + del_idstr,
                type: "POST",
                data: "_method=DELETE",
                success: function (result) {
                    to_page(currrentPage);
                }
            });
        }
    });
</script>
</body>
</html>
