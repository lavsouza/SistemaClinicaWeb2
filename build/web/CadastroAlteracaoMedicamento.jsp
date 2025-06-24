<%@page import="web2.clinica.model.negocio.Medicamento"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="web2" uri="web2.clinica.customTags" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title><%= (request.getAttribute("op") != null) ? "Alterar" : "Cadastrar"%> Medicamento</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    </head>
    <body class="container mt-5">

        <h1 class="mb-4"><%= (request.getAttribute("op") != null) ? "Alterar" : "Cadastrar"%> Medicamento</h1>

        <form method="post" action="MedicamentoJSP">
            <%
                String codigo = request.getParameter("codigo");
            %>

            <% if (codigo != null && !codigo.isEmpty()) {%>
            <web2:carregaTag entidade="medicamento" var="medicamento" escopo="requisicao" id="<%= codigo%>"/>
            <%
                request.setAttribute("op", "alterar");
            %>
            <% } %>

            <%
                Medicamento medicamento = (Medicamento) pageContext.getAttribute("medicamento", PageContext.REQUEST_SCOPE);
                boolean alteracao = request.getAttribute("op") != null;
            %>

            <% if (alteracao) {%>
            <input type="hidden" name="op" value="alterar"/>
            <input type="hidden" name="codigo" value="<%= medicamento.getCodigo()%>"/>
            <% } else { %>
            <div class="mb-3">
                <label for="codigo" class="form-label">Código:</label>
                <input type="number" name="codigo" id="codigo" class="form-control" required/>
            </div>
            <% }%>

            <div class="mb-3">
                <label for="nome" class="form-label">Nome:</label>
                <input type="text" name="nome" id="nome" class="form-control"
                       value="<%= alteracao ? medicamento.getNome() : ""%>" required/>
            </div>

            <div class="mb-3">
                <label for="dosagem" class="form-label">Dosagem:</label>
                <input type="number" name="dosagem" id="dosagem" class="form-control"
                       value="<%= alteracao ? medicamento.getDosagem() : ""%>" required/>
            </div>

            <div class="mb-3">
                <label for="tipoDosagem" class="form-label">Tipo de Dosagem:</label>
                <input type="text" name="tipoDosagem" id="tipoDosagem" class="form-control"
                       value="<%= alteracao ? medicamento.getTipoDosagem() : ""%>" required/>
            </div>

            <div class="mb-3">
                <label for="descricao" class="form-label">Descrição:</label>
                <textarea name="descricao" id="descricao" class="form-control" required><%= alteracao ? medicamento.getDescricao() : ""%></textarea>
            </div>

            <div class="mb-3">
                <label for="observacao" class="form-label">Observação:</label>
                <textarea name="observacao" id="observacao" class="form-control"><%= alteracao ? medicamento.getObservacao() : ""%></textarea>
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
                <a href="<%= (request.getAttribute("op") != null) ? "Medicamentos.jsp" : "TelaInicialMedico.jsp"%>" class="btn btn-secondary">Voltar</a>
                <% }%>    
            </div>
        </form>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
    </body>
</html>
