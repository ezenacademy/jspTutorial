<%@page import="java.util.Random"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
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
	// commons-fileupload라이브러리를 사용하여 파일을 업로드 한다.
	// -----------------------------------------------------------
	// 1. 폼전송인지 파일 전송인지를 검사해 주는 메서드(multipart/form-data인지를 판단)
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	if(!isMultipart){
		out.println("<script>");
		out.println("alert('파일 전송폼을 이용하여 오세요!!!');");
		out.println("location.href='form1.jsp';");
		out.println("</script>");
		return;
	}
	
	// 2. 넘어온 내용을 파싱한다.
	// 1) DiskFileItemFactory 객체를 만든다.
	DiskFileItemFactory factory = new DiskFileItemFactory();
	// 2) ServletFileUpload 객체를 만든다.
	ServletFileUpload upload = new ServletFileUpload(factory);
	// 3) 넘어온 데이터를 파싱하여 FileItem객체 리스트를 생성한다.
	List<FileItem> items = upload.parseRequest(request);

	// 3. 데이터를 각각 처리를 해야 한다.
	String note = "", name="";
	for(FileItem item : items){ // 넘어온 데이터를 1개씩 반복 처리를 한다.
		if (item.isFormField()) {
	       // 일반 폼데이터라면
	       // out.println(item.getFieldName() + " : " + item.getString() + "<br>");
	       switch(item.getFieldName()){
	       case "note":
	    	   note = item.getString("UTF-8");
	    	   break;
	       case "name":
	    	   name = item.getString("UTF-8");
	    	   break;
	       }
	    } else {
	        // 파일이라면
	    	String fieldName = item.getFieldName(); 	// 필드명 읽기
	        String fileName = item.getName();			// 파일명 읽기
	        String contentType = item.getContentType();	// 파일 종류
	        boolean isInMemory = item.isInMemory();		// 메모리/임시폴더 저장되었는지 확인
	        long sizeInBytes = item.getSize();	        // 파일 크기
	        
	        // 파일을 지정 위치에 저장한다.
	        String path = application.getRealPath("upload");
	        // File file = new File(path + "/" + fileName);
	        // 동일한 파일명을 처리하기 위해서는 저장할때 중복되지않는 이름을 만들어서 저장해야 한다.
	        // 그리고 원본이름과 사본의 이름을 디비에 저장해준다. 
	        // 그래야 다운로드시 원본이름으로 바꿔서 다운로드하게 한다.
	        // 사본 파일명을 만든다. : "시간_난수" 로 겹치지 않게 이름을 만들어 준다.
	        String saveFileName = System.nanoTime() + "_" + String.format("%03d",new Random().nextInt(100)+1);
	        File file = new File(path + "/" + saveFileName);
	        item.write(file);
	        out.println(file.getAbsolutePath() + "에 저장 완료!!!<br>");
	        out.println("필드명 : " + fieldName + "<br>");
	        out.println("원본 파일 이름 : " + fileName + "<br>");
	        out.println("저장 파일 이름 : " + saveFileName + "<br>");
	        out.println("파일 종류 : " + contentType + "<br>");
	        out.println("저장 : " + (isInMemory?"메모리":"임시폴더") + "에 저장<br>");
	        out.println("파일 크기 : " + sizeInBytes + "Byte<br><hr>");
	    }
	}
	out.println("이름 : " + name + "<br>");
	out.println("설명 : " + note + "<br>");
%>

</body>
</html>