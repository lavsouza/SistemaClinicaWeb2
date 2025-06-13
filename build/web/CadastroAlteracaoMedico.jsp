<%@page import="web2.clinica.model.negocio.Medico"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title><%= (request.getAttribute("op") != null) ? "Alterar" : "Cadastrar" %> Médico</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
</head>
<body class="container mt-5">

<h1 class="mb-4"><%= (request.getAttribute("op") != null) ? "Alterar" : "Cadastrar" %> Médico</h1>

<form method="post" action="MedicoJSP">

    <% if (request.getAttribute("op") != null) {
        Medico medico = (Medico) request.getAttribute("medico");
    %>
    <input type="hidden" name="op" value="alterar"/>
    <input type="hidden" name="crm" value="<%= medico.getCrm() %>"/>
    <% } else { %>
    <div class="mb-3">
        <label for="crm" class="form-label">CRM:</label>
        <input type="text" name="crm" id="crm" class="form-control" required/>
    </div>
    <% } %>

    <div class="mb-3">
        <label for="nome" class="form-label">Nome:</label>
        <input type="text" name="nome" id="nome" class="form-control"
               value="<%= (request.getAttribute("op") != null) ? ((Medico) request.getAttribute("medico")).getNome() : "" %>" required/>
    </div>

    <div class="mb-3">
        <label for="especialidade" class="form-label">Especialidade:</label>
        <input type="text" name="especialidade" id="especialidade" class="form-control"
               value="<%= (request.getAttribute("op") != null) ? ((Medico) request.getAttribute("medico")).getEspecialidade() : "" %>" required/>
    </div>

    <div class="mb-3">
        <label for="contato" class="form-label">Contato:</label>
        <input type="text" name="contato" id="contato" class="form-control"
               value="<%= (request.getAttribute("op") != null) ? ((Medico) request.getAttribute("medico")).getContato() : "" %>" required/>
    </div>

    <div class="mb-3">
        <label for="senha" class="form-label">Senha:</label>
        <input type="password" name="senha" id="senha" class="form-control"
               value="<%= (request.getAttribute("op") != null) ? ((Medico) request.getAttribute("medico")).getSenha() : "" %>" required/>
    </div>

    <button class="btn btn-primary" type="submit">
        <%= (request.getAttribute("op") != null) ? "Alterar" : "Cadastrar" %>
    </button>


</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
</body>
</html>
