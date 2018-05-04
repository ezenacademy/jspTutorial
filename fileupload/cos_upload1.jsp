<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="UTF-8"/>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	if(!request.getMethod().equals("POST")){
		out.println("<script>");
		out.println("alert('파일 전송폼을 이용하여 오세요!!!');");
		out.println("location.href='form3.jsp';");
		out.println("</script>");
		return;
	}
	// cos-fileupload 라이브러리를 사용하여 파일을 업로드 한다.
    String upload_path = application.getRealPath("upload"); // 업로드할 경로
    int size = 10 * 1024 * 1024;  // 업로드 크기 제한
    String filename = "", name="", note="";
    int filesize = 0;
    try {
        // 이순간 모드 업로드가 이루어진다.
        MultipartRequest multi = 
        		new MultipartRequest(request, upload_path, size, "utf-8", new DefaultFileRenamePolicy());
        
        // 폼필드의 내용을 읽자.
        name = multi.getParameter("name");
        note = multi.getParameter("note");
        out.println("이름 : " + name + "<br>");
        out.println("설명 : " + note + "<br>");
        // 파일 처리를 하자
        Enumeration<String> files = multi.getFileNames(); // 필드명 리스트
        while(files.hasMoreElements()){
        	String fieldName = files.nextElement();
        	String ofile = multi.getOriginalFileName(fieldName); 	// 원본 파일 이름
            filename = multi.getFilesystemName(fieldName);			// 저장 파일 이름	
            String contentType = multi.getContentType(fieldName);	// 파일 타입
        	File f1 = multi.getFile(fieldName);			
			filesize = (int) f1.length(); 							// 파일 크기
			out.println("필드명 : " + fieldName + "<br>");
			out.println("원본 파일 이름 : " + ofile + "<br>");
			out.println("저장 파일 이름	 : " + filename + "<br>");
			out.println("파일 크기 : " + filesize + "<br>");
			out.println("파일 타입 : " + contentType + "<br><hr>");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</body>
</html>