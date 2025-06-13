<%@page import="web2.clinica.model.negocio.Paciente"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Gerenciar Pacientes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
</head>
<body class="container mt-4">

<h2 class="mb-4">Lista de Pacientes</h2>

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

<!-- Botão novo paciente -->
<button class="btn btn-success mb-3"
        data-bs-toggle="modal" data-bs-target="#modalCadastro">Novo Paciente</button>

<a class="btn btn-success mb-3" href="index.html">Voltar ao Menu</a>

<%
    List<Paciente> pacientes = (List) session.getAttribute("pacientes");
%>

<!-- Tabela de Pacientes -->
<table class="table table-striped table-bordered">
    <thead class="table-dark">
    <tr>
        <th>CPF</th>
        <th>Nome</th>
        <th>Endereço</th>
        <th>Contato</th>
        <th>Plano de Saúde</th>
        <th>Ações</th>
    </tr>
    </thead>
    <tbody>
    <%
        if (pacientes != null && !pacientes.isEmpty()) {
            for (Paciente p : pacientes) {
    %>
    <tr>
        <td><%= p.getCpf() %></td>
        <td><%= p.getNome() %></td>
        <td><%= p.getEndereco() %></td>
        <td><%= p.getContato() %></td>
        <td><%= p.getPlanoDeSaude() %></td>
        <td>
            <a href="PacienteJSP?cpf=<%= p.getCpf() %>" class="btn btn-warning btn-sm">Alterar</a>
            <a href="PacienteJSP?cpf=<%= p.getCpf() %>&op=deletar" class="btn btn-danger btn-sm">Deletar</a>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr><td colspan="6" class="text-center">Nenhum paciente encontrado.</td></tr>
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
                <h5 class="modal-title" id="modalCadastroLabel">Cadastrar Paciente</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"
                        aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <%@include file="CadastroAlteracaoPaciente.jsp" %>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>

</body>
</html>
