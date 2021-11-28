package com.mars.service;

import com.mars.bean.Employee;
import com.mars.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * ClassName:EmployeeService
 * Package:com.mars.service
 * Description:
 *
 * @Date:2021/11/28 21:08
 * @Author:Mars
 */
@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    /**
     * 查询所有员工
     * @return
     */
    public List<Employee> getAll() {

        return employeeMapper.selectByExampleWithDept(null);
    }
}
