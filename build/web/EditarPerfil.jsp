<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- Verificação de login via JSTL --%>
<c:if test="${empty sessionScope.medicoLogado}">
    <c:redirect url="login.jsp"/>
</c:if>

<!DOCTYPE html>
<html>
    <head>
        <title>Editar Perfil</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    </head>
    <body class="container mt-5">

        <h2>Editar Perfil</h2>

        <form method="post" action="EditarPerfil">
            <div class="mb-3">
                <label>Nome:</label>
                <input type="text" name="nome" class="form-control" value="${sessionScope.medicoLogado.nome}" required />
            </div>

            <div class="mb-3">
                <label>Especialidade:</label>
                <input type="text" name="especialidade" class="form-control" value="${sessionScope.medicoLogado.especialidade}" required />
            </div>

            <div class="mb-3">
                <label>Contato:</label>
                <input type="text" name="contato" class="form-control" value="${sessionScope.medicoLogado.contato}" required />
            </div>

            <button type="submit" class="btn btn-success">Salvar</button>
            <a href="TelaInicialMedico.jsp" class="btn btn-secondary">Cancelar</a>
        </form>

    </body>
</html>
