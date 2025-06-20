<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        <input type="text" name="crm" class="form-control" required />
    </div>

    <div class="mb-3">
        <label for="senha">Senha:</label>
        <input type="password" name="senha" class="form-control" required />
    </div>

    <div>
        <button type="submit" class="btn btn-primary">Entrar</button>
        <a href="CadastroAlteracaoMedico.jsp" class="btn btn-secondary">Cadastre-se</a>
    </div>

</form>

<% if (session.getAttribute("erroLogin") != null) { %>
<div class="alert alert-danger mt-3">
    <%= session.getAttribute("erroLogin") %>
</div>
<% session.removeAttribute("erroLogin"); %>
<% } %>
</body>
</html>
