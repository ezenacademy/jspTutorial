<%@page import="java.net.URLEncoder"%>
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
		out.println("location.href='form4.jsp';");
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
        	File f1 = multi.getFile(fieldName);			
			if(f1!=null){        	
				filesize = (int) f1.length(); 							// 파일 크기
	        	String ofile = multi.getOriginalFileName(fieldName); 	// 원본 파일 이름
	            filename = multi.getFilesystemName(fieldName);			// 저장 파일 이름	
	            String contentType = multi.getContentType(fieldName);	// 파일 타입
				out.println("필드명 : " + fieldName + "<br>");
				out.println("원본 파일 이름 : " + ofile + "<br>");
				out.println("저장 파일 이름	 : " + filename + "<br>");
				out.println("파일 크기 : " + filesize + "<br>");
				out.println("파일 타입 : " + contentType + "<br><hr>");
				// 다운로드를 구현해보자~~~~
				// 아래와 같이 링크를 걸면 브라우져가 해석 가능한 형태의 파일이면 보여주고
				// 그렇지 않은 경우에는 다운로드가 된다. 
				out.println("<a href='" + "upload/" + filename + "'>" + ofile  + "</a><br><hr>");
				// 모든 파일을 다운로드 가능하게 하려면 다음과 같이 해야 한다.
				String of = URLEncoder.encode(ofile,"UTF-8"); 
				String sf = URLEncoder.encode(filename,"UTF-8"); 
				out.println("<a href='download.jsp?of="+of+"&sf="+sf+"'>" + ofile  + "</a><br><hr>");
			}
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</body>
</html>