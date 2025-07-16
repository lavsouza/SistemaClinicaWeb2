/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package web2.clinica.controllers;

import java.io.IOException;
import java.util.Optional;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import web2.clinica.model.negocio.Consulta;
import web2.clinica.model.negocio.Prontuario;
import web2.clinica.model.repositorios.ConsultaRepository;

/**
 *
 * @author lucas
 */
@WebServlet(name = "ProntuarioJSP", urlPatterns = {"/ProntuarioJSP"})
public class ProntuarioJSP extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int codigoConsulta = Integer.parseInt(request.getParameter("codigoConsulta"));
        String descricao = request.getParameter("descricao");
        String observacao = request.getParameter("observacoes");

        ConsultaRepository consultaRepo = new ConsultaRepository();
        Optional<Consulta> consultaOpt = consultaRepo.buscarPorCodigo(codigoConsulta);

        if (consultaOpt.isPresent()) {
            Consulta consulta = consultaOpt.get();

            if (consulta.getProntuario() == null) {
                Prontuario prontuario = new Prontuario();
                prontuario.setDescricao(descricao);
                prontuario.setObservacao(observacao);
                prontuario.setConsulta(consulta);
                consulta.setProntuario(prontuario);
            } else {
                // Alterar o prontuário existente
                consulta.getProntuario().setDescricao(descricao);
                consulta.getProntuario().setObservacao(observacao);
            }

            request.getSession().setAttribute("msg", "Prontuário salvo com sucesso.");
            response.sendRedirect("ConsultaJSP?codigo=" + codigoConsulta + "&op=visualizar");
        } else {
            request.getSession().setAttribute("msg", "Consulta não encontrada.");
            response.sendRedirect("TelaInicialMedico.jsp");
        }
    }
}
