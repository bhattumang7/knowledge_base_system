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
    <%
        if (request.getMethod().equalsIgnoreCase("post"))
        {
            long id = Long.parseLong(request.getParameter("id"));
            Medicine medicineToBeDeleted = Medicine.getMedicineById(id);
            medicineToBeDeleted.delete();
            response.sendRedirect("show_medicines.jsp");
        }
    %>
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
                    <b> Type </b>
                </td>
                <td>
                    <b> Delete </b>
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
                    <%= aMedicine.getMedicineType()%>
                </td>
                <td>
                    <form method="post" action="show_medicines.jsp">
                        <input type="hidden" name="id" value="<%= aMedicine.getMedicineId()%>">
                        <input type="submit" value="Delete">
                    </form>
                </td>
            </tr>
            <%                        }
            %>
        </table>

        <%     }

        %>       

    </body>
</html>
