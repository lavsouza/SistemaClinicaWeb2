<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="web2" uri="web2.clinica.customTags" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Gerenciar Indicadores de Exame</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    </head>
    <body class="container mt-4">

        <web2:carregaTag entidade="indicadorexame" var="indicadores" escopo="pagina"/>

        
        <h2 class="mb-4">Lista de Indicadores de Exame</h2>

        <c:if test="${not empty sessionScope.msg}">
            <div class="alert alert-info alert-dismissible fade show" role="alert">
                ${sessionScope.msg}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="msg" scope="session" />
        </c:if>

        <button class="btn btn-success mb-3" data-bs-toggle="modal" data-bs-target="#modalCadastro">
            Novo Indicador
        </button>
        <a class="btn btn-secondary mb-3" href="TelaInicialMedico.jsp">Voltar</a>

        <table class="table table-striped table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>Código</th>
                    <th>Indicador</th>
                    <th>Descrição</th>
                    <th>Valor Mínimo</th>
                    <th>Valor Máximo</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty indicadores}">
                        <c:forEach var="i" items="${indicadores}">
                            <tr>
                                <td>${i.codigo}</td>
                                <td>${i.indicador}</td>
                                <td>${i.descricao}</td>
                                <td>${i.minValorReferencia}</td>
                                <td>${i.maxValorReferencia}</td>
                                <td>
                                    <a href="IndicadorExameJSP?codigo=${i.codigo}" class="btn btn-warning btn-sm">Alterar</a>
                                    <a href="IndicadorExameJSP?codigo=${i.codigo}&op=deletar" class="btn btn-danger btn-sm">Deletar</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="6" class="text-center">Nenhum indicador encontrado.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>

        <div class="modal fade" id="modalCadastro" data-bs-backdrop="static" data-bs-keyboard="false"
             tabindex="-1" aria-labelledby="modalCadastroLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalCadastroLabel">Cadastrar Indicador</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <c:set var="modal" value="true" scope="request"/>
                        <%@ include file="CadastroAlteracaoIndicadorExame.jsp" %>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
    </body>
</html>
