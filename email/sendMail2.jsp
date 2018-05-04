<%@page import="javax.activation.DataHandler"%>
<%@page import="javax.activation.FileDataSource"%>
<%@page import="java.io.File"%>
<%@page import="javax.mail.internet.MimeMultipart"%>
<%@page import="javax.mail.Multipart"%>
<%@page import="javax.mail.internet.MimeBodyPart"%>
<%@page import="javax.mail.BodyPart"%>
<%@page import="javax.mail.PasswordAuthentication"%>
<%@page import="email.util.SMTPAuthenticatior"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
 
// 입력값 받음
String from = request.getParameter("from");
String to = request.getParameter("to");
String subject = request.getParameter("subject");
String content = request.getParameter("content");
 
// SMTP 서버에 접속하기 위한 정보들
Properties p = new Properties(); // 정보를 담을 객체
p.put("mail.smtp.host","smtp.naver.com"); // 네이버 SMTP
p.put("mail.smtp.port", "465");
p.put("mail.smtp.starttls.enable", "true");
p.put("mail.smtp.auth", "true");
p.put("mail.smtp.debug", "true");
p.put("mail.smtp.socketFactory.port", "465");
p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
p.put("mail.smtp.socketFactory.fallback", "false");
 
try{
    /*
    Session ses = Session.getInstance(p, new Authenticator(){
    	@Override
   	    protected PasswordAuthentication getPasswordAuthentication() {
   	        return new PasswordAuthentication("사용자아이디","비번");
   	    }
    });
    */ 
    Authenticator auth = new SMTPAuthenticatior();
    Session ses = Session.getInstance(p,auth);
    ses.setDebug(true);
     
    MimeMessage msg = new MimeMessage(ses); // 메일의 내용을 담을 객체
    msg.setSubject(subject); // 제목
     
    Address fromAddr = new InternetAddress(from);
    msg.setFrom(fromAddr); // 보내는 사람
     
    Address toAddr = new InternetAddress(to);
    msg.addRecipient(Message.RecipientType.TO, toAddr); // 받는 사람
    //---------------------------------------------------------------------------- 
	// 1. 파일을 첨부할 객체
    Multipart multipart = new MimeMultipart();
	// 2. 메세지를 저장할 객체
   	BodyPart messageBodyPart = new MimeBodyPart();
    // 3. 몸체 내용을 지정
    messageBodyPart.setContent(content, "text/html;charset=UTF-8"); // html 전송
    // messageBodyPart.setText(content); // 텍스트 전송
    
    // 4. 파일을 첨부할 객체에 추가
    multipart.addBodyPart(messageBodyPart);
    
    // 5. 파일을 첨부 한다.
    BodyPart filePart = new MimeBodyPart();
    File file = new File(application.getRealPath("mybatisTest.jsp"));
    FileDataSource fds = new FileDataSource(file);
    filePart.setDataHandler(new DataHandler(fds));
    filePart.setFileName(fds.getName());
    
    // 6. 파일을 첨부할 객체에 추가 
    multipart.addBodyPart(filePart);
    
    // 7. 만들어진 Multipart객체를 보낼 메일에 지정한다
    msg.setContent(multipart);
    //---------------------------------------------------------------------------- 
    // 8. 실제 전송 
    Transport.send(msg); // 전송
} catch(Exception e){
    e.printStackTrace();
    out.println("<script>alert('Send Mail Failed..');history.back();</script>");
    // 오류 발생시 뒤로 돌아가도록
    return;
}
 
out.println("<script>alert('Send Mail Success!!');location.href='mailForm.jsp';</script>");
// 성공 시
%>
