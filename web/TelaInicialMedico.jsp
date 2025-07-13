<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${empty sessionScope.medicoLogado}">
    <c:redirect url="LoginMedico.jsp" />
</c:if>

<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <title>Bem-vindo, Dr. ${sessionScope.medicoLogado.nome}</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
              crossorigin="anonymous">
    </head>
    <body class="bg-light">
        <div class="container mt-5">

            <c:if test="${not empty sessionScope.msg}">
                <div class="alert alert-info alert-dismissible fade show" role="alert">
                    ${sessionScope.msg}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="msg" scope="session" />
            </c:if>

            <div class="row mb-4">
                <div class="col-md-6">
                    <div class="card shadow-sm">
                        <div class="card-body">
                            <h3 class="card-title">Bem-vindo, Dr. ${sessionScope.medicoLogado.nome}</h3>
                            <p><strong>CRM:</strong> ${sessionScope.medicoLogado.crm}</p>
                            <p><strong>Especialidade:</strong> ${sessionScope.medicoLogado.especialidade}</p>
                            <p><strong>Contato:</strong> ${sessionScope.medicoLogado.contato}</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="card shadow-sm h-100">
                        <div class="card-body d-flex flex-column justify-content-center">
                            <h5 class="card-title">Ações Rápidas</h5>
                            <a href="AlterarSenha.jsp" class="btn btn-warning mb-2">Alterar Senha</a>
                            <a href="EditarPerfil.jsp" class="btn btn-info mb-2">Editar Perfil</a>
                            <a href="LogoutMedico" class="btn btn-danger">Sair</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row g-4">
                <div class="col-md-6">
                    <div class="card h-100 shadow-sm">
                        <div class="card-body">
                            <h5 class="card-title">Pacientes</h5>
                            <a href="CadastroAlteracaoPaciente.jsp" class="btn btn-primary mb-2">Cadastrar</a>
                            <a href="PacienteJSP" class="btn btn-outline-primary">Listar</a>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="card h-100 shadow-sm">
                        <div class="card-body">
                            <h5 class="card-title">Médicos</h5>
                            <a href="MedicoJSP" class="btn btn-outline-primary">Listar</a>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="card h-100 shadow-sm">
                        <div class="card-body">
                            <h5 class="card-title">Medicamentos</h5>
                            <a href="CadastroAlteracaoMedicamento.jsp" class="btn btn-primary mb-2">Cadastrar</a>
                            <a href="MedicamentoJSP" class="btn btn-outline-primary">Listar</a>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="card h-100 shadow-sm">
                        <div class="card-body">
                            <h5 class="card-title">Indicadores de Exame</h5>
                            <a href="CadastroAlteracaoIndicadorExame.jsp" class="btn btn-primary mb-2">Cadastrar</a>
                            <a href="IndicadorExameJSP" class="btn btn-outline-primary">Listar</a>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
    </body>
</html>
