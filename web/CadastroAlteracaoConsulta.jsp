<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="web2" uri="web2.clinica.customTags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>
            <c:choose>
                <c:when test="${op eq 'alterar'}">Alterar Consulta</c:when>
                <c:otherwise>Cadastrar Consulta</c:otherwise>
            </c:choose>
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
                            <h2 class="card-title mb-0">
                                <i class="bi bi-calendar2-plus me-2"></i>
                                <c:choose>
                                    <c:when test="${op eq 'alterar'}">Alterar Consulta</c:when>
                                    <c:otherwise>Cadastrar Consulta</c:otherwise>
                                </c:choose>
                            </h2>
                        </div>

                        <div class="card-body">
                            <web2:carregaTag entidade="medico" var="medicos" escopo="pagina" />
                            <web2:carregaTag entidade="paciente" var="pacientes" escopo="pagina" />

                            <c:if test="${not empty sessionScope.msg}">
                                <div class="alert alert-info alert-dismissible fade show" role="alert">
                                    <i class="bi bi-info-circle-fill me-2"></i>
                                    ${sessionScope.msg}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                                <c:remove var="msg" scope="session"/>
                            </c:if>

                            <form method="post" action="ConsultaJSP" class="needs-validation" novalidate>
                                <c:if test="${op eq 'alterar'}">
                                    <input type="hidden" name="op" value="alterar"/>
                                    <input type="hidden" name="codigo" value="${consulta.codigo}"/>
                                </c:if>

                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label for="codigo" class="form-label">Código da Consulta:</label>
                                        <input type="number" class="form-control" id="codigo" name="codigo" required
                                               <c:if test="${op eq 'alterar'}">readonly</c:if>
                                               value="${consulta.codigo}"/>
                                        <div class="invalid-feedback">Por favor, informe o código.</div>
                                    </div>

                                    <div class="col-md-6">
                                        <label for="data" class="form-label">Data:</label>
                                        <input type="date" name="data" id="data" class="form-control" required
                                               value="${data}"/>
                                        <div class="invalid-feedback">Por favor, informe a data.</div>
                                    </div>

                                    <div class="col-md-6">
                                        <label for="hora" class="form-label">Hora:</label>
                                        <input type="time" name="hora" id="hora" class="form-control" required
                                               value="${hora}"/>
                                        <div class="invalid-feedback">Por favor, informe a hora.</div>
                                    </div>

                                    <div class="col-md-6">
                                        <label for="crm" class="form-label">Médico:</label>
                                        <select class="form-select" name="crm" id="crm" required>
                                            <option value="">Selecione um médico</option>
                                            <c:forEach var="m" items="${medicos}">
                                                <option value="${m.crm}" ${consulta.medico.crm == m.crm ? 'selected' : ''}>
                                                    Dr. ${m.nome} - ${m.especialidade}
                                                </option>
                                            </c:forEach>
                                        </select>
                                        <div class="invalid-feedback">Por favor, selecione um médico.</div>
                                    </div>

                                    <div class="col-md-6">
                                        <label for="cpf" class="form-label">Paciente:</label>
                                        <select class="form-select" name="cpf" id="cpf" required>
                                            <option value="">Selecione um paciente</option>
                                            <c:forEach var="p" items="${pacientes}">
                                                <option value="${p.cpf}" ${consulta.paciente.cpf == p.cpf ? 'selected' : ''}>
                                                    ${p.nome} - ${p.planoDeSaude}
                                                </option>
                                            </c:forEach>
                                        </select>
                                        <div class="invalid-feedback">Por favor, selecione um paciente.</div>
                                    </div>
                                </div>

                                <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                                    <c:if test="${empty modal}">
                                        <a href="${not empty op ? 'Consultas.jsp' : 'TelaInicial.jsp'}" class="btn btn-secondary me-md-2">
                                            <i class="bi bi-arrow-left"></i> Voltar
                                        </a>
                                    </c:if>
                                    <a href="Consultas.jsp" class="btn btn-outline-primary me-md-2">
                                        <i class="bi bi-list-ul"></i> Lista Consultas
                                    </a>
                                    <button type="submit" class="btn btn-success">
                                        <c:choose>
                                            <c:when test="${op eq 'alterar'}">
                                                <i class="bi bi-pencil-square"></i> Atualizar
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