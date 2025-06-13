<%@page import="web2.clinica.model.negocio.Medicamento"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= (request.getAttribute("op") != null) ? "Alterar" : "Cadastrar" %> Medicamento</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
</head>
<body class="container mt-5">

<h1 class="mb-4"><%= (request.getAttribute("op") != null) ? "Alterar" : "Cadastrar" %> Medicamento</h1>

<form method="post" action="MedicamentoJSP">

    <%
        Medicamento medicamento = (Medicamento) request.getAttribute("medicamento");
        boolean alteracao = request.getAttribute("op") != null;
    %>

    <% if (alteracao) { %>
    <input type="hidden" name="op" value="alterar"/>
    <input type="hidden" name="codigo" value="<%= medicamento.getCodigo() %>"/>
    <% } else { %>
    <div class="mb-3">
        <label for="codigo" class="form-label">Código:</label>
        <input type="number" name="codigo" id="codigo" class="form-control" required/>
    </div>
    <% } %>

    <div class="mb-3">
        <label for="nome" class="form-label">Nome:</label>
        <input type="text" name="nome" id="nome" class="form-control"
               value="<%= alteracao ? medicamento.getNome() : "" %>" required/>
    </div>

    <div class="mb-3">
        <label for="dosagem" class="form-label">Dosagem:</label>
        <input type="number" name="dosagem" id="dosagem" class="form-control"
               value="<%= alteracao ? medicamento.getDosagem() : "" %>" required/>
    </div>

    <div class="mb-3">
        <label for="tipoDosagem" class="form-label">Tipo de Dosagem:</label>
        <input type="text" name="tipoDosagem" id="tipoDosagem" class="form-control"
               value="<%= alteracao ? medicamento.getTipoDosagem() : "" %>" required/>
    </div>

    <div class="mb-3">
        <label for="descricao" class="form-label">Descrição:</label>
        <textarea name="descricao" id="descricao" class="form-control" required><%= alteracao ? medicamento.getDescricao() : "" %></textarea>
    </div>

    <div class="mb-3">
        <label for="observacao" class="form-label">Observação:</label>
        <textarea name="observacao" id="observacao" class="form-control"><%= alteracao ? medicamento.getObservacao() : "" %></textarea>
    </div>

    <div class="mb-3">
        <button class="btn btn-primary" type="submit">
            <%= alteracao ? "Alterar" : "Cadastrar" %>
        </button>
        <a class="btn btn-secondary" href="index.html">Voltar ao Menu</a>
    </div>

</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
</body>
</html>
