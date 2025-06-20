<%@ page import="web2.clinica.model.negocio.Medico" %>
<%@ page session="true" %>
<%
    Medico medico = (Medico) session.getAttribute("medicoLogado");
    if (medico == null) {
        response.sendRedirect("LoginMedico.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Bem-vindo, Dr. <%= medico.getNome() %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body class="container mt-5">

    <h2>Bem-vindo, Dr. <%= medico.getNome() %></h2>
    <p>CRM: <%= medico.getCrm() %></p>
    <p>Especialidade: <%= medico.getEspecialidade() %></p>
    <p>Contato: <%= medico.getContato() %></p>

    <a href="AlterarSenha.jsp" class="btn btn-warning">Alterar Senha</a>
    <a href="EditarPerfil.jsp" class="btn btn-info">Editar Perfil</a>
    <a href="LogoutMedico" class="btn btn-danger">Sair</a>

    <div class="row g-4">

        <div class="col-md-6">
            <div class="card h-100">
                <div class="card-body">
                    <h5 class="card-title">Pacientes</h5>
                    <a href="CadastroAlteracaoPaciente.jsp" class="btn btn-primary">Cadastrar</a>
                    <a href="Pacientes.jsp" class="btn btn-outline-primary">Listar</a>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card h-100">
                <div class="card-body">
                    <h5 class="card-title">Médicos</h5>
                    <a href="Medicos.jsp" class="btn btn-outline-primary">Listar</a>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card h-100">
                <div class="card-body">
                    <h5 class="card-title">Medicamentos</h5>
                    <a href="CadastroAlteracaoMedicamento.jsp" class="btn btn-primary">Cadastrar</a>
                    <a href="Medicamentos.jsp" class="btn btn-outline-primary">Listar</a>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card h-100">
                <div class="card-body">
                    <h5 class="card-title">Indicadores de Exame</h5>
                    <a href="CadastroAlteracaoIndicadorExame.jsp" class="btn btn-primary">Cadastrar</a>
                    <a href="IndicadoresExame.jsp" class="btn btn-outline-primary">Listar</a>
                </div>
            </div>
        </div>

    </div>

</body>
</html>
