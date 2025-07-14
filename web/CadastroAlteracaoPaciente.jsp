<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="web2" uri="web2.clinica.customTags" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>
            <c:choose>
                <c:when test="${not empty op}">Alterar</c:when>
                <c:otherwise>Cadastrar</c:otherwise>
            </c:choose>
            Paciente
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
                                <i class="bi bi-person-plus me-2"></i>
                                <c:choose>
                                    <c:when test="${not empty op}">Alterar</c:when>
                                    <c:otherwise>Cadastrar</c:otherwise>
                                </c:choose>
                                Paciente
                            </h1>
                        </div>

                        <div class="card-body">
                            <c:if test="${not empty param.cpf}">
                                <web2:carregaTag entidade="paciente" var="paciente" escopo="requisicao" id="${param.cpf}" />
                                <c:set var="op" value="alterar" />
                            </c:if>

                            <form method="post" action="PacienteJSP" class="needs-validation" novalidate>
                                <c:choose>
                                    <c:when test="${op == 'alterar'}">
                                        <input type="hidden" name="op" value="alterar"/>
                                        <input type="hidden" name="cpf" value="${paciente.cpf}"/>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="mb-3">
                                            <label for="cpf" class="form-label">CPF:</label>
                                            <input type="text" name="cpf" id="cpf" class="form-control" 
                                                   pattern="\d{3}\.?\d{3}\.?\d{3}-?\d{2}" 
                                                   title="Formato: 000.000.000-00" required/>
                                            <div class="invalid-feedback">Informe um CPF válido (000.000.000-00)</div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>

                                <div class="row g-3">
                                    <div class="col-md-12">
                                        <label for="nome" class="form-label">Nome Completo:</label>
                                        <input type="text" name="nome" id="nome" class="form-control" 
                                               value="${paciente.nome}" required/>
                                        <div class="invalid-feedback">Por favor, informe o nome.</div>
                                    </div>

                                    <div class="col-md-8">
                                        <label for="endereco" class="form-label">Endereço:</label>
                                        <input type="text" name="endereco" id="endereco" class="form-control" 
                                               value="${paciente.endereco}" required/>
                                        <div class="invalid-feedback">Por favor, informe o endereço.</div>
                                    </div>

                                    <div class="col-md-4">
                                        <label for="contato" class="form-label">Telefone:</label>
                                        <input type="tel" name="contato" id="contato" class="form-control" 
                                               value="${paciente.contato}" 
                                               pattern="\(?\d{2}\)?[\s-]?\d{4,5}[\s-]?\d{4}" 
                                               title="Formato: (00) 00000-0000" required/>
                                        <div class="invalid-feedback">Informe um telefone válido</div>
                                    </div>

                                    <div class="col-md-12">
                                        <label for="planoDeSaude" class="form-label">Plano de Saúde:</label>
                                        <input type="text" name="planoDeSaude" id="planoDeSaude" class="form-control" 
                                               value="${paciente.planoDeSaude}" required/>
                                        <div class="invalid-feedback">Por favor, informe o plano de saúde.</div>
                                    </div>
                                </div>

                                <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                                    <c:if test="${empty modal}">
                                        <a href="${not empty op ? 'Pacientes.jsp' : 'TelaInicial.html'}" class="btn btn-secondary me-md-2">
                                            <i class="bi bi-arrow-left"></i> Voltar
                                        </a>
                                    </c:if>
                                    <button class="btn btn-primary" type="submit">
                                        <c:choose>
                                            <c:when test="${op == 'alterar'}">
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