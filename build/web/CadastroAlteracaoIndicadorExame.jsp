<%@page import="web2.clinica.model.negocio.IndicadorExame"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="web2" uri="web2.clinica.customTags" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title><%= (request.getAttribute("op") != null) ? "Alterar" : "Cadastrar"%> Indicador de Exame</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    </head>
    <body class="container mt-5">

        <h1 class="mb-4"><%= (request.getAttribute("op") != null) ? "Alterar" : "Cadastrar"%> Indicador de Exame</h1>

        <form method="post" action="IndicadorExameJSP">
            <%
                String codigo = request.getParameter("codigo");
            %>

            <% if (codigo != null && !codigo.isEmpty()) {%>
            <web2:carregaTag entidade="indicadorexame" var="indicador" escopo="requisicao" id="<%= codigo%>"/>
            <%
                request.setAttribute("op", "alterar");
            %>
            <% } %>

            <%
                IndicadorExame indicador = (IndicadorExame) pageContext.getAttribute("indicador", PageContext.REQUEST_SCOPE);
                boolean alteracao = request.getAttribute("op") != null;
            %>

            <% if (alteracao) {%>
            <input type="hidden" name="op" value="alterar"/>
            <input type="hidden" name="codigo" value="<%= indicador.getCodigo()%>"/>
            <% } else { %>
            <div class="mb-3">
                <label for="codigo" class="form-label">Código:</label>
                <input type="number" name="codigo" id="codigo" class="form-control" required/>
            </div>
            <% }%>

            <div class="mb-3">
                <label for="indicador" class="form-label">Indicador:</label>
                <input type="text" name="indicador" id="indicador" class="form-control"
                       value="<%= alteracao ? indicador.getIndicador() : ""%>" required/>
            </div>

            <div class="mb-3">
                <label for="descricao" class="form-label">Descrição:</label>
                <textarea name="descricao" id="descricao" class="form-control" required><%= alteracao ? indicador.getDescricao() : ""%></textarea>
            </div>

            <div class="mb-3">
                <label for="minValorReferencia" class="form-label">Valor de Referência Mínimo:</label>
                <input type="number" step="0.01" name="minValorReferencia" id="minValorReferencia" class="form-control"
                       value="<%= alteracao ? indicador.getMinValorReferencia() : ""%>" required/>
            </div>

            <div class="mb-3">
                <label for="maxValorReferencia" class="form-label">Valor de Referência Máximo:</label>
                <input type="number" step="0.01" name="maxValorReferencia" id="maxValorReferencia" class="form-control"
                       value="<%= alteracao ? indicador.getMaxValorReferencia() : ""%>" required/>
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
                <a href="<%= (request.getAttribute("op") != null) ? "IndicadoresExame.jsp" : "TelaInicialMedico.jsp"%>" class="btn btn-secondary">Voltar</a>
                <% }%>
            </div>
        </form>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
    </body>
</html>
