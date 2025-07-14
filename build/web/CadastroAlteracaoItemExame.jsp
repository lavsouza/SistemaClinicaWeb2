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
            Item de Exame
        </title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    </head>
    <body class="container mt-5">
        <web2:carregaTag entidade="indicadorexame" var="indicadores" escopo="pagina" />

        <c:if test="${not empty codigo}">
            <web2:carregaTag entidade="itemexame" var="itemexame" escopo="requisicao" id="${codigo}" />
        </c:if>

        <div class="card shadow">
            <div class="card-header bg-primary text-white">
                <h1 class="card-title mb-0">
                    <i class="bi bi-clipboard2-pulse me-2"></i>
                    <c:choose>
                        <c:when test="${not empty op}">Alterar</c:when>
                        <c:otherwise>Cadastrar</c:otherwise>
                    </c:choose>
                    Item de Exame
                </h1>
            </div>

            <div class="card-body">
                <form method="post" action="ItemExameJSP" class="needs-validation" novalidate>
                    <c:choose>
                        <c:when test="${not empty op}">
                            <input type="hidden" name="op" value="alterar"/>
                            <input type="hidden" name="codigo" value="${itemexame.codigo}"/>
                        </c:when>
                        <c:otherwise>
                            <div class="mb-3">
                                <label for="codigo" class="form-label">Código:</label>
                                <input type="number" name="codigo" id="codigo" class="form-control" required/>
                                <div class="invalid-feedback">Por favor, informe o código.</div>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <div class="mb-3">
                        <label for="valorIndicador" class="form-label">Valor Indicador</label>
                        <input type="text" name="valorIndicador" id="valorIndicador" class="form-control"
                               value="${itemexame.valorIndicador}" required/>
                        <div class="invalid-feedback">Por favor, informe o valor do indicador.</div>
                    </div>

                    <div class="mb-3">
                        <label for="observacao" class="form-label">Observação</label>
                        <textarea name="observacao" id="observacao" class="form-control" rows="3" required>${itemexame.observacao}</textarea>
                        <div class="invalid-feedback">Por favor, informe a observação.</div>
                    </div>

                    <div class="mb-3">
                        <label for="codIndicador" class="form-label">Indicador Exame</label>
                        <select class="form-select" name="codIndicador" id="codIndicador" required>
                            <option value="">Selecione um indicador</option>
                            <c:forEach var="indicador" items="${indicadores}">
                                <option value="${indicador.codigo}"> 
                                    ${indicador.indicador}
                                </option>
                            </c:forEach>
                        </select>
                        <div class="invalid-feedback">Por favor, selecione um indicador.</div>
                    </div>

                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                        <c:if test="${empty modal}">
                            <a href="${not empty op ? 'ItensExame.jsp' : 'TelaInicialMedico.jsp'}" class="btn btn-secondary me-md-2">
                                <i class="bi bi-arrow-left"></i> Voltar
                            </a>
                        </c:if>
                        <button class="btn btn-primary" type="submit">
                            <c:choose>
                                <c:when test="${not empty op}">
                                    <i class="bi bi-pencil-square"></i> Alterar
                                </c:when>
                                <c:otherwise>
                                    <i class="bi bi-save"></i> Cadastrar
                                </c:otherwise>
                            </c:choose>
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>