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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    </head>
    <body class="container mt-5">
         <web2:carregaTag entidade="medico" var="medico" escopo="pagina" id="${crm}" />

        <h1 class="mb-4">
            <c:choose>
                <c:when test="${not empty op}">Alterar</c:when>
                <c:otherwise>Cadastrar</c:otherwise>
            </c:choose>
            Médico
        </h1>

        <form method="post" action="MedicoJSP">

            <c:choose>
                <c:when test="${not empty op}">
                    <input type="hidden" name="op" value="alterar"/>
                    <input type="hidden" name="crm" value="${medico.crm}"/>
                </c:when>
                <c:otherwise>
                    <div class="mb-3">
                        <label for="crm" class="form-label">CRM:</label>
                        <input type="text" name="crm" id="crm" class="form-control" required/>
                    </div>
                </c:otherwise>
            </c:choose>

            <div class="mb-3">
                <label for="nome" class="form-label">Nome:</label>
                <input type="text" name="nome" id="nome" class="form-control" value="${medico.nome}" required/>
            </div>

            <div class="mb-3">
                <label for="especialidade" class="form-label">Especialidade:</label>
                <input type="text" name="especialidade" id="especialidade" class="form-control" value="${medico.especialidade}" required/>
            </div>

            <div class="mb-3">
                <label for="contato" class="form-label">Contato:</label>
                <input type="text" name="contato" id="contato" class="form-control" value="${medico.contato}" required/>
            </div>

            <div class="mb-3">
                <label for="senha" class="form-label">Senha:</label>
                <input type="password" name="senha" id="senha" class="form-control" value="${medico.senha}" required/>
            </div>

            <div>
                <button class="btn btn-primary" type="submit">
                    <c:choose>
                        <c:when test="${not empty op}">Alterar</c:when>
                        <c:otherwise>Cadastrar</c:otherwise>
                    </c:choose>
                </button>

                <c:choose>
                    <c:when test="${not modal}">
                        <a href="${not empty op ? 'TelaInicialMedico.jsp' : 'LoginMedico.jsp'}" class="btn btn-secondary">Voltar</a>
                    </c:when>
                </c:choose>
            </div>

        </form>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
    </body>
</html>
