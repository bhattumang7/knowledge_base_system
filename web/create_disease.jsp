<%-- 
    Document   : index
    Created on : Nov 19, 2012, 3:49:30 PM
    Author     : umang
--%>

<%@page import="in.umang.StringOperations"%>
<%@page import="in.umang.Symptom"%>
<%@page import="java.util.List"%>
<%@page import="in.umang.Disease"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include  file="include_head.jsp" %>
        <title>Knowledge Base System | Create Disease </title>
    </head>
     
    
    <body>
        <%@include  file="nav.jsp" %>

        <h3>Create Disease</h3>
        <%
            if (request.getMethod().equalsIgnoreCase("post"))
            {
                if (request.getParameter("action") != null && request.getParameter("action").equalsIgnoreCase("createDisease"))
                {
                    String originalExpression = request.getParameter("actualExpression");
                    String newExpression = "";
                    int sCount = 0;
                    for (int i = 0; i < originalExpression.length(); i++)
                    {
                        char c = originalExpression.charAt(i);
                        if (c == '(' || c == ')' || c == '&' || c == '|')
                        {
                            newExpression += c;
                        } else
                        {
                            newExpression += request.getParameterValues("op")[sCount];

                            //       out.print(request.getParameterValues("op")[sCount] + "<br>");
                            sCount++;
                        }

                    }
                    //   out.print( "<br>" + newExpression + "<br> " + request.getParameterValues("op").length + "<br>" +  originalExpression + "<br>" +  newExpression + "<br>"  ) ;

                    Disease disease = new Disease();
                    String diseaseName = request.getParameter("diseaseName");
                    disease.setDiseaseName(diseaseName);
                    disease.setRule(newExpression);
                    disease.saveOrUpdate();
                    response.sendRedirect("disease.jsp");
                }
            }
            //Map<String, String[]> aMap = request.getParameterMap();
            /*
             * for (String key : aMap.keySet()) { out.println(key + "<br>"); for
             * (int i = 0 ; i < aMap.get(key).length ;i++) {
             * out.print(aMap.get(key)[i] + " "); } }
             */
        %>

        <%
            if (request.getParameter("str") == null)
            {
        %>
        <form method="get" action="create_disease.jsp">
            <input type="hidden" name="action" value="getSkeleton">
            Enter Skeleton    <input type="text" name="str" value="<%= request.getParameter("str") == null ? "" : request.getParameter("str").toString()%>">
            <input type="submit" value="ok">
        </form>
        <%
                //
            }
        %>
        <%
            if (request.getParameter("action") != null && request.getParameter("action").equals("getSkeleton"))
            {
                if (request.getParameter("str") != null)
                {
                    String originalString = request.getParameter("str");
                    originalString = StringOperations.removeAllSpaces(originalString);
                    // out.print(originalString);
        %>

      <!--  <h1> Create Disease </h1> -->
        <form method="post" action="create_disease.jsp">
            Disease: <input type="text" name="diseaseName"> <br/> 
            Rule :
            <input type="hidden" value="createDisease" name="action">
            <input type="hidden" name="actualExpression" value="<%= originalString%>"> 
            <%
                for (int i = 0; i < originalString.length(); i++)
                {
                    char c = originalString.charAt(i);
                    if (c == '(' || c == ')' || c == '&' || c == '|')
                    {
//
%>
            <input type="hidden" name="op1" value="<%= c%>"> 
            <%= c%>
            <%//
            } else
            {
                List<Symptom> symptomList = Symptom.getSymptomList();
            %>

            <select name="op" value="">
                <%
                    for (Symptom asymptom : symptomList)
                    {
                %>
                <option value="<%= asymptom.getSymptomID()%>"> <%= asymptom.getSymptomName()%> </a>
                    <%
                        }
                    %>
            </select>
            <%                                    //
                    }
                }
            %>
            <input type="submit" value="Ok">
        </form>
        <%
                }
            }
        %>
        
        
        <%@include  file="bottom.jsp" %>
    </body>
</html>
