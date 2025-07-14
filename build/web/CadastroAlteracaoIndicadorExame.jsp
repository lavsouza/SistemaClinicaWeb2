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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    </head>
    <body class="bg-light">
        <div class="container py-5">
            <div class="row justify-content-center">
                <div class="col-lg-8 col-md-10">
                    <div class="card shadow-lg">
                        <div class="card-header bg-primary text-white">
                            <h1 class="card-title mb-0">
                                <i class="bi bi-clipboard2-pulse me-2"></i>
                                <c:choose>
                                    <c:when test="${not empty op}">Alterar</c:when>
                                    <c:otherwise>Cadastrar</c:otherwise>
                                </c:choose>
                                Indicador de Exame
                            </h1>
                        </div>

                        <div class="card-body">
                            <c:if test="${not empty codigo}">
                                <web2:carregaTag entidade="indicadorexame" var="indicador" escopo="requisicao" id="${codigo}" />
                            </c:if>

                            <form method="post" action="IndicadorExameJSP" class="needs-validation" novalidate>
                                <c:choose>
                                    <c:when test="${not empty op}">
                                        <input type="hidden" name="op" value="alterar"/>
                                        <input type="hidden" name="codigo" value="${indicador.codigo}"/>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="mb-3">
                                            <label for="codigo" class="form-label">Código:</label>
                                            <input type="number" name="codigo" id="codigo" class="form-control" required/>
                                            <div class="invalid-feedback">Por favor, informe o código.</div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>

                                <div class="row g-3">
                                    <div class="col-md-12">
                                        <label for="indicador" class="form-label">Indicador:</label>
                                        <input type="text" name="indicador" id="indicador" class="form-control"
                                               value="${indicador.indicador}" required/>
                                        <div class="invalid-feedback">Por favor, informe o indicador.</div>
                                    </div>

                                    <div class="col-md-12">
                                        <label for="descricao" class="form-label">Descrição:</label>
                                        <textarea name="descricao" id="descricao" class="form-control" rows="3" required>${indicador.descricao}</textarea>
                                        <div class="invalid-feedback">Por favor, informe a descrição.</div>
                                    </div>

                                    <div class="col-md-6">
                                        <label for="minValorReferencia" class="form-label">Valor Mínimo de Referência:</label>
                                        <div class="input-group">
                                            <input type="number" step="0.01" name="minValorReferencia" id="minValorReferencia" 
                                                   class="form-control" value="${indicador.minValorReferencia}" required/>
                                            <span class="input-group-text">mg/dL</span>
                                        </div>
                                        <div class="invalid-feedback">Por favor, informe o valor mínimo.</div>
                                    </div>

                                    <div class="col-md-6">
                                        <label for="maxValorReferencia" class="form-label">Valor Máximo de Referência:</label>
                                        <div class="input-group">
                                            <input type="number" step="0.01" name="maxValorReferencia" id="maxValorReferencia" 
                                                   class="form-control" value="${indicador.maxValorReferencia}" required/>
                                            <span class="input-group-text">mg/dL</span>
                                        </div>
                                        <div class="invalid-feedback">Por favor, informe o valor máximo.</div>
                                    </div>
                                </div>

                                <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                                    <c:if test="${empty modal}">
                                        <a href="${not empty op ? 'IndicadoresExame.jsp' : 'TelaInicialMedico.jsp'}" class="btn btn-secondary me-md-2">
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
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>