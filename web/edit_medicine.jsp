<%-- 
    Document   : index
    Created on : Nov 19, 2012, 3:49:30 PM
    Author     : umang
--%>

<%@page import="in.umang.MyMedicineTypeUtil"%>
<%@page import="in.umang.Medicine"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include  file="include_head.jsp" %>
        <title>Knowledge Base System | Edit Medicine</title>
    </head>
    <body>
        <%@include  file="nav.jsp" %>

        <h3>Edit Medicine</h3>
        <%
            boolean is_valid = true;


            if (request.getParameter("action").equalsIgnoreCase("save"))
            {
                try
                {
                    String medicine_name = request.getParameter("medicine_name");
                    //     float quantity = Float.parseFloat(request.getParameter("quantity"));
                    long medicineTypeLong = Long.parseLong(request.getParameter("medicine_type"));
                    long medicineId = Long.parseLong(request.getParameter("id"));
                    medicine_name = medicine_name.trim();
                    if (medicine_name.equalsIgnoreCase(""))
                    {
                        throw new NumberFormatException();
                    }
                    if (medicineTypeLong != 0 && medicineTypeLong != 1 && medicineTypeLong != 2)
                    {
                        throw new NumberFormatException();
                    }
                    Medicine m = Medicine.getMedicineById(medicineId);
                    m.setMedicineName(medicine_name);
                    m.setMedicineType(MyMedicineTypeUtil.getMedicineTypeById(medicineTypeLong));
                    m.update();
                    response.sendRedirect("show_medicines.jsp");
                }
                catch (Exception e)
                {
                    is_valid = false;
                }
            }
            
            {
                Medicine aMedicine = Medicine.getMedicineById(Long.parseLong(request.getParameter("id")));
        %>

        <table>
            <form method="post" action="edit_medicine.jsp">
                <tr>
                    <td>
                        <b> Medicine Name </b>
                    </td>
                    <td>
                        <input type="hidden" name="id" value="<%= aMedicine.getMedicineId()%>">
                        <input type="hidden" name="action" value="save">
                        <input type="text" name="medicine_name" maxlength="2500" value="<%= aMedicine.getMedicineName()%>" />
                    </td>
                </tr>
                <tr>
                    <td>
                        Medicine Type
                    </td>
                    <td>
                        <select name="medicine_type">
                            <option value="0" <%
                                if (MyMedicineTypeUtil.getIdForMedicineType(aMedicine.getMedicineType()) == 0)
                                {
                                    out.println(" selected=\"selected\" ");
                                }
                                    %> >Injection</option>
                            <option value="1" <%
                                if (MyMedicineTypeUtil.getIdForMedicineType(aMedicine.getMedicineType()) == 1)
                                {
                                    out.println(" selected=\"selected\" ");
                                }
                                    %> >Liquid</option>
                            <option value="2" <%
                                if (MyMedicineTypeUtil.getIdForMedicineType(aMedicine.getMedicineType()) == 2)
                                {
                                    out.println(" selected=\"selected\" ");
                                }
                                    %> >Tablet</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><input type="submit" value="Update"> </td>
                </tr>
            </form>
        </table>


        <%
                if (!is_valid)
                {
                    out.println("please enter valid data");
                }
            }

        %>

    </div>

</body>
</html>
