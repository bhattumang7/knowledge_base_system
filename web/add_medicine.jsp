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
        <title>Knowledge Base System | Add Medicines</title>
    </head>
    <%
        boolean is_valid = true;
        if (request.getMethod().equalsIgnoreCase("post"))
        {
            try
            {
                String medicine_name = request.getParameter("medicine_name");
                //     float quantity = Float.parseFloat(request.getParameter("quantity"));
                long medicineTypeLong = Long.parseLong(request.getParameter("medicine_type"));

                medicine_name = medicine_name.trim();
                if (medicine_name.equalsIgnoreCase(""))
                {
                    throw new NumberFormatException();
                }
                /*   if (quantity <= 0)
                 {
                 throw new NumberFormatException();
                 }*/
                if (medicineTypeLong != 0 && medicineTypeLong != 1 && medicineTypeLong != 2)
                {
                    throw new NumberFormatException();
                }
                Medicine m = new Medicine();
                m.setMedicineName(medicine_name);
                //   m.setQuantity(quantity);
                m.setMedicineType(MyMedicineTypeUtil.getMedicineTypeById(medicineTypeLong));
                m.save();
                response.sendRedirect("show_medicines.jsp");

            }
            catch (NumberFormatException nfe)
            {
                is_valid = false;
            }


        }
    %>
    <body>
        <%@include  file="nav.jsp" %>

        <h3>Add Medicines</h3>
        <table>
            <form method="post" action="add_medicine.jsp">
                <tr>
                    <td>
                        <b> Medicine Name  </b>
                    </td>
                    <td>
                        <input type="text" name="medicine_name" maxlength="2500" reqired="reqired" value="<% if (request.getParameter("medicine_name") != null)
                            {
                                out.print(request.getParameter("medicine_name"));
                            }%>" >
                    </td>
                </tr>

                <tr>
                    <td>
                        <b> Medicine Type  </b>
                    </td>
                    <td>
                        <select name="medicine_type">
                            <option value="0" <% if (request.getParameter("medicine_type") != null)
                                {
                                    if (request.getParameter("medicine_type").equalsIgnoreCase("0"))
                                    {
                                        out.print("selected=\"selected\"");
                                    }
                                }%> > Injection </option>
                            <option value="1" <% if (request.getParameter("medicine_type") != null)
                                {
                                    if (request.getParameter("medicine_type").equalsIgnoreCase("1"))
                                    {
                                        out.print("selected=\"selected\"");
                                    }
                                }%> > Liquid </option>
                            <option value="2" <% if (request.getParameter("medicine_type") != null)
                                {
                                    if (request.getParameter("medicine_type").equalsIgnoreCase("2"))
                                    {
                                        out.print("selected=\"selected\"");
                                    }
                                }%>> Tablet </option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="submit" value="Save">
                    </td>
                </tr>
            </form>
        </table>
        <%
            if (!is_valid)
            {
                out.println("PLease correct the input");
            }
        %>
    </div>
</body>
</html>
