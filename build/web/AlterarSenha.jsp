<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Alterar Senha</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    </head>
    <body class="container mt-5">

    <c:if test="${empty sessionScope.medicoLogado}">
        <c:redirect url="login.jsp"/>
    </c:if>

    <h2>Alterar Senha</h2>

    <form method="post" action="AlterarSenha">
        <div class="mb-3">
            <label>Nova Senha:</label>
            <input type="password" name="novaSenha" class="form-control" required />
        </div>
        <button type="submit" class="btn btn-primary">Salvar</button>
        <a href="TelaInicialMedico.jsp" class="btn btn-secondary">Cancelar</a>
    </form>

</body>
</html>
