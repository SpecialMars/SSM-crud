package com.mars.controller;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mars.bean.Employee;
import com.mars.bean.Msg;
import com.mars.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * ClassName:EmployeeController
 * Package:com.mars.controller
 * Description:
 *
 * @Date:2021/11/28 21:06
 * @Author:Mars
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    /**
     * 更新用户信息
     *
     * @param employee
     * @return
     */
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg saveEmp(Employee employee){

        employeeService.updateEmp(employee);
        return Msg.success();
    }

    /**
     * 通过id获取员工信息
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id) {
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp", employee);
    }

    /**
     * 检查用户名是否可用
     *
     * @param empName
     * @return
     */
    @RequestMapping("/checkuser")
    @ResponseBody
    public Msg checkUser(@RequestParam(value = "empName") String empName) {
        // 检验姓名是否符合要求
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF}]{2,5})";
        if (!empName.matches(regx)) {
            return Msg.fail().add("va_msg", "用户名必须为2-5位中文，或6-16位英文");
        }

        // 数据库同名信息校验
        boolean b = employeeService.checkUser(empName);
        if (b) {
            return Msg.success();
        } else {
            return Msg.fail().add("va_msg", "用户名已被占用");
        }
    }

    /**
     * 保存用户信息
     * 1、支持JSR303校验
     * 2、导入Hibernate-Validator
     *
     * @return
     */
    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result) {
        if (result.hasErrors()) {
            // 校验失败，应该返回失败，在模态框中显示校验失败的信息
            Map<String, Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError error : errors) {
                map.put(error.getField(), error.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);
        } else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }

    }

    /**
     * 查找所有用户信息，返回对象为一个JSON字符串
     *
     * @param pn
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJSON(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        // 使用分页助手插件
        // 在查询之前只需要调用，传入页码，和每页的大小（每页查询个数）
        PageHelper.startPage(pn, 5);
        // startPage后紧跟的整个查询就是分页查询
        List<Employee> employeeList = employeeService.getAll();
        // 使用PageInfo包装查询的结果，然后将PageInfo交给页面
        // PageInfo中封装了详细的分页信息，包括查询出来的数据，传入连续显示的页数
        PageInfo page = new PageInfo(employeeList, 5);

        return Msg.success().add("pageInfo", page);
    }

    /**
     * 查询员工数据（分页查询）
     *
     * @return
     */
//    @RequestMapping("/emps")
//    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
//        // 使用分页助手插件
//        // 在查询之前只需要调用，传入页码，和每页的大小（每页查询个数）
//        PageHelper.startPage(pn, 5);
//        // startPage后紧跟的整个查询就是分页查询
//        List<Employee> employeeList = employeeService.getAll();
//        // 使用PageInfo包装查询的结果，然后将PageInfo交给页面
//        // PageInfo中封装了详细的分页信息，包括查询出来的数据，传入连续显示的页数
//        PageInfo page = new PageInfo(employeeList, 5);
//        model.addAttribute("pageInfo", page);
//
//        return "list";
//    }
}
