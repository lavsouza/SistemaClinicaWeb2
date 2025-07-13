<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="web2" uri="web2.clinica.customTags" %>

<%
    String codigo = request.getParameter("codigo");
    if (codigo != null && !codigo.isEmpty()) {
        request.setAttribute("codigo", codigo);
        request.setAttribute("op", "alterar");
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>
            <c:choose>
                <c:when test="${not empty op}">Alterar</c:when>
                <c:otherwise>Cadastrar</c:otherwise>
            </c:choose>
            Indicador de Exame
        </title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    </head>
    <body class="container mt-5">

    <c:if test="${not empty codigo}">
        <web2:carregaTag entidade="indicadorexame" var="indicador" escopo="requisicao" id="${codigo}" />
    </c:if>

    <h1 class="mb-4">
        <c:choose>
            <c:when test="${not empty op}">Alterar</c:when>
            <c:otherwise>Cadastrar</c:otherwise>
        </c:choose>
        Indicador de Exame
    </h1>

    <form method="post" action="IndicadorExameJSP">

        <c:choose>
            <c:when test="${not empty op}">
                <input type="hidden" name="op" value="alterar"/>
                <input type="hidden" name="codigo" value="${indicador.codigo}"/>
            </c:when>
            <c:otherwise>
                <div class="mb-3">
                    <label for="codigo" class="form-label">Código:</label>
                    <input type="number" name="codigo" id="codigo" class="form-control" required/>
                </div>
            </c:otherwise>
        </c:choose>

        <div class="mb-3">
            <label for="indicador" class="form-label">Indicador:</label>
            <input type="text" name="indicador" id="indicador" class="form-control"
                   value="${indicador.indicador}" required/>
        </div>

        <div class="mb-3">
            <label for="descricao" class="form-label">Descrição:</label>
            <textarea name="descricao" id="descricao" class="form-control" required>${indicador.descricao}</textarea>
        </div>

        <div class="mb-3">
            <label for="minValorReferencia" class="form-label">Valor de Referência Mínimo:</label>
            <input type="number" step="0.01" name="minValorReferencia" id="minValorReferencia" class="form-control"
                   value="${indicador.minValorReferencia}" required/>
        </div>

        <div class="mb-3">
            <label for="maxValorReferencia" class="form-label">Valor de Referência Máximo:</label>
            <input type="number" step="0.01" name="maxValorReferencia" id="maxValorReferencia" class="form-control"
                   value="${indicador.maxValorReferencia}" required/>
        </div>

        <div class="mb-3">
            <button class="btn btn-primary" type="submit">
                <c:choose>
                    <c:when test="${not empty op}">Alterar</c:when>
                    <c:otherwise>Cadastrar</c:otherwise>
                </c:choose>
            </button>

            <c:if test="${empty modal}">
                <a href="${not empty op ? 'IndicadoresExame.jsp' : 'TelaInicialMedico.jsp'}" class="btn btn-secondary">Voltar</a>
            </c:if>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
    crossorigin="anonymous"></script>
</body>
</html>
