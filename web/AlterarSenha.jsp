<%@ page import="web2.clinica.model.negocio.Medico" %>
<%
    Medico medico = (Medico) session.getAttribute("medicoLogado");
    if (medico == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Alterar Senha</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body class="container mt-5">

<h2>Alterar Senha</h2>

<form method="post" action="AlterarSenha">
    <div class="mb-3">
        <label>Nova Senha:</label>
        <input type="password" name="novaSenha" class="form-control" required />
    </div>
    <button type="submit" class="btn btn-primary">Salvar</button>
    <a href="TelaInicialMedico.jsp" class="btn btn-secondary">Cancelar</a>
</form>

<% if (session.getAttribute("msgSenha") != null) { %>
<div class="alert alert-info mt-3"><%= session.getAttribute("msgSenha") %></div>
<% session.removeAttribute("msgSenha"); %>
<% } %>

</body>
</html>
