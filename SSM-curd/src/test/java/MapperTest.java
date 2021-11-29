import com.mars.dao.DepartmentMapper;
import com.mars.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * ClassName:MapperTest
 * Package:PACKAGE_NAME
 * Description：测试dao层的工作
 * 推荐Spring的项目就可以使用Spring的单元测试，可以自动注入我们需要的组件
 * 步骤
 * 1、导入SpringTest模块
 * 2、@ContextConfiguration注解指定Spring配置文件的位置
 * 3、直接AutoWired要使用的组件即可
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

    @Autowired
    SqlSession sqlSession;

    @Test
    public void testCRUD() {
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
        // employeeMapper.insertSelective(new Employee(null,"lisi","1","4646@163.com",3));
        // employeeMapper.insertSelective(new Employee(null,"wangwu","0","45252@163.com",2));

        // 测试3：批量在emp表中添加员工
        // 这个mapper可以执行批量操作
//        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
//        for (int i = 0; i < 1000; i++) {
//            String emp_name = UUID.randomUUID().toString().substring(0, 5) + i;
//            String gender = i % 2 == 0 ? "W" : "M";
//            String email = i % 3 == 0 ? emp_name + "@163.com" : emp_name + "@qq.com";
//            int did = i % 2 == 0 ? 1 : 2;
//            mapper.insertSelective(new Employee(null, emp_name, gender, email, did));
//        }
//        System.out.println("添加完成");

    }
}
