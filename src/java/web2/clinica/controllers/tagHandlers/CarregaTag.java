/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package web2.clinica.controllers.tagHandlers;

import javax.servlet.jsp.tagext.SimpleTagSupport;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.JspException;
import java.io.IOException;
import web2.clinica.model.repositorios.*;

public class CarregaTag extends SimpleTagSupport {

    private String entidade;
    private String var;
    private String escopo;
    private String id;

    public void setEntidade(String entidade) {
        this.entidade = entidade;
    }

    public void setVar(String var) {
        this.var = var;
    }

    public void setEscopo(String escopo) {
        this.escopo = escopo;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Override
    public void doTag() throws JspException, IOException {
        Object resultado = null;

        switch (entidade.toLowerCase()) {
            case "medico":
                MedicoRepository medicoRepo = new MedicoRepository();
                if (id != null) {
                    resultado = medicoRepo.buscarPorCrm(id).orElse(null);
                } else {
                    resultado = medicoRepo.listarTodos();
                }
                break;

            case "paciente":
                PacienteRepository pacienteRepo = new PacienteRepository();
                if (id != null) {
                    resultado = pacienteRepo.buscarPorCpf(id).orElse(null);
                } else {
                    resultado = pacienteRepo.listarTodos();
                }
                break;

            case "medicamento":
                MedicamentoRepository medicamentoRepo = new MedicamentoRepository();
                if (id != null) {
                    try {
                        resultado = medicamentoRepo.buscarPorCodigo(Integer.parseInt(id)).orElse(null);
                    } catch (NumberFormatException e) {
                        resultado = null;
                    }
                } else {
                    resultado = medicamentoRepo.listarTodos();
                }
                break;

            case "indicadorexame":
                IndicadorExameRepository indicadorRepo = new IndicadorExameRepository();
                if (id != null) {
                    try {
                        resultado = indicadorRepo.buscarPorCodigo(Integer.parseInt(id)).orElse(null);
                    } catch (NumberFormatException e) {
                        resultado = null;
                    }
                } else {
                    resultado = indicadorRepo.listarTodos();
                }
                break;
            case "consulta":
                ConsultaRepository consultaRepo = new ConsultaRepository();
                if (id != null) {
                    try {
                        resultado = consultaRepo.buscarPorCodigo(Integer.parseInt(id)).orElse(null);
                    } catch (NumberFormatException e) {
                        resultado = null;
                    }
                } else {
                    resultado = consultaRepo.listarTodas();
                }
                break;
        }

        int scope = PageContext.PAGE_SCOPE;
        switch (escopo.toLowerCase()) {
            case "pagina": scope = PageContext.PAGE_SCOPE; break;
            case "requisicao": scope = PageContext.REQUEST_SCOPE; break;
            case "sessao": scope = PageContext.SESSION_SCOPE; break;
            case "aplicacao": scope = PageContext.APPLICATION_SCOPE; break;
        }
        
        getJspContext().setAttribute(var, resultado, scope);
    }
}
