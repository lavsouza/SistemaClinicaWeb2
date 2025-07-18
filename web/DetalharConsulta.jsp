<%@page import="web2.clinica.model.negocio.ItemExame"%>
<%@page import="web2.clinica.model.negocio.Consulta"%>
<%@page import="java.util.ArrayList"%>
<%@page import="web2.clinica.model.negocio.ItemReceituario"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="web2" uri="web2.clinica.customTags" %>

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
        <web2:carregaTag entidade="medicamento" var="medicamentos" escopo="pagina" />
        <web2:carregaTag entidade="indicadorexame" var="todosIndicadores" escopo="pagina" />

        <div class="container mt-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="text-primary">
                    <i class="fas fa-calendar-check me-2"></i>Detalhes da Consulta
                </h2>
                <a href="LoginMedico" class="btn btn-outline-secondary">
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
                            <form action="ConsultaJSP?op=dataAlt" method="post">
                                <input type="hidden" name="codigo" value="${consulta.codigo}" />

                                <c:if test="${not empty consulta.prontuario}">
                                    <div class="mb-3 col-md-4">
                                        <label for="dataRetorno" class="form-label">Agendar Retorno:</label>
                                        <input type="datetime-local" class="form-control" id="dataRetorno" name="dataRetorno" />
                                    </div>
                                </c:if>

                                <div class="mb-3 col-md-4">
                                    <label class="form-label d-block">Prontuário</label>
                                    <button type="button"
                                            class="btn ${consulta.prontuario != null ? 'btn-success' : 'btn-secondary'}"
                                            data-bs-toggle="modal"
                                            data-bs-target="#modalProntuario">
                                        ${consulta.prontuario != null ? 'Visualizar Prontuário' : 'Cadastrar Prontuário'}
                                    </button>
                                </div>

                                <div class="mb-3 col-md-4">
                                    <label class="form-label d-block">Receituário</label>
                                    <button type="button"
                                            class="btn ${consulta.receituario != null ? 'btn-success' : 'btn-secondary'}"
                                            data-bs-toggle="modal"
                                            data-bs-target="#modalReceituario">
                                        ${consulta.receituario != null ? 'Visualizar Receituário' : 'Cadastrar Receituário'}
                                    </button>
                                </div>

                                <div class="mb-3 col-md-4">
                                    <label class="form-label d-block">Exames</label>
                                    <button type="button"
                                            class="btn ${consulta.exame != null ? 'btn-success' : 'btn-secondary'}"
                                            data-bs-toggle="modal"
                                            data-bs-target="#modalExame">
                                        ${consulta.exame != null ? 'Visualizar Exames' : 'Cadastrar Exame'}
                                    </button>
                                </div>
                                    
                                <c:if test="${not empty consulta.prontuario}">
                                    <div class="modal-footer">
                                        <button type="submit" class="btn btn-primary">Salvar</button>
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                    </div>
                                </c:if>

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

        <%
            List<ItemReceituario> itensR = new ArrayList<>();
            Consulta consulta = (Consulta) request.getAttribute("consulta");
            if (consulta != null && consulta.getReceituario() != null && consulta.getReceituario().getItensReceituario() != null) {
                itensR = consulta.getReceituario().getItensReceituario();
            }
            request.setAttribute("itensReceituario", itensR);
        %>
        <div class="modal fade" id="modalReceituario" tabindex="-1" aria-labelledby="modalReceituarioLabel" aria-hidden="true">
            <div class="modal-dialog modal-xl">
                <div class="modal-content">
                    <form method="post" action="ReceituarioJSP">
                        <div class="modal-header">
                            <h5 class="modal-title">Receituário</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" name="codigoConsulta" value="${consulta.codigo}" />

                            <div class="mb-3">
                                <label for="observacao" class="form-label">Observações gerais</label>
                                <textarea class="form-control" id="observacao" name="observacao" rows="3" required>${consulta.receituario.observacao}</textarea>

                            </div>
                            <h5>Itens do Receituário</h5>
                            <c:set var="fim" value="${medicamentosCount - 1}" />
                            <c:forEach var="i" begin="0" end="${fim}">
                                <c:set var="item" value="${itensReceituario[i]}" />
                                <div class="row border rounded p-3 mb-3">
                                    <div class="col-md-3">
                                        <label>Medicamento</label>
                                        <select class="form-select" name="medicamentoCodigo">
                                            <option value="">Selecione</option>
                                            <c:forEach var="m" items="${medicamentos}">
                                                <option value="${m.codigo}"
                                                        <c:if test="${not empty item and item.medicamento.codigo == m.codigo}">selected</c:if>>
                                                    ${m.nome} - ${m.dosagem}${m.tipoDosagem}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="col-md-2">
                                        <label>Dosagem</label>
                                        <input type="number" class="form-control" name="dosagem"
                                               value="${not empty item ? item.dosagem : ''}" />
                                    </div>

                                    <div class="col-md-2">
                                        <label>Intervalo (h)</label>
                                        <input type="number" class="form-control" name="intervalo"
                                               value="${not empty item ? item.intervalorEntreDoses : ''}" />
                                    </div>

                                    <div class="col-md-5">
                                        <label>Observação</label>
                                        <input type="text" class="form-control" name="obsItem"
                                               value="${not empty item ? item.observacao : ''}" />
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary">Salvar</button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <%
            List<ItemExame> itensExame = new ArrayList<>();
            if (consulta != null && consulta.getExame() != null && consulta.getExame().getItens() != null) {
                itensExame = consulta.getExame().getItens();
            }
            request.setAttribute("itensExame", itensExame);
        %>

        <div class="modal fade" id="modalExame" tabindex="-1" aria-labelledby="modalExameLabel" aria-hidden="true">
            <div class="modal-dialog modal-xl">
                <div class="modal-content">
                    <form method="post" action="ExameJSP">
                        <div class="modal-header">
                            <h5 class="modal-title" id="modalExameLabel">Exame</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" name="codigoConsulta" value="${consulta.codigo}" />

                            <div class="mb-3">
                                <label for="observacao" class="form-label">Observações gerais</label>
                                <textarea class="form-control" id="observacao" name="observacao" rows="3" required>${consulta.exame.observacao}</textarea>
                            </div>

                            <h5>Itens do Exame</h5>
                            <c:forEach var="i" begin="0" end="${todosIndicadoresCount - 1}">
                                <c:set var="itemSelecionado" value="${itensExame[i]}" />

                                <div class="row border rounded p-3 mb-3">
                                    <div class="col-md-4">
                                        <label>Indicador do Exame</label>
                                        <select class="form-select" name="codigoIndicador">
                                            <option value="">Selecione</option>
                                            <c:forEach var="indicador" items="${todosIndicadores}">
                                                <option value="${indicador.codigo}"
                                                        <c:if test="${not empty itemSelecionado and itemSelecionado.indicador.codigo == indicador.codigo}">
                                                            selected
                                                        </c:if>>
                                                    ${indicador.indicador}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="col-md-4">
                                        <label>Valor do Indicador</label>
                                        <input type="text" class="form-control" name="valorIndicador" value="${not empty itemSelecionado ? itemSelecionado.valorIndicador : ''}" />
                                    </div>

                                    <div class="col-md-4">
                                        <label>Observação</label>
                                        <input type="text" class="form-control" name="observacaoItem" value="${not empty itemSelecionado ? itemSelecionado.observacao : ''}" />
                                    </div>
                                </div>
                            </c:forEach>

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