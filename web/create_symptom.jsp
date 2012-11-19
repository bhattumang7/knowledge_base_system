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
            boolean is_valid = true;
            if (request.getMethod().equalsIgnoreCase("POST"))
            {
                String symptomName = request.getParameter("symptomName");
                symptomName = symptomName.trim();
                if (!symptomName.equals(""))
                {
                    Symptom symptom = new Symptom();
                    symptom.setSymptomName(symptomName);
                    symptom.save();
                    response.sendRedirect("symptom_list.jsp");
                }
                else
                {
                    is_valid = false;
                }
            }
        %>
    </head>
    <body>
        <%@include  file="nav.jsp" %>

        <h3>Create Symptom</h3>
        <form method="post" action="create_symptom.jsp">
            <input type="text" name="symptomName" maxlength="255" value="<%= request.getParameter("symptomName") == null ? "" : request.getParameter("symptomName")%>">
            <input type="submit" value="Create Symptom">
        </form>

        <%
            if (!is_valid)
            {
                out.println("Please enter value");
            }
        %>
    </body>
</html>
