package com.mars.service;

import com.mars.bean.Department;
import com.mars.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * ClassName:DepartmentService
 * Package:com.mars.service
 * Description:
 *
 * @Date:2021/11/30 11:14
 * @Author:Mars
 */
@Service
public class DepartmentService {

    @Autowired
    DepartmentMapper departmentMapper;

    public List<Department> getDepts(){

        List<Department> departmentList = departmentMapper.selectByExample(null);
        return departmentList;
    }
}
