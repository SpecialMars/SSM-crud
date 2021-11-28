import com.mars.bean.Department;
import com.mars.bean.Employee;
import com.mars.dao.DepartmentMapper;
import com.mars.dao.EmployeeMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * ClassName:MapperTest
 * Package:PACKAGE_NAME
 * Description：测试dao层的工作
 *  推荐Spring的项目就可以使用Spring的单元测试，可以自动注入我们需要的组件
 *  步骤
 *      1、导入SpringTest模块
 *      2、@ContextConfiguration注解指定Spring配置文件的位置
 *      3、直接AutoWired要使用的组件即可
 *
 * @Date:2021/11/28 17:22
 * @Author:Mars
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:applicationContext.xml")
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Test
    public void testCRUD(){
        /*
          1、创建SpringIOC容器
          ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
          2、从容器中获取mapper
          DepartmentMapper departmentMapper = applicationContext.getBean(DepartmentMapper.class);
        */

        // 测试1：在Dept表中添加部门
        //departmentMapper.insertSelective(new Department(null,"开发部"));
        //departmentMapper.insertSelective(new Department(null,"测试部"));

        // 测试2：在emp表中添加员工
        employeeMapper.insertSelective(new Employee(null,"lisi","1","4646@163.com",3));
        employeeMapper.insertSelective(new Employee(null,"wangwu","0","45252@163.com",2));
    }
}
