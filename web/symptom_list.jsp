<%-- 
    Document   : index
    Created on : Nov 19, 2012, 3:49:30 PM
    Author     : umang
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page import="in.umang.Symptom"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        if (request.getMethod().equalsIgnoreCase("post"))
        {
            String action = request.getParameter("action");

            if (action.equalsIgnoreCase("delete"))
            {
                long id = Long.parseLong( request.getParameter("id") );
                Symptom.deleteById(id);
                response.sendRedirect("symptom_list.jsp");
            }
        }
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include  file="include_head.jsp" %>
        <title>Knowledge Base System | Symptom List</title>
    </head>
    <body>
        <%@include  file="nav.jsp" %>

        <h3>Symptom List</h3>

        <%
            List<Symptom> symptomList = Symptom.getSymptomList();
            if (symptomList.isEmpty())
            {
                out.println("No symptoms entered");
            }
            else
            {
        %>
        <table>
            <tr>
                <td>
                    <b> Symptom ID </b>
                </td>
                <td>
                    <b> Symptom Name </b>
                </td>
                <td>
                    <b> Delete </b>
                </td>
                <td>
                    <b> Edit </b>
                </td>
            </tr>
            <%
                for (Symptom aSymptom : symptomList)
                {
            %>

            <tr>
                <td>
                    <%= aSymptom.getSymptomID()%>
                </td>
                <td>
                    <%= aSymptom.getSymptomName()%>
                </td>
                <td>
                    <form method="post" action="symptom_list.jsp">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="<%= aSymptom.getSymptomID()%>">
                        <input type="submit" value="Delete" >
                    </form>
                </td>
                <td>
                    <form method="post" action="edit_symptom.jsp">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="id" value="<%= aSymptom.getSymptomID()%>">
                        <input type="submit" value="Edit" >
                    </form>
                </td>
            </tr>

            <%    }
                }
            %>

    </body>
</html>
