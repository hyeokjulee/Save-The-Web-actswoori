<%@page import="jdbc.NewsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

String ntitle = request.getParameter("title");
String ncontent = request.getParameter("content");
String nemail = request.getParameter("email");

boolean result = NewsDAO.insertNews(ntitle, ncontent, nemail);

if (result) {
	response.sendRedirect("newsAll.jsp?msg=insertSuccess");
} else {
response.sendRedirect("insertForm.jsp?msg=fail");
}
%>