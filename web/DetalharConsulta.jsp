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
                                <input type="hidden" name="codigo" value="${consulta.codigo}">

                                <div class="mb-3">
                                    <label for="observacao" class="form-label">Observações:</label>
                                    <textarea class="form-control" id="observacao" name="observacao" rows="3">${consulta.observacao}</textarea>
                                </div>

                                <div class="mb-3">
                                    <label for="prontuario" class="form-label">Prontuário:</label>
                                    <textarea class="form-control" id="prontuario" name="prontuario" rows="5"
                                              ${consulta.prontuario != null ? 'readonly' : ''}>${consulta.prontuario != null ? consulta.prontuario.conteudo : ''}</textarea>
                                </div>

                                <div class="mb-3">
                                    <label for="receituario" class="form-label">Receituário:</label>
                                    <textarea class="form-control" id="receituario" name="receituario" rows="3"></textarea>
                                    <small class="text-muted">Liste os medicamentos e posologias</small>
                                </div>

                                <div class="mb-3">
                                    <label for="exames" class="form-label">Exames Solicitados:</label>
                                    <textarea class="form-control" id="exames" name="exames" rows="2"></textarea>
                                    <small class="text-muted">Informe os exames necessários</small>
                                </div>

                                <div class="mb-3 col-md-4">
                                    <label for="dataRetorno" class="form-label">Agendar Retorno:</label>
                                    <input type="datetime-local" class="form-control" id="dataRetorno" name="dataRetorno">
                                </div>

                                <div class="d-flex justify-content-end gap-2">
                                    <button type="submit" class="btn btn-primary" name="op" value="salvar">
                                        <i class="fas fa-save me-1"></i> Salvar
                                    </button>
                                    <c:if test="${consulta.prontuario == null}">
                                        <button type="submit" class="btn btn-success" name="op" value="finalizar">
                                            <i class="fas fa-check-circle me-1"></i> Finalizar Consulta
                                        </button>
                                    </c:if>
                                </div>
                            </form>
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