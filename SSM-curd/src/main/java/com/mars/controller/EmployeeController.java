package com.mars.controller;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mars.bean.Employee;
import com.mars.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

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
     * 查询员工数据（分页查询）
     *
     * @return
     */
    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
        // 使用分页助手插件
        // 在查询之前只需要调用，传入页码，和每页的大小（每页查询个数）
        PageHelper.startPage(pn, 5);
        // startPage后紧跟的整个查询就是分页查询
        List<Employee> employeeList = employeeService.getAll();
        // 使用PageInfo包装查询的结果，然后将PageInfo交给页面
        // PageInfo中封装了详细的分页信息，包括查询出来的数据，传入连续显示的页数
        PageInfo page = new PageInfo(employeeList, 5);
        model.addAttribute("pageInfo", page);

        return "list";
    }
}
