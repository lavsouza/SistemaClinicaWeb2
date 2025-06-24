<%@page import="web2.clinica.model.negocio.Paciente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="web2" uri="web2.clinica.customTags" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= (request.getAttribute("op") != null) ? "Alterar" : "Cadastrar"%> Paciente</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    </head>
    <body class="container mt-5">

        <h1 class="mb-4"><%= (request.getAttribute("op") != null) ? "Alterar" : "Cadastrar"%> Paciente</h1>

        <form method="post" action="PacienteJSP">

            <%
                String cpf = request.getParameter("cpf");
            %>

            <% if (cpf != null && !cpf.isEmpty()) {%>
            <web2:carregaTag entidade="paciente" var="paciente" escopo="requisicao" id="<%= cpf%>"/>
            <%
                request.setAttribute("op", "alterar");
            %>
            <% } %>


            <%
                Paciente paciente = (Paciente) pageContext.getAttribute("paciente", PageContext.REQUEST_SCOPE);
                boolean alteracao = request.getAttribute("op") != null;
            %>

            <% if (alteracao) {%>
            <input type="hidden" name="op" value="alterar"/>
            <input type="hidden" name="cpf" value="<%= paciente.getCpf()%>"/>
            <% } else { %>
            <div class="mb-3">
                <label for="cpf" class="form-label">CPF:</label>
                <input type="text" name="cpf" id="cpf" class="form-control" required/>
            </div>
            <% }%>

            <div class="mb-3">
                <label for="nome" class="form-label">Nome:</label>
                <input type="text" name="nome" id="nome" class="form-control"
                       value="<%= alteracao ? paciente.getNome() : ""%>" required/>
            </div>

            <div class="mb-3">
                <label for="endereco" class="form-label">Endereço:</label>
                <input type="text" name="endereco" id="endereco" class="form-control"
                       value="<%= alteracao ? paciente.getEndereco() : ""%>" required/>
            </div>

            <div class="mb-3">
                <label for="contato" class="form-label">Contato:</label>
                <input type="text" name="contato" id="contato" class="form-control"
                       value="<%= alteracao ? paciente.getContato() : ""%>" required/>
            </div>

            <div class="mb-3">
                <label for="planoDeSaude" class="form-label">Plano de Saúde:</label>
                <input type="text" name="planoDeSaude" id="planoDeSaude" class="form-control"
                       value="<%= alteracao ? paciente.getPlanoDeSaude() : ""%>" required/>
            </div>

            <div class="mb-3">
                <button class="btn btn-primary" type="submit">
                    <%= alteracao ? "Alterar" : "Cadastrar"%>
                </button>

                <%
                    Boolean isModal = (Boolean) request.getAttribute("modal");
                    if (isModal == null) {
                        isModal = false;
                    }
                %>

                <% if (!isModal) {%>
                <a href="<%= (request.getAttribute("op") != null) ? "Pacientes.jsp" : "TelaInicialMedico.jsp"%>" class="btn btn-secondary">Voltar</a>
                <% }%>
            </div>
            
        </form>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
    </body>
</html>
