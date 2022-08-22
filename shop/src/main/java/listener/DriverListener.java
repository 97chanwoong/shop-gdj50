package listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;


@WebListener
public class DriverListener implements ServletContextListener {

    public void contextInitialized(ServletContextEvent sce)  { //톰캣 실행 때 실행
    	// 1. application.setAttribute에 currentCounter 속성 0으로 초기화
    	sce.getServletContext().setAttribute("currentCounter", 0);
    	
    	// 2. 톰캣 부팅시 드라이버 로딩
    	try {
			Class.forName("org.mariadb.jdbc.Driver");
			// 디버깅
			System.out.println("Class.forName 드라이버로딩 성공");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
    }
}
