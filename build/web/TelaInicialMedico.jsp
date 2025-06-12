<%@ page import="web2.clinica.model.negocio.Medico" %>
<%@ page session="true" %>
<%
    Medico medico = (Medico) session.getAttribute("medicoLogado");
    if (medico == null) {
        response.sendRedirect("loginMedico.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Bem-vindo, Dr. <%= medico.getNome() %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body class="container mt-5">

    <h2>Bem-vindo, Dr. <%= medico.getNome() %></h2>
    <p>CRM: <%= medico.getCrm() %></p>
    <p>Especialidade: <%= medico.getEspecialidade() %></p>
    <p>Contato: <%= medico.getContato() %></p>

    <a href="AlterarSenha.jsp" class="btn btn-warning">Alterar Senha</a>
    <a href="EditarPerfil.jsp" class="btn btn-info">Editar Perfil</a>
    <a href="LogoutMedico" class="btn btn-danger">Sair</a>

</body>
</html>
