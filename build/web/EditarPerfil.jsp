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
    <title>Editar Perfil</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body class="container mt-5">

<h2>Editar Perfil</h2>

<form method="post" action="EditarPerfil">
    <div class="mb-3">
        <label>Nome:</label>
        <input type="text" name="nome" class="form-control" value="<%= medico.getNome() %>" required />
    </div>

    <div class="mb-3">
        <label>Especialidade:</label>
        <input type="text" name="especialidade" class="form-control" value="<%= medico.getEspecialidade() %>" required />
    </div>

    <div class="mb-3">
        <label>Contato:</label>
        <input type="text" name="contato" class="form-control" value="<%= medico.getContato() %>" required />
    </div>

    <button type="submit" class="btn btn-success">Salvar</button>
    <a href="TelaInicialMedico.jsp" class="btn btn-secondary">Cancelar</a>
</form>
</body>
</html>
