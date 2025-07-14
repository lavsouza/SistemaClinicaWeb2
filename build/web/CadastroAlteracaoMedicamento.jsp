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
                                <i class="bi bi-capsule me-2"></i>
                                <c:choose>
                                    <c:when test="${not empty op}">Alterar</c:when>
                                    <c:otherwise>Cadastrar</c:otherwise>
                                </c:choose>
                                Medicamento
                            </h1>
                        </div>

                        <div class="card-body">
                            <c:if test="${not empty codigo}">
                                <web2:carregaTag entidade="medicamento" var="medicamento" escopo="requisicao" id="${codigo}" />
                            </c:if>

                            <form method="post" action="MedicamentoJSP" class="needs-validation" novalidate>
                                <c:choose>
                                    <c:when test="${not empty op}">
                                        <input type="hidden" name="op" value="alterar"/>
                                        <input type="hidden" name="codigo" value="${medicamento.codigo}"/>
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
                                        <label for="nome" class="form-label">Nome:</label>
                                        <input type="text" name="nome" id="nome" class="form-control"
                                               value="${medicamento.nome}" required/>
                                        <div class="invalid-feedback">Por favor, informe o nome.</div>
                                    </div>

                                    <div class="col-md-6">
                                        <label for="dosagem" class="form-label">Dosagem:</label>
                                        <input type="number" step="0.01" name="dosagem" id="dosagem" class="form-control"
                                               value="${medicamento.dosagem}" required/>
                                        <div class="invalid-feedback">Por favor, informe a dosagem.</div>
                                    </div>

                                    <div class="col-md-6">
                                        <label for="tipoDosagem" class="form-label">Tipo de Dosagem:</label>
                                        <select class="form-select" name="tipoDosagem" id="tipoDosagem" required>
                                            <option value="">Selecione o tipo</option>
                                            <option value="mg" ${medicamento.tipoDosagem == 'mg' ? 'selected' : ''}>mg</option>
                                            <option value="mcg" ${medicamento.tipoDosagem == 'mcg' ? 'selected' : ''}>mcg</option>
                                            <option value="g" ${medicamento.tipoDosagem == 'g' ? 'selected' : ''}>g</option>
                                            <option value="ml" ${medicamento.tipoDosagem == 'ml' ? 'selected' : ''}>ml</option>
                                            <option value="UI" ${medicamento.tipoDosagem == 'UI' ? 'selected' : ''}>UI</option>
                                        </select>
                                        <div class="invalid-feedback">Por favor, selecione o tipo de dosagem.</div>
                                    </div>

                                    <div class="col-md-12">
                                        <label for="descricao" class="form-label">Descrição:</label>
                                        <textarea name="descricao" id="descricao" class="form-control" rows="3" required>${medicamento.descricao}</textarea>
                                        <div class="invalid-feedback">Por favor, informe a descrição.</div>
                                    </div>

                                    <div class="col-md-12">
                                        <label for="observacao" class="form-label">Observação:</label>
                                        <textarea name="observacao" id="observacao" class="form-control" rows="2">${medicamento.observacao}</textarea>
                                    </div>
                                </div>

                                <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                                    <c:if test="${empty modal}">
                                        <a href="${not empty op ? 'Medicamentos.jsp' : 'TelaInicialMedico.jsp'}" class="btn btn-secondary me-md-2">
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