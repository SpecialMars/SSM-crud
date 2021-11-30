package com.mars.service;

import com.mars.bean.Employee;
import com.mars.bean.EmployeeExample;
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
     * 查询所有用户
     *
     * @return
     */
    public List<Employee> getAll() {

        return employeeMapper.selectByExampleWithDept(null);
    }

    /**
     * 保存员工方法
     *
     * @param employee
     */
    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    /**
     * 检验用户是否存在
     *
     * @param empName
     */
    public boolean checkUser(String empName) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long l = employeeMapper.countByExample(example);
        return l == 0;
    }

    /**
     * 通过主键获取用户对象
     *
     * @param id
     * @return
     */
    public Employee getEmp(Integer id) {
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }


    /**
     * 更新员工信息
     *
     * @param employee
     */
    public void updateEmp(Employee employee) {

        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    /**
     *
     * 通过id删除用户
     * @param id
     */
    public void deleteEmpById(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    public void deleteBatch(List<Integer> idsList) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpIdIn(idsList);
        employeeMapper.deleteByExample(example);
    }
}
