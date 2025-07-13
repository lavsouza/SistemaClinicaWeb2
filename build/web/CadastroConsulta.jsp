<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="web2" uri="web2.clinica.customTags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Cadastrar Consulta</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    </head>
    <body class="container mt-5">

        <web2:carregaTag entidade="medico" var="medicos" escopo="pagina" />
        <web2:carregaTag entidade="paciente" var="pacientes" escopo="pagina" />

        <h2 class="mb-4">
            <c:choose>
                <c:when test="${op eq 'alterar'}">Alterar Consulta</c:when>
                <c:otherwise>Cadastrar Consulta</c:otherwise>
            </c:choose>
        </h2>

        <c:if test="${not empty sessionScope.msg}">
            <div class="alert alert-info alert-dismissible fade show" role="alert">
                ${sessionScope.msg}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="msg" scope="session"/>
        </c:if>

        <form method="post" action="ConsultaJSP">
            <c:if test="${op eq 'alterar'}">
                <input type="hidden" name="op" value="alterar"/>
                <input type="hidden" name="codigo" value="${consulta.codigo}"/>
            </c:if>

            <div class="mb-3">
                <label for="codigo" class="form-label">Código da Consulta:</label>
                <input type="number" class="form-control" id="codigo" name="codigo"
                       <c:if test="${op eq 'alterar'}">readonly</c:if>
                       value="${consulta.codigo}"/>
            </div>

            <div class="mb-3">
                <label for="crm" class="form-label">Médico:</label>
                <select class="form-control" name="crm" id="crm" required>
                    <c:forEach var="m" items="${medicos}">
                        <option value="${m.crm}" ${consulta.medico.crm == m.crm ? 'selected' : ''}>
                            Dr. ${m.nome} - ${m.especialidade}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="mb-3">
                <label for="cpf" class="form-label">Paciente:</label>
                <select class="form-control" name="cpf" id="cpf" required>
                    <c:forEach var="p" items="${pacientes}">
                        <option value="${p.cpf}" ${consulta.paciente.cpf == p.cpf ? 'selected' : ''}>
                            ${p.nome} - ${p.planoDeSaude}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="mb-3">
                <label for="data" class="form-label">Data:</label>
                <input type="date" name="data" id="data" class="form-control" required
                       value="${data}"/>
            </div>

            <div class="mb-3">
                <label for="hora" class="form-label">Hora:</label>
                <input type="time" name="hora" id="hora" class="form-control" required
                       value="${hora}"/>
            </div>

            <button type="submit" class="btn btn-success">
                <c:choose>
                    <c:when test="${op eq 'alterar'}">Atualizar Consulta</c:when>
                    <c:otherwise>Cadastrar Consulta</c:otherwise>
                </c:choose>
            </button>
            <a href="TelaInicial.html" class="btn btn-secondary">Voltar</a>
            <a href="Consultas.jsp" class="btn btn-secondary">Lista Consultas</a>

        </form>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
