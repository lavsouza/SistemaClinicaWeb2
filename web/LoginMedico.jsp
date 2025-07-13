<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Login Médico</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    </head>
    <body class="container mt-5">

        <h2>Login do Médico</h2>

        <form method="post" action="LoginMedico">
            <div class="mb-3">
                <label for="crm">CRM:</label>
                <input type="text" name="crm" id="crm" class="form-control" required />
            </div>

            <div class="mb-3">
                <label for="senha">Senha:</label>
                <input type="password" name="senha" id="senha" class="form-control" required />
            </div>

            <div>
                <button type="submit" class="btn btn-primary">Entrar</button>
                <a href="CadastroAlteracaoMedico.jsp" class="btn btn-secondary">Cadastre-se</a>
            </div>

            <a href="CarregaTagJSP.jsp" class="btn btn-secondary mt-2">Tags</a>
        </form>

        <c:if test="${not empty sessionScope.erroLogin}">
            <div class="alert alert-danger mt-3">
                ${sessionScope.erroLogin}
            </div>
            <c:remove var="erroLogin" scope="session"/>
        </c:if>

    </body>
</html>
