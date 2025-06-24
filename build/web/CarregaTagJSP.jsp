<%-- 
    Document   : CarregaTagJSP
    Created on : Jun 23, 2025, 5:34:11 PM
    Author     : lucas
--%>

<%@ page import="java.util.List" %>
<%@ page import="web2.clinica.model.negocio.Medico" %>
<%@ taglib prefix="web2" uri="web2.clinica.customTags" %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Lista de Médicos</title>
</head>
<body>

<web2:carregaTag entidade="medico" var="m" escopo="pagina" />

<%
    List<Medico> medicos = (List<Medico>) pageContext.getAttribute("m");
    if (medicos != null) {
%>
    <h1>Total de médicos: <%= medicos.size() %></h1>
    <ul>
    <%
        for (Medico m : medicos) {
    %>
        <li>
            <strong>Nome:</strong> <%= m.getNome() %><br/>
            <strong>CRM:</strong> <%= m.getCrm() %><br/>
            <strong>Especialidade:</strong> <%= m.getEspecialidade() %><br/>
            <strong>Contato:</strong> <%= m.getContato() %>
            <hr/>
        </li>
    <%
        }
    %>
    </ul>
<%
    } else {
%>
    <p>Nenhum médico encontrado.</p>
<%
    }
%>

</body>
</html>
