<%-- 
    Document   : index
    Created on : Nov 19, 2012, 3:49:30 PM
    Author     : umang
--%>

<%@page import="in.umang.Disease"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include  file="include_head.jsp" %>
        <title>Knowledge Base System | Disease List</title>
    </head>
    <body>
        <%@include  file="nav.jsp" %>

        <h3>Show Disease</h3>
        <%
            List<Disease> aDiseaseList = Disease.getDiseaseList();
            if (aDiseaseList.isEmpty())
            {
                out.println("No desease created yet");
            }
            else
            {
        %>
        <table>
            <tr>
                <td>
                    <b>  Disease ID </b>
                </td>
                <td>
                    <b> Disease Name </b>
                </td>
                <td>
                    <b> Symptom </b>
                </td>
            </tr>
            <%
                for (Disease aDisease : aDiseaseList)
                {
            %>
            <tr>
                <td>
                    <%= aDisease.getDiseaseId()%>
                </td>
                <td>
                    <%= aDisease.getDiseaseName()%>
                </td>
                <td>
                    <%= aDisease.getSymptomAsViewableString()%>
                </td>
            </tr>

            <%//
                }
            %>
        </table>

        <%    }
        %>
    </div>

</body>
</html>
