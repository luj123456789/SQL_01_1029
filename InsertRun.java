package com.kh.start.ward;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

public class InsertRun {
	
	// 어디가 잘못된건지 모르겠습니다...
        
	public static void main(String[] args) {
		// Java코드를 작성해서 WARD테이블에 한 행 INSERT해보기
		/*
		 * WARD테이블에  INSERT를 하기 위한 절차??
		 * 
		 * 1. 디비버 실행(클라이언트 프로그램)
		 * 
		 * 2. 접속하기(콘센트) 누름
		 * 
		 * 3. Oracle Database 선택
		 * 
		 * 4. IP주소, PORT번호, 사용자이름, 비밀번호를 가지고 연결
		 * 
		 * 5. 새 SQL편집기
		 * 
		 * 6. INSERT문 작성 => INSERT INTO WARD VALUES('값', '값', '값', '값')
		 * 
		 * 7. SQL문을 실행
		 * 
		 * 8. UpdateRows : 1
		 * 
		 * 9. COMMIT
		 */
		// 0) 필요한 변수 선언
		Connection conn = null;
		Statement stmt = null;
		int result = 0;
		// Java DataBase Connectivity
		
		// 사용자가 입력한 값을 DBMS로 전달 => COFFEE TABLE INSERT
		Scanner sc = new Scanner(System.in);
		System.out.print("커피명을 입력하세요 > ");
		String coffeeName = sc.nextLine();
		/*
		
		String sql = "INSERT"
				    + "INTO"
		                  +"COFFEE"
				   +"VALUES"
		                  +"("
				          + "SEQ_COFFEE.NEXTVAL"
		                 + ",'" + coffeeName + "'"
		                 + ", SYSDATE)";
		                 */
		StringBuilder sb = new StringBuilder();
		sb.append("INSERT ");
	    sb.append("  INTO ");
	    sb.append("     COFFEE ");
	    sb.append("VALUES ");
	    sb.append("      (");
	    sb.append("      SEQ_COFFEE.NEXTVAL");
	    sb.append("     , '" + coffeeName +"'");
	    sb.append("     , SYSDATE");
	    sb.append("       )");
	    String sql = sb.toString();
	    System.out.println(sql);
	    
	    
		// 오라클 DBMS에다 작업을 하겠다!!
		
		// 리플렉션을 이용해서 동적으로 클래스 로드
		// 1) JDBC Driver등록 -> ORACLE -> ojdbc.jar
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("Driver등록성공!");
			
			// 2) DB서버랑 연결(IP주소, PORT번호, 사용자이름, 비밀번호)
			conn = DriverManager.getConnection("jdbc:oracle:thin:@127.0.0.1:1521/XEPDB1",
                                        "HOSPITAL", 				
                                        "oracle");
			System.out.println("DB 연결성공!");
			
			// 3) 새 SQL 편집기
			stmt = conn.createStatement();
			System.out.println("Statement 객체 생성!");
			
			result = stmt.executeUpdate(sql);
			System.out.println("SQL문 실행성공!");
			
			
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
				System.out.println("1. 프로젝트에 ojdbc.jar파일을 추가하지 않을경우");
				System.out.println("2. oracle.jdbc.driver.OracleDriver에오타");
			} catch (SQLException e) {
				e.printStackTrace();
				System.out.println("SQLSyntaxErrorException -> SQL문을 문법적으로 잘못적었다.");
				System.out.println("username/password; logon denied -> 사용자이름, 비밀번호");
				System.out.println("NullPointerException -> JDBC객체들 확인하기");
				System.out.println("SQLIntegrityConstraintViolation -> 테이블제약조건확인");
				System.out.println("URL을 잘못적었구나");
				
				
				
			} finally {
				try {
				stmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			}
	}
}
			
			
	
		
		

	
	

