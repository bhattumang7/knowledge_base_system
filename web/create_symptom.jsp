<%-- 
    Document   : index
    Created on : Nov 19, 2012, 3:49:30 PM
    Author     : umang
--%>

<%@page import="in.umang.Symptom"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include  file="include_head.jsp" %>
        <title>Knowledge Base System | Create Symptom</title>
        
         <%
            if (request.getMethod().equalsIgnoreCase("POST"))
            {
                String symptomName = request.getParameter("symptomName");
                Symptom symptom = new Symptom();
                symptom.setSymptomName(symptomName);
                symptom.save();
                response.sendRedirect("symptom_list.jsp");
            }
        %>
    </head>
    <body>
        <%@include  file="nav.jsp" %>

        <h3>Create Symptom</h3>
        <form method="post" action="create_symptom.jsp">
            <input type="text" name="symptomName" maxlength="255">
            <input type="submit" value="Create Symptom">
        </form>
        
        <%@include  file="bottom.jsp" %>
    </body>
</html>
