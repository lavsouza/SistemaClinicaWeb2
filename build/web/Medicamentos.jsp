<%@page import="web2.clinica.model.negocio.Medicamento"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="web2" uri="web2.clinica.customTags" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gerenciar Medicamentos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
</head>
<body class="container mt-4">
    
<web2:carregaTag entidade="medicamento" var="medicamentos" escopo="pagina" />

<h2 class="mb-4">Lista de Medicamentos</h2>

<%
    String msg = (String) session.getAttribute("msg");
    if (msg != null) {
%>
<div class="alert alert-info alert-dismissible fade show" role="alert">
    <%= msg %>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<%
        session.removeAttribute("msg");
    }
%>

<button class="btn btn-success mb-3"
        data-bs-toggle="modal" data-bs-target="#modalCadastro">Novo Medicamento</button>

<a class="btn btn-secondary mb-3" href="TelaInicialMedico.jsp">Voltar</a>

<%
   List<Medicamento> medicamentos = (List) pageContext.getAttribute("medicamentos");
%>

<table class="table table-striped table-bordered">
    <thead class="table-dark">
    <tr>
        <th>Código</th>
        <th>Nome</th>
        <th>Dosagem</th>
        <th>Tipo de Dosagem</th>
        <th>Descrição</th>
        <th>Observação</th>
        <th>Ações</th>
    </tr>
    </thead>
    <tbody>
    <%
        if (medicamentos != null && !medicamentos.isEmpty()) {
            for (Medicamento m : medicamentos) {
    %>
    <tr>
        <td><%= m.getCodigo() %></td>
        <td><%= m.getNome() %></td>
        <td><%= m.getDosagem() %></td>
        <td><%= m.getTipoDosagem() %></td>
        <td><%= m.getDescricao() %></td>
        <td><%= m.getObservacao() %></td>
        <td>
            <a href="MedicamentoJSP?codigo=<%= m.getCodigo() %>" class="btn btn-warning btn-sm">Alterar</a>
            <a href="MedicamentoJSP?codigo=<%= m.getCodigo() %>&op=deletar" class="btn btn-danger btn-sm">Deletar</a>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr><td colspan="7" class="text-center">Nenhum medicamento encontrado.</td></tr>
    <%
        }
    %>
    </tbody>
</table>

<!-- Modal de cadastro/edição -->
<div class="modal fade" id="modalCadastro" data-bs-backdrop="static" data-bs-keyboard="false"
     tabindex="-1" aria-labelledby="modalCadastroLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalCadastroLabel">Cadastrar Medicamento</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"
                        aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <%
                    request.setAttribute("modal", true);
                %>
                <%@include file="CadastroAlteracaoMedicamento.jsp" %>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>

</body>
</html>
