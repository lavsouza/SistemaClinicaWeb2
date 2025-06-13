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
import web2.clinica.model.negocio.Paciente;
import web2.clinica.model.repositorios.PacienteRepository;

@WebServlet(name = "PacienteJSP", urlPatterns = {"/PacienteJSP"})
public class PacienteJSP extends HttpServlet {

    private PacienteRepository pacienteRepo = new PacienteRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cpf = request.getParameter("cpf");
        String operacao = request.getParameter("op");

        if (operacao != null && operacao.equals("deletar") && cpf != null) {
            pacienteRepo.deletar(cpf);
            request.getSession().setAttribute("msg", "Paciente excluído com sucesso!");
            response.sendRedirect("PacienteJSP");
            return;
        }

        if (cpf != null) {
            Optional<Paciente> p = pacienteRepo.buscarPorCpf(cpf);
            if (p.isPresent()) {
                request.setAttribute("paciente", p.get());
                request.setAttribute("op", "alterar");
                getServletContext()
                        .getRequestDispatcher("/CadastroAlteracaoPaciente.jsp")
                        .forward(request, response);
            } else {
                response.sendRedirect("PacienteJSP");
            }
            return;
        }

        List<Paciente> pacientes = pacienteRepo.listarTodos();
        request.getSession().setAttribute("pacientes", pacientes);
        response.sendRedirect("Pacientes.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String operacao = request.getParameter("op");
        String cpf = request.getParameter("cpf");
        String nome = request.getParameter("nome");
        String endereco = request.getParameter("endereco");
        String contato = request.getParameter("contato");
        String plano = request.getParameter("planoDeSaude");

        Paciente paciente = new Paciente(cpf, nome, endereco, contato, plano);

        if ("alterar".equals(operacao)) {
            pacienteRepo.atualizar(paciente);
            request.getSession().setAttribute("msg", "Paciente atualizado com sucesso!");
        } else {
            pacienteRepo.salvar(paciente);
            request.getSession().setAttribute("msg", "Paciente cadastrado com sucesso!");
        }

        response.sendRedirect("PacienteJSP");
    }

    @Override
    public String getServletInfo() {
        return "Servlet responsável por gerenciar CRUD de pacientes";
    }
}
