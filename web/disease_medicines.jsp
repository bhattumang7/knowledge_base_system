<%-- 
    Document   : index
    Created on : Nov 19, 2012, 3:49:30 PM
    Author     : umang
--%>

<%@page import="org.omg.CORBA.LongLongSeqHelper"%>
<%@page import="in.umang.Medicine"%>
<%@page import="java.util.List"%>
<%@page import="in.umang.MedicineForDisease"%>
<%@page import="in.umang.Disease"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        boolean is_valid = true;
        if (request.getParameter("action") != null)
        {
            String action = request.getParameter("action");
            if (action.equalsIgnoreCase("delete"))
            {
                long id = Long.parseLong(request.getParameter("id"));
                MedicineForDisease aMedicineForDisease = MedicineForDisease.getByd(id);
                aMedicineForDisease.delete();;
                response.sendRedirect("disease_medicines.jsp?id=" + aMedicineForDisease.getDiseaseId());

            }
            else if (action.equalsIgnoreCase("create"))
            {
                try
                {
                    long diseaseId = Long.parseLong(request.getParameter("id"));
                    long medicineId = Long.parseLong(request.getParameter("medicine_id"));
                    float quantity = Float.parseFloat(request.getParameter("quantity"));
                    long timesADay = Long.parseLong(request.getParameter("time_a_day"));
                    if (quantity <= 0 || timesADay <= 0)
                    {
                        throw new NumberFormatException();
                    }
                    MedicineForDisease aMedicineForDisease = new MedicineForDisease();
                    aMedicineForDisease.setDiseaseId(diseaseId);
                    aMedicineForDisease.setMedicineId(medicineId);
                    aMedicineForDisease.setQuantity(quantity);
                    aMedicineForDisease.setTimesADay(timesADay);
                    aMedicineForDisease.save();
                    response.sendRedirect("disease_medicines.jsp?id=" + request.getParameter("id"));
                }
                catch (NumberFormatException nfe)
                {
                    is_valid = false;
                }
            }
        }
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include  file="include_head.jsp" %>
        <title>Knowledge Base System | Home</title>
    </head>
    <body>
        <%@include  file="nav.jsp" %>
        <%
            Disease aDisease = Disease.getDiseaseById(Long.parseLong(request.getParameter("id")));
        %>
        <h3>Medicines for Disease(<%= aDisease.getDiseaseName()%>)  </h3>

        <%
            List<MedicineForDisease> aMedicineDiseaseList = MedicineForDisease.getMedicineForDiseaseByDiseaseId(aDisease.getDiseaseId());
            if (aMedicineDiseaseList.isEmpty())
            {
                out.println("No medicines entered for " + aDisease.getDiseaseName());
            }
            else
            {
        %>

        <table border="1">

            <tr>
                <td>
                    <b> Medicine Id </b>
                </td>
                <td>
                    <b> Medicine Name </b>
                </td>
                <td>
                    <b>  Times-A-Day </b>
                </td>
                <td>
                    <b> Quantity </b>
                </td>
                <td>
                    <b> Delete </b>
                </td>
            </tr>
            <%
                for (MedicineForDisease aMedicineForDisease : aMedicineDiseaseList)
                {
            %>

            <tr>
                <td>
                    <%= aMedicineForDisease.getMedicineId()%>
                </td>
                <td>
                    <%= Medicine.getMedicineById(aMedicineForDisease.getMedicineId()).getMedicineName()%>
                </td>
                <td>
                    <%= aMedicineForDisease.getTimesADay()%>
                </td>
                <td>
                    <%= aMedicineForDisease.getQuantity()%>
                </td>
                <td>
                    <form method="get" action="disease_medicines.jsp">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="<%= aMedicineForDisease.getId()%>" >
                        <input type="submit" value="Delete">
                    </form>
                </td>
            </tr>

            <%                        }
            %>

        </table>


        <%                    }
        %>

        <br>
        <br>
        <h3> Add Medicine </h3>
        <form method="get" action="disease_medicines.jsp">
            <input type="hidden" name="id" value="<%= aDisease.getDiseaseId()%>" >
            <input type="hidden" name="action" value="create" >
            <table>
                <tr>
                    <td>
                        Medicine
                    </td>
                    <td>
                        <select name="medicine_id">
                            <%
                                for (Medicine aMedicine : Medicine.getMedicineList())
                                {
                            %>
                            <option value="<%= aMedicine.getMedicineId()%>" <%
                                if (request.getParameter("medicine_id") != null)
                                {
                                    long medicine_id = Long.parseLong(request.getParameter("medicine_id"));

                                    if (medicine_id == aMedicine.getMedicineId())
                                    {
                                        out.println("selected=\"selected\"");
                                    }
                                }
                                    %> > <%= aMedicine.getMedicineName()%> </option>
                            <%    }
                            %>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>
                        Quantity
                    </td>
                    <td>
                        <input type="text" name="quantity" value="<%= request.getParameter("quantity") != null ? request.getParameter("quantity") : ""%>">
                    </td>
                </tr>
                <tr>
                    <td>
                        Times-A-Day
                    </td>
                    <td>
                        <input type="text" name="time_a_day"  value="<%= request.getParameter("time_a_day") != null ? request.getParameter("time_a_day") : ""%>">
                    </td>
                </tr>
                <tr>
                    <tD>
                        <input type="submit" value="Add">
                    </td>
                </tr>
            </table>
        </form>
    </div>

</body>
</html>
