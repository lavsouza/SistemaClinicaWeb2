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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    </head>
    <body class="container mt-5">

        <h1 class="mb-4">
            <c:choose>
                <c:when test="${not empty op}">Alterar</c:when>
                <c:otherwise>Cadastrar</c:otherwise>
            </c:choose>
            Paciente
        </h1>

        <%-- Carregamento da tag, se necessário --%>
    <c:if test="${not empty param.cpf}">
        <web2:carregaTag entidade="paciente" var="paciente" escopo="requisicao" id="${param.cpf}" />
        <c:set var="op" value="alterar" />
    </c:if>

    <form method="post" action="PacienteJSP">

        <c:choose>
            <c:when test="${op == 'alterar'}">
                <input type="hidden" name="op" value="alterar"/>
                <input type="hidden" name="cpf" value="${paciente.cpf}"/>
            </c:when>
            <c:otherwise>
                <div class="mb-3">
                    <label for="cpf" class="form-label">CPF:</label>
                    <input type="text" name="cpf" id="cpf" class="form-control" required/>
                </div>
            </c:otherwise>
        </c:choose>

        <div class="mb-3">
            <label for="nome" class="form-label">Nome:</label>
            <input type="text" name="nome" id="nome" class="form-control" value="${paciente.nome}" required/>
        </div>

        <div class="mb-3">
            <label for="endereco" class="form-label">Endereço:</label>
            <input type="text" name="endereco" id="endereco" class="form-control" value="${paciente.endereco}" required/>
        </div>

        <div class="mb-3">
            <label for="contato" class="form-label">Contato:</label>
            <input type="text" name="contato" id="contato" class="form-control" value="${paciente.contato}" required/>
        </div>

        <div class="mb-3">
            <label for="planoDeSaude" class="form-label">Plano de Saúde:</label>
            <input type="text" name="planoDeSaude" id="planoDeSaude" class="form-control" value="${paciente.planoDeSaude}" required/>
        </div>

        <div class="mb-3">
            <button class="btn btn-primary" type="submit">
                <c:choose>
                    <c:when test="${op == 'alterar'}">Alterar</c:when>
                    <c:otherwise>Cadastrar</c:otherwise>
                </c:choose>
            </button>

            <c:choose>
                <c:when test="${not modal}">
                    <a href="${op == 'alterar' ? 'Pacientes.jsp' : 'TelaInicialMedico.jsp'}" class="btn btn-secondary">Voltar</a>
                </c:when>
            </c:choose>
        </div>

    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
    crossorigin="anonymous"></script>
</body>
</html>
