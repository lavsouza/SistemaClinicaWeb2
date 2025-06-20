/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package web2.clinica.controllers;

import web2.clinica.model.negocio.Medico;
import web2.clinica.model.repositorios.MedicoRepository;

import java.io.IOException;
import java.util.Optional;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author lucas
 */
@WebServlet(name = "LoginMedico", urlPatterns = {"/LoginMedico"})
public class LoginMedico extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String crm = request.getParameter("crm");
        String senha = request.getParameter("senha");

        Optional<Medico> medico = MedicoRepository.buscarPorCrm(crm);

        if (medico.isPresent() && medico.get().getSenha().equals(senha)) {
            request.getSession().setAttribute("medicoLogado", medico.get());
            response.sendRedirect("TelaInicialMedico.jsp");
        } else {
            request.getSession().setAttribute("erroLogin", "CRM ou senha inválidos.");
            response.sendRedirect("LoginMedico.jsp");
        }
    }

}
