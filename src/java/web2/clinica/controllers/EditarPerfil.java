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

@WebServlet("/EditarPerfil")
public class EditarPerfil extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Medico medico = (Medico) session.getAttribute("medicoLogado");

        if (medico == null) {
            response.sendRedirect("LoginMedico.jsp");
            return;
        }

        String nome = request.getParameter("nome");
        String especialidade = request.getParameter("especialidade");
        String contato = request.getParameter("contato");

        medico.setNome(nome);
        medico.setEspecialidade(especialidade);
        medico.setContato(contato);

        MedicoRepository.atualizar(medico);

        session.setAttribute("msg", "Perfil atualizado com sucesso!");
        response.sendRedirect("TelaInicialMedico.jsp");
    }
}
