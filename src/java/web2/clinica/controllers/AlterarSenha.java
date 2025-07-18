package web2.clinica.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import web2.clinica.model.negocio.Medico;
import web2.clinica.model.repositorios.MedicoRepository;

@WebServlet("/AlterarSenha")
public class AlterarSenha extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Medico medico = (Medico) session.getAttribute("medicoLogado");

        if (medico == null) {
            response.sendRedirect("LoginMedico.jsp");
            return;
        }

        String novaSenha = request.getParameter("novaSenha");

        if (novaSenha != null && !novaSenha.isEmpty()) {
            medico.setSenha(novaSenha);
            MedicoRepository.atualizar(medico);
            session.setAttribute("msg", "Senha atualizada com sucesso!");
        } else {
            session.setAttribute("msg", "A senha não pode ser vazia.");
        }

        response.sendRedirect("TelaInicialMedico.jsp");
    }
}
