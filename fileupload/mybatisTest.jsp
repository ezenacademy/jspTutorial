<%@page import="mybatis.util.MybatisApp"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="org.apache.ibatis.session.SqlSessionFactoryBuilder"%>
<%@page import="org.apache.ibatis.session.SqlSessionFactory"%>
<%@page import="org.apache.ibatis.io.Resources"%>
<%@page import="java.io.Reader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	/*
	String resource = "MybatisConfig.xml";
	Reader reader = Resources.getResourceAsReader(resource);
	SqlSessionFactory sqlMapper = new SqlSessionFactoryBuilder().build(reader);
	
	SqlSession sqlSession = sqlMapper.openSession();
	*/
	SqlSession sqlSession = MybatisApp.getSessionFactory().openSession();
	try {
	
		String today = sqlSession.selectOne("test.today");
		out.println("현재 날짜 : " + today + "<br>");
		int t = sqlSession.selectOne("test.doobae",5);
		out.println("5의 두배 : " + t  + "<br>");
		
		sqlSession.commit();
	} finally {
		sqlSession.close();
	}
	%>
</body>
</html>