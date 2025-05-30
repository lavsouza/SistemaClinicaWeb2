/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package web2.clinica.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Optional;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import web2.clinica.model.negocio.Paciente;
import web2.clinica.model.repositorios.PacienteRepository;

/**
 *
 * @author lucas
 */
@WebServlet("/paciente")
public class CadastroPaciente extends HttpServlet {

    private final PacienteRepository repository = new PacienteRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "new":
                response.sendRedirect("CadastroPaciente.html");
                break;
            case "edit":
                String cpf = request.getParameter("cpf");
                Optional<Paciente> paciente = repository.buscarPorCpf(cpf);

                if (paciente.isPresent()) {
                    try {
                        showForm(response, paciente.get());
                    } catch (IOException e) {
                        throw new RuntimeException(e);
                    }
                } else {
                    try {
                        response.sendRedirect("paciente");
                    } catch (IOException e) {
                        throw new RuntimeException(e);
                    }
                }
                break;
            case "delete":
                repository.deletar(request.getParameter("cpf"));
                response.sendRedirect("paciente");
                break;
            default:
                showList(response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cpf = request.getParameter("cpf");
        String nome = request.getParameter("nome");
        String endereco = request.getParameter("endereco");
        String contato = request.getParameter("contato");
        String plano = request.getParameter("planoDeSaude");

        Paciente paciente = new Paciente(cpf, nome, endereco, contato, plano);

        if (repository.buscarPorCpf(cpf).isPresent()) {
            repository.atualizar(paciente);
        } else {
            repository.salvar(paciente);
        }

        response.sendRedirect("paciente");
    }

    private void showList(HttpServletResponse response) throws IOException {
        List<Paciente> pacientes = repository.listarTodos();

        PrintWriter out = response.getWriter();
        response.setContentType("text/html");

        out.println("<html><body>");
        out.println("<h1>Lista de Pacientes</h1>");
        out.println("<a href='paciente?action=new'>Novo Paciente</a><br><br>");
        out.println("<table border='1'>");
        out.println("<tr><th>CPF</th><th>Nome</th><th>Endereço</th><th>Contato</th><th>Plano de Saúde</th><th>Ações</th></tr>");

        for (Paciente p : pacientes) {
            out.printf(
                    "<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td>"
                    + "<td><a href='paciente?action=edit&cpf=%s'>Editar</a> | "
                    + "<a href='paciente?action=delete&cpf=%s'>Deletar</a></td></tr>",
                    p.getCpf(), p.getNome(), p.getEndereco(), p.getContato(), p.getPlanoDeSaude(),
                    p.getCpf(), p.getCpf()
            );
        }

        out.println("</table>");
        out.println("<br><a href='index.html'>Voltar</a>");
        out.println("</body></html>");
    }

    private void showForm(HttpServletResponse response, Paciente paciente) throws IOException {

        PrintWriter out = response.getWriter();
        response.setContentType("text/html");

        out.println("<html><body>");
        out.printf("<h1>%s Paciente</h1>", "Editar");
        out.println("<form method='post' action='paciente'>");

        out.printf("CPF: <input type='text' name='cpf' value='%s' readonly/><br><br>",
                paciente.getCpf()
        );
        out.printf("Nome: <input type='text' name='nome' value='%s'/><br><br>",
                paciente.getNome()
        );
        out.printf("Endereço: <input type='text' name='endereco' value='%s'/><br><br>",
                paciente.getEndereco()
        );
        out.printf("Contato: <input type='text' name='contato' value='%s'/><br><br>",
                paciente.getContato()
        );
        out.printf("Plano de Saúde: <input type='text' name='planoDeSaude' value='%s'/><br><br>",
                paciente.getPlanoDeSaude()
        );

        out.println("<input type='submit' value='Salvar'/>");
        out.println("</form>");
        out.println("<br><a href='paciente'>Voltar</a>");
        out.println("</body></html>");
    }
}
