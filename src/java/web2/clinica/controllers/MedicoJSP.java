/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package web2.clinica.controllers;

import java.io.IOException;
import java.util.List;
import java.util.Optional;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import web2.clinica.model.negocio.Medico;
import web2.clinica.model.repositorios.MedicoRepository;

/**
 *
 * @author lucas
 */
@WebServlet(name = "MedicoJSP", urlPatterns = {"/MedicoJSP"})
public class MedicoJSP extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String crm = request.getParameter("crm");
        String operacao = request.getParameter("op");

        if (operacao != null && operacao.equals("deletar")) {
            Optional<Medico> m = MedicoRepository.buscarPorCrm(crm);
            MedicoRepository.deletar(crm);
            request.getSession().setAttribute("msg", "Medico excluído com sucesso!");
            response.sendRedirect("MedicoJSP");
            return;
        }

        if (crm != null) {
            Optional<Medico> m = MedicoRepository.buscarPorCrm(crm);
            if (m.isPresent()) {
                request.setAttribute("medico", m.get());
                request.setAttribute("op", "alterar");
                getServletContext()
                        .getRequestDispatcher("/CadastroAlteracaoMedico.jsp")
                        .forward(request, response);
            } else {
                response.sendRedirect("MedicoJSP");
            }
            return;
        }

        List<Medico> medicos = MedicoRepository.listarTodos();
        request.getSession().setAttribute("medicos", medicos);
        response.sendRedirect("Medicos.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String operation = request.getParameter("op");
        String crm = request.getParameter("crm");
        String nome = request.getParameter("nome");
        String especialidade = request.getParameter("especialidade");
        String senha = request.getParameter("senha");
        String contato = request.getParameter("contato");

        Medico m = new Medico(crm, nome, especialidade, contato, senha);
        m.setNome(nome);
        m.setSenha(senha);
        m.setCrm(crm);
        m.setEspecialidade(especialidade);
        m.setContato(contato);

        if (operation != null && operation.equals("alterar")) {
            MedicoRepository.atualizar(m);
            request.getSession().setAttribute("msg", "Médico atualizado com sucesso!");
            response.sendRedirect("MedicoJSP");
            return;
        } else {
            MedicoRepository.salvar(m);
            HttpSession session = request.getSession();
            session.setAttribute("msg", "Médico cadastrado com sucesso!");
            response.sendRedirect("MedicoJSP");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet responsável por gerenciar CRUD de médicos";
    }

}
