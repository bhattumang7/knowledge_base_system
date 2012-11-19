<%-- 
    Document   : index
    Created on : Nov 19, 2012, 3:49:30 PM
    Author     : umang
--%>

<%@page import="in.umang.Medicine"%>
<%@page import="in.umang.MedicineForDisease"%>
<%@page import="in.umang.MyStackElement"%>
<%@page import="in.umang.Symptom"%>
<%@page import="in.umang.Rule"%>
<%@page import="in.umang.RuleChecker"%>
<%@page import="in.umang.MyPostfixConverter"%>
<%@page import="in.umang.Disease"%>
<%@page import="java.util.List"%>
<%@page import="java.util.LinkedList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include  file="include_head.jsp" %>
        <title>Knowledge Base System | Query</title>

        <script src="jquery.min1.js" type="text/javascript" >
        </script>

    </head>
    <body>
        <%@include  file="nav.jsp" %>

        <h3>Query</h3>

        <% if (request.getMethod().equalsIgnoreCase("get"))
            {

                String selectBoxContent = "";
                selectBoxContent += "<select name=\"op\">";

                for (Symptom aSymptom : Symptom.getSymptomListIncludeingDeleted())
                {
                    selectBoxContent += "<option value=\"" + aSymptom.getSymptomID() + "\">" + aSymptom.getSymptomName() + "</option>";
                }
                selectBoxContent += "</select>";



        %>
        <form method="post" action="query.jsp">
            Age Group:  <select name="ageGroup">
                <option value="below10"> Below 10 </option>
                <option value="above10"> Above 10 </option>
            </select> <br>
            Age Group:  <select name="sivierity">
                <option value="high"> High </option>
                <option value="normal"> Normal </option>
                <option value="low"> Low </option>
            </select> <br>
            Select Symptoms: <br>
            <label>Symptom : </label> <%= selectBoxContent%>
            <span id = "add_field"> Add Field </span> <br/>
            <input type="submit" value="Search">
        </form>

        <script type = "text/javascript">
            $(function(){
                //create a new field then append it before the add field button
                $("#add_field").click(function(){
                    var new_field =  '<br/><label>Symptom : </label> <%= selectBoxContent%>';
                    //new field+='<label>Age : </label> <input type = \"text\" />';
                    $(this).before(new_field);
                });
            });
        </script>
        <%//
        }
        else
        {
            int count = 0;
            List<Long> aLongList = new LinkedList<Long>();
            for (int i = 0; i < request.getParameterValues("op").length; i++)
            {
                aLongList.add(new Long(request.getParameterValues("op")[i]));
            }
            float medicineMultiplyFactor = 1f;
            if (request.getParameter("ageGroup").equalsIgnoreCase("below10"))
            {
                medicineMultiplyFactor = 0.5f;
            }
            if (request.getParameter("sivierity").equalsIgnoreCase("high"))
            {
                medicineMultiplyFactor *= 2;
            }
            else if (request.getParameter("sivierity").equalsIgnoreCase("low"))
            {
                medicineMultiplyFactor /= 2;
            }

            boolean tablePrinted = false;
            for (Disease aDisease : Disease.getDiseaseList())
            {
                List<MyStackElement> list = MyPostfixConverter.convert(new Rule(aDisease.getRule()).getAsList());

                if (RuleChecker.ruleMatches(list, aLongList))
                {
                    if (tablePrinted == false)
                    {
                        out.print("<table border=\"1\"><tr> <td> <b> Disease </b> </td> <td> <b> Rule </b> </td> <td> <b> Medicine </b> </td> </tr>");
                        tablePrinted = true;
                    }
                    count++;
        %>
    <tr>
        <td>
            <%= aDisease.getDiseaseName()%> 
        </td>
        <td>
            <%= aDisease.getSymptomAsViewableString()%>
        </td>
        <td>
            <table border="1">
                <tr>
                    <td>
                        <b> Medicine Name </b>
                    </td>
                    <td>
                        <b> Type </b>
                    </td>
                    <td>
                        <b> Quantity </b>
                    </td>
                    <td>
                        <b> Times-A-Day </b>
                    </td>
                </tr>
                <%//
                    for (MedicineForDisease aMedicineForDisease : MedicineForDisease.getMedicineForDiseaseByDiseaseId(aDisease.getDiseaseId()))
                    {
                        //
                %>
                <tr>
                    <td>
                        <%= Medicine.getMedicineById(aMedicineForDisease.getMedicineId()).getMedicineName()%>
                    </td>
                    <td>
                        <%= Medicine.getMedicineById(aMedicineForDisease.getMedicineId()).getMedicineType()%>
                    </td>
                    <td>
                        <%= aMedicineForDisease.getQuantity() * medicineMultiplyFactor%> 
                    </td>
                    <td>
                        <%= aMedicineForDisease.getTimesADay()%> 
                    </td>
                </tr>
                <%                               //
                    }
                %>
            </table>
        </td>
    </tr>

    <%
                }
            }
            out.println("</table>");
            if (count == 0)
            {
                out.println("No rule matched with given parameter");
            }
        }

    %>

</div>

</body>
</html>
