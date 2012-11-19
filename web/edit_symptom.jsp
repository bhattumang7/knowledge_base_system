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
        <title>Knowledge Base System | Edit Symptom</title>
    </head>
    <body>
        <%@include  file="nav.jsp" %>

        <%
            if (request.getParameter("action").equalsIgnoreCase("edit"))
            {
        %>

        <h3>Edit Symptom</h3>
        <%
            Symptom aSymptom = Symptom.getSymptomById(Long.parseLong(request.getParameter("id")));
        %>
        <form method="post" action="edit_symptom.jsp">
            <input type="hidden" name="action" value="save">
            <input type="hidden" name="id" value="<%= aSymptom.getSymptomID()%>">
            <input type="text" name="symptom" value="<%= aSymptom.getSymptomName()%>" maxlength="255" >
            <input type="submit" value="Save" >
        </form>

        <%
            }
            else if (request.getParameter("action").equalsIgnoreCase("save"))
            {
                long id = Long.parseLong(request.getParameter("id"));
                String symptomName = request.getParameter("symptom");
                Symptom aSymptom = Symptom.getSymptomById(id);
                aSymptom.setSymptomName(symptomName);
                aSymptom.update();
                response.sendRedirect("symptom_list.jsp");
            }
        %>



    </body>
</html>
