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
            Medicamento
        </title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    </head>
    <body class="container mt-5">

    <c:if test="${not empty codigo}">
        <web2:carregaTag entidade="medicamento" var="medicamento" escopo="requisicao" id="${codigo}" />
    </c:if>

    <h1 class="mb-4">
        <c:choose>
            <c:when test="${not empty op}">Alterar</c:when>
            <c:otherwise>Cadastrar</c:otherwise>
        </c:choose>
        Medicamento
    </h1>

    <form method="post" action="MedicamentoJSP">

        <c:choose>
            <c:when test="${not empty op}">
                <input type="hidden" name="op" value="alterar"/>
                <input type="hidden" name="codigo" value="${medicamento.codigo}"/>
            </c:when>
            <c:otherwise>
                <div class="mb-3">
                    <label for="codigo" class="form-label">Código:</label>
                    <input type="number" name="codigo" id="codigo" class="form-control" required/>
                </div>
            </c:otherwise>
        </c:choose>

        <div class="mb-3">
            <label for="nome" class="form-label">Nome:</label>
            <input type="text" name="nome" id="nome" class="form-control"
                   value="${medicamento.nome}" required/>
        </div>

        <div class="mb-3">
            <label for="dosagem" class="form-label">Dosagem:</label>
            <input type="number" name="dosagem" id="dosagem" class="form-control"
                   value="${medicamento.dosagem}" required/>
        </div>

        <div class="mb-3">
            <label for="tipoDosagem" class="form-label">Tipo de Dosagem:</label>
            <input type="text" name="tipoDosagem" id="tipoDosagem" class="form-control"
                   value="${medicamento.tipoDosagem}" required/>
        </div>

        <div class="mb-3">
            <label for="descricao" class="form-label">Descrição:</label>
            <textarea name="descricao" id="descricao" class="form-control" required>${medicamento.descricao}</textarea>
        </div>

        <div class="mb-3">
            <label for="observacao" class="form-label">Observação:</label>
            <textarea name="observacao" id="observacao" class="form-control">${medicamento.observacao}</textarea>
        </div>

        <div class="mb-3">
            <button class="btn btn-primary" type="submit">
                <c:choose>
                    <c:when test="${not empty op}">Alterar</c:when>
                    <c:otherwise>Cadastrar</c:otherwise>
                </c:choose>
            </button>

            <c:choose>
                <c:when test="${not modal}">
                    <a href="${not empty op ? 'Medicamentos.jsp' : 'TelaInicialMedico.jsp'}" class="btn btn-secondary">Voltar</a>
                </c:when>
            </c:choose>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
    crossorigin="anonymous"></script>
</body>
</html>
