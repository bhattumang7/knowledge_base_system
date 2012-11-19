<%-- 
    Document   : index
    Created on : Nov 19, 2012, 3:49:30 PM
    Author     : umang
--%>

<%@page import="in.umang.Medicine"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include  file="include_head.jsp" %>
        <title>Knowledge Base System | Show Medicines</title>
    </head>
    <body>
        <%@include  file="nav.jsp" %>

        <h3>Show Medicines</h3>

        <%
            List<Medicine> aMedicineList = Medicine.getMedicineList();
            if (aMedicineList.isEmpty())
            {
        %>
        No medicines entered
        <%        }
        else
        {
        %>

        <table>
            <tr>
                <td>
                    <b> Medicine Id </b>
                </td>
                <td>
                    <b> Medicine Name </b>
                </td>
                <td>
                    <b> Quantity </b>
                </td>
                <td>
                    <b> Type </b>
                </td>
            </tr>
            <%
                for (Medicine aMedicine : aMedicineList)
                {
            %>

            <tr>
                <td>
                    <%= aMedicine.getMedicineId()%>
                </td>
                <td>
                    <%= aMedicine.getMedicineName()%>
                </td>
                <td>
                    <%= aMedicine.getQuantity()%>
                </td><td>
                    <%= aMedicine.getMedicineType()%>
                </td>

            </tr>
            <%                        }
            %>
        </table>

        <%     }

        %>       

    </body>
</html>
