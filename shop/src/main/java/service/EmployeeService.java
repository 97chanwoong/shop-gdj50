package service;

import java.sql.*;
import java.util.*;
import repository.EmployeeDao;
import repository.OutIdDao;
import vo.Employee;

public class EmployeeService {
	
	// 회원가입 addEmployeeAction.jsp 호출
	public boolean addEmployee(Employee paramEmployee) {
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate();실행시 자동 커밋을 막는다.

			EmployeeDao employeeDao = new EmployeeDao();

			if (employeeDao.insertEmployee(conn, paramEmployee) != 1) {
				throw new Exception(); // 강제 예외처리
			}
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return true;
	}

	// employeeLoginAction.jsp 호출
	public Employee getEmployeeByIdAndPw(Employee paramEmployee) {
		Connection conn = null;
		Employee employee = null;
		try {
			DBUtil dbutil = new DBUtil();
			conn = dbutil.getConnection();
			EmployeeDao employeeDao = new EmployeeDao();
			employee = employeeDao.selectEmployeeLoginByIdAndPw(conn, paramEmployee);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return employee;
	}

	// Employee 탈퇴 액션페이지에서 호출되는 메서드
	public boolean removeEmployee(Employee paramEmployee) {

		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate()실행시 자동 커밋을 막음

			EmployeeDao employeeDao = new EmployeeDao();
			if (employeeDao.deleteEmployee(conn, paramEmployee) != 1) { // 1)
				throw new Exception();
			}
			OutIdDao OutIdDao = new OutIdDao();
			if (OutIdDao.insertOutId(conn, paramEmployee.getEmployeeId()) != 1) {
				throw new Exception();
			} // 2)

			conn.commit();
		} catch (Exception e) {
			e.printStackTrace(); // console에 예외메세지 출력
			try {
				conn.rollback(); // 1) or 2) 실행시 예외가 발생하면 현재 conn 실행쿼리 모두 롤백
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			return false; // 탈퇴 실패
		} finally {
			try {
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return true; // 탈퇴 성공
	}

	// 사원리스트에서 active값 N -> Y 수정
	public boolean modifyEmployeeActiveById(String employeeId, String active) {
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();

			EmployeeDao employeeDao = new EmployeeDao();

			if (employeeDao.updateEmployeeActiveById(conn, employeeId, active) != 1) {
				throw new Exception();
			}
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return true;
	}

	// 사원관리리스트 라스트페이지 구하기
	public int getEmployeeLastPage(int rowPerPage) {
		int lastPage = 0;
		Connection conn = null;

		try {
			conn = new DBUtil().getConnection();
			EmployeeDao employeeDao = new EmployeeDao();
			int totalRow = employeeDao.selectEmployeeCount(conn);
			lastPage = (int) Math.ceil (totalRow / (double)rowPerPage);
			if(lastPage == 0) {
				throw new Exception();
			}
			conn.commit();
		} catch(Exception e) {
			e.printStackTrace();
			// 실패라면 rollback
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		} finally {
			// DB 자원해제
			if(conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return lastPage;
	}

	// 사원관리 리스트
	public List<Employee> getEmployeeList(final int rowPerPage, final int currentPage) {
		List<Employee> list = new ArrayList<Employee>();

		// Connection 받을 변수 초기화
		Connection conn = null;
		
		// 해당페이지 첫페이지 구하기
		/*
		 * 0, 10
		 * 10,20
		 * 20,30
		 * (current-1)*rowPerPage 
		 */
		int beginRow = (currentPage - 1) * rowPerPage;
		
		try {
			// getConnection메서드 실행
			conn = new DBUtil().getConnection();
			// 디버깅
			System.out.println("EmployeeService.java getEmployeeList conn : " + conn);
			// 자동 commit 해제
			conn.setAutoCommit(false);
			
			// EmployeeDao.selectEmployeeList 메서드실행 할 객체생성
			EmployeeDao employeeDao = new EmployeeDao();
			// 메서드실행
			// 리턴값 받기
			list =  employeeDao.selectEmployeeList(conn, rowPerPage, beginRow);
			if(list == null) {
				// 리스트가 없다면
				throw new Exception();
			}
			
			// 완료되었다면 commit	
			conn.commit();
		} catch(Exception e) {
			e.printStackTrace();
			// 완료되지 않았다면 rollback
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		} finally {
			// DB 자원해제
			if(conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		return list;
	}
}
