<%@page import="web2.clinica.model.negocio.Medico"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Gerenciar Médicos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
</head>
<body class="container mt-4">

    <h2 class="mb-4">Lista de Médicos</h2>

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

    <!-- Botão novo médico -->
    <button class="btn btn-success mb-3"
            data-bs-toggle="modal" data-bs-target="#modalCadastro">Novo Médico</button>

    <a class="btn btn-success mb-3" href="TelaInicialMedico.jsp">Voltar</a>


    <%
        List<Medico> medicos = (List) session.getAttribute("medicos");
    %>

    <!-- Tabela de Médicos -->
    <table class="table table-striped table-bordered">
        <thead class="table-dark">
            <tr>
                <th>CRM</th>
                <th>Nome</th>
                <th>Especialidade</th>
                <th>Contato</th>
                <th>Ações</th>
            </tr>
        </thead>
        <tbody>
        <%
            if (medicos != null) {
                for (Medico m : medicos) {
        %>
            <tr>
                <td><%= m.getCrm() %></td>
                <td><%= m.getNome() %></td>
                <td><%= m.getEspecialidade() %></td>
                <td><%= m.getContato() %></td>
                <td>
                    <a href="MedicoJSP?crm=<%= m.getCrm() %>" class="btn btn-warning btn-sm">Alterar</a>
                    <a href="MedicoJSP?crm=<%= m.getCrm() %>&op=deletar" class="btn btn-danger btn-sm">Deletar</a>
                </td>
            </tr>
        <%
                }
            } else {
        %>
            <tr><td colspan="5" class="text-center">Nenhum médico encontrado.</td></tr>
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
                    <h5 class="modal-title" id="modalCadastroLabel">Cadastrar Médico</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                            aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <%@include file="CadastroAlteracaoMedico.jsp" %>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"></script>

</body>
</html>
