package com.mars.controller;

import com.mars.bean.Department;
import com.mars.bean.Msg;
import com.mars.dao.DepartmentMapper;
import com.mars.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * ClassName:DepartmentController
 * Package:com.mars.controller
 * Description:
 *
 * @Date:2021/11/30 10:55
 * @Author:Mars
 */
@Controller
public class DepartmentController {

    @Autowired
    DepartmentService departmentService;

    /**
     *查询所有部门名称
     *
     * @return
     */
    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts(){

        List<Department> departmentList =departmentService.getDepts();

        return Msg.success().add("depts",departmentList);
    }
}
