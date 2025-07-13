<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="web2" uri="web2.clinica.customTags" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Gerenciar Consultas</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    </head>
    <body class="container mt-4">
        
        <web2:carregaTag entidade="consulta" var="consultas" escopo="pagina" />

        <h2 class="mb-4">Lista de Consultas</h2>

        <c:if test="${not empty sessionScope.msg}">
            <div class="alert alert-info alert-dismissible fade show" role="alert">
                ${sessionScope.msg}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="msg" scope="session" />
        </c:if>

        <a class="btn btn-secondary mb-3" href="CadastroAlteracaoConsulta.jsp">Voltar</a>

        <table class="table table-striped table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>Código</th>
                    <th>Data e Hora</th>
                    <th>Médico</th>
                    <th>Paciente</th>
                    <th>Prontuário</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty consultas}">
                        <c:forEach var="c" items="${consultas}">
                            <tr>
                                <td>${c.codigo}</td>
                                <td>${c.dataHora}</td>
                                <td>Dr. ${c.medico.nome} (${c.medico.crm})</td>
                                <td>${c.paciente.nome} (${c.paciente.cpf})</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${c.prontuario != null}">Sim</c:when>
                                        <c:otherwise>Não</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="ConsultaJSP?codigo=${c.codigo}" class="btn btn-warning btn-sm">Alterar</a>
                                    <a href="ConsultaJSP?codigo=${c.codigo}&op=deletar"
                                       class="btn btn-danger btn-sm"
                                       onclick="return confirm('Tem certeza que deseja excluir esta consulta?');">
                                        Deletar
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="6" class="text-center">Nenhuma consulta encontrada.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>

    </body>
</html>
