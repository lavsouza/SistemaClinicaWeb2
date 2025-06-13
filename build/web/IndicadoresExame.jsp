<%@page import="web2.clinica.model.negocio.IndicadorExame"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gerenciar Indicadores de Exame</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
</head>
<body class="container mt-4">

<h2 class="mb-4">Lista de Indicadores de Exame</h2>

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

<!-- Botões -->
<button class="btn btn-success mb-3" data-bs-toggle="modal" data-bs-target="#modalCadastro">
    Novo Indicador
</button>
<a class="btn btn-secondary mb-3" href="index.html">Voltar ao Menu</a>

<%
    List<IndicadorExame> indicadores = (List) session.getAttribute("indicadores");
%>

<!-- Tabela -->
<table class="table table-striped table-bordered">
    <thead class="table-dark">
    <tr>
        <th>Código</th>
        <th>Indicador</th>
        <th>Descrição</th>
        <th>Valor Mínimo</th>
        <th>Valor Máximo</th>
        <th>Ações</th>
    </tr>
    </thead>
    <tbody>
    <%
        if (indicadores != null && !indicadores.isEmpty()) {
            for (IndicadorExame i : indicadores) {
    %>
    <tr>
        <td><%= i.getCodigo() %></td>
        <td><%= i.getIndicador() %></td>
        <td><%= i.getDescricao() %></td>
        <td><%= i.getMinValorReferencia() %></td>
        <td><%= i.getMaxValorReferencia() %></td>
        <td>
            <a href="IndicadorExameJSP?codigo=<%= i.getCodigo() %>" class="btn btn-warning btn-sm">Alterar</a>
            <a href="IndicadorExameJSP?codigo=<%= i.getCodigo() %>&op=deletar" class="btn btn-danger btn-sm">Deletar</a>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="6" class="text-center">Nenhum indicador encontrado.</td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>

<!-- Modal com formulário de cadastro -->
<div class="modal fade" id="modalCadastro" data-bs-backdrop="static" data-bs-keyboard="false"
     tabindex="-1" aria-labelledby="modalCadastroLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalCadastroLabel">Cadastrar Indicador</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <%@include file="CadastroAlteracaoIndicadorExame.jsp" %>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>

</body>
</html>
