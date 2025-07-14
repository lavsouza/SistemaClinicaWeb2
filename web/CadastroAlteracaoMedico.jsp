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
            Médico
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
                                <i class="bi bi-person-badge me-2"></i>
                                <c:choose>
                                    <c:when test="${not empty op}">Alterar</c:when>
                                    <c:otherwise>Cadastrar</c:otherwise>
                                </c:choose>
                                Médico
                            </h1>
                        </div>

                        <div class="card-body">
                            <web2:carregaTag entidade="medico" var="medico" escopo="pagina" id="${crm}" />

                            <form method="post" action="MedicoJSP" class="needs-validation" novalidate>
                                <c:choose>
                                    <c:when test="${not empty op}">
                                        <input type="hidden" name="op" value="alterar"/>
                                        <input type="hidden" name="crm" value="${medico.crm}"/>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="mb-3">
                                            <label for="crm" class="form-label">CRM:</label>
                                            <input type="text" name="crm" id="crm" class="form-control" required/>
                                            <div class="invalid-feedback">Por favor, informe o CRM.</div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>

                                <div class="row g-3">
                                    <div class="col-md-12">
                                        <label for="nome" class="form-label">Nome Completo:</label>
                                        <input type="text" name="nome" id="nome" class="form-control" 
                                               value="${medico.nome}" required/>
                                        <div class="invalid-feedback">Por favor, informe o nome.</div>
                                    </div>

                                    <div class="col-md-6">
                                        <label for="especialidade" class="form-label">Especialidade:</label>
                                        <input type="text" name="especialidade" id="especialidade" class="form-control" 
                                               value="${medico.especialidade}" required/>
                                        <div class="invalid-feedback">Por favor, informe a especialidade.</div>
                                    </div>

                                    <div class="col-md-6">
                                        <label for="contato" class="form-label">Contato:</label>
                                        <input type="text" name="contato" id="contato" class="form-control" 
                                               value="${medico.contato}" required/>
                                        <div class="invalid-feedback">Por favor, informe o contato.</div>
                                    </div>

                                    <div class="col-md-12">
                                        <label for="senha" class="form-label">Senha:</label>
                                        <input type="password" name="senha" id="senha" class="form-control" 
                                               value="${medico.senha}" required/>
                                        <div class="invalid-feedback">Por favor, informe a senha.</div>
                                    </div>
                                </div>

                                <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                                    <c:if test="${empty modal}">
                                        <a href="${not empty op ? 'TelaInicialMedico.jsp' : 'LoginMedico.jsp'}" class="btn btn-secondary me-md-2">
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