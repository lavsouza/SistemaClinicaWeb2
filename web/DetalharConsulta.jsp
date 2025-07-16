<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${empty sessionScope.medicoLogado}">
    <c:redirect url="LoginMedico.jsp" />
</c:if>

<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <title>Detalhes da Consulta - ${consulta.paciente.nome}</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
              crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>
    <body class="bg-light">
        <div class="container mt-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="text-primary">
                    <i class="fas fa-calendar-check me-2"></i>Detalhes da Consulta
                </h2>
                <a href="TelaInicialMedico.jsp" class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left me-1"></i> Voltar
                </a>
            </div>

            <c:if test="${not empty sessionScope.msg}">
                <div class="alert alert-info alert-dismissible fade show" role="alert">
                    ${sessionScope.msg}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="msg" scope="session" />
            </c:if>

            <div class="row mb-4">
                <div class="col-md-6">
                    <div class="card shadow-sm consult-info-card h-100">
                        <div class="card-header bg-primary text-white">
                            <i class="fas fa-info-circle me-2"></i>Informações da Consulta
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <p><strong>Código:</strong> ${consulta.codigo}</p>
                                    <p><strong>Data/Hora:</strong> ${consulta.dataHora}</p>
                                </div>
                                <div class="col-md-6">
                                    <p><strong>Retorno:</strong> 
                                        <c:choose>
                                            <c:when test="${not empty consulta.dataHoraVolta}">
                                                ${consulta.dataHoraVolta}
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">Não agendado</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                    <p><strong>Status:</strong> 
                                        <span class="badge ${consulta.prontuario != null ? 'bg-success' : 'bg-warning text-dark'}">
                                            ${consulta.prontuario != null ? 'Realizada' : 'Pendente'}
                                        </span>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="card shadow-sm patient-info-card h-100">
                        <div class="card-header bg-success text-white">
                            <i class="fas fa-user-injured me-2"></i>Dados do Paciente
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <p><strong>Nome:</strong> ${consulta.paciente.nome}</p>
                                    <p><strong>CPF:</strong> ${consulta.paciente.cpf}</p>
                                    </p>
                                </div>
                                <div class="col-md-6">
                                    <p><strong>Contato:</strong> ${consulta.paciente.contato}</p>
                                    <p><strong>Endereço:</strong> ${consulta.paciente.endereco}</p>
                                    <p><strong>Plano De Saúde</strong> ${consulta.paciente.planoDeSaude}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col">
                    <div class="card shadow-sm card-medical-actions">
                        <div class="card-header bg-info text-white">
                            <i class="fas fa-notes-medical me-2"></i>Registro Médico
                        </div>
                        <div class="card-body">
                            <form action="ConsultaJSP" method="post">
                                <div class="mb-3 col-md-4">
                                    <label for="dataRetorno" class="form-label">Agendar Retorno:</label>
                                    <input type="datetime-local" class="form-control" id="dataRetorno" name="dataRetorno">
                                </div>

                                <div class="mb-3 col-md-4">
                                    <label class="form-label d-block">Prontuário</label>
                                    <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#modalProntuario">
                                        Vizualizar Prontuário
                                    </button>
                                </div>

                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modalProntuario" tabindex="-1" aria-labelledby="modalProntuarioLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <form method="post" action="ProntuarioJSP">
                        <div class="modal-header">
                            <h5 class="modal-title" id="modalProntuarioLabel">Prontuário</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Fechar"></button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" name="op" value="salvar"/>
                            <input type="hidden" name="codigoConsulta" value="${consulta.codigo}"/>

                            <c:set var="observacoesConteudo" value="" />
                            <c:set var="descricaoConteudo" value="" />

                            <c:if test="${not empty consulta.prontuario}">
                                <c:set var="observacoesConteudo" value="${consulta.prontuario.observacao}" />
                                <c:set var="descricaoConteudo" value="${consulta.prontuario.descricao}" />
                            </c:if>

                            <div class="mb-3">
                                <label for="observacoes" class="form-label">Observações</label>
                                <textarea class="form-control" id="observacoes" name="observacoes" rows="3" required>${observacoesConteudo}</textarea>
                            </div>

                            <div class="mb-3">
                                <label for="descricao" class="form-label">Descrição</label>
                                <textarea class="form-control" id="descricao" name="descricao" rows="3" required>${descricaoConteudo}</textarea>                            
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary">Salvar</button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
    </body>
</html>