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
import web2.clinica.model.negocio.Medico;
import web2.clinica.model.repositorios.MedicoRepository;

/**
 *
 * @author lucas
 */
@WebServlet("/medico")
public class CadastroMedico extends HttpServlet {

    private final MedicoRepository repository = new MedicoRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "new":
                response.sendRedirect("CadastroMedico.html");
                break;
            case "edit":
                String crm = request.getParameter("crm");
                Optional<Medico> medico = repository.buscarPorCrm(crm);

                if (medico.isPresent()) {
                    try {
                        showForm(response, medico.get());
                    } catch (IOException e) {
                        throw new RuntimeException(e);
                    }
                } else {
                    try {
                        response.sendRedirect("medico");
                    } catch (IOException e) {
                        throw new RuntimeException(e);
                    }
                }
                break;
            case "delete":
                repository.deletar(request.getParameter("crm"));
                response.sendRedirect("medico");
                break;
            default:
                showList(response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String crm = request.getParameter("crm");
        String nome = request.getParameter("nome");
        String especialidade = request.getParameter("especialidade");
        String contato = request.getParameter("contato");

        Medico medico = new Medico(crm, nome, especialidade, contato);

        if (repository.buscarPorCrm(crm).isPresent()) {
            repository.atualizar(medico);
        } else {
            repository.salvar(medico);
        }

        response.sendRedirect("medico");
    }

    private void showList(HttpServletResponse response) throws IOException {
        List<Medico> Medicos = repository.listarTodos();

        PrintWriter out = response.getWriter();
        response.setContentType("text/html");

        out.println("<html><body>");
        out.println("<h1>Lista de Medicos</h1>");
        out.println("<a href='medico?action=new'>Novo Medico</a><br><br>");
        out.println("<table border='1'>");
        out.println("<tr><th>CRM</th><th>Nome</th><th>Especialidade</th><th>Contato</th><th>Ações</th></tr>");

        for (Medico m : Medicos) {
            out.printf(
                    "<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td>"
                    + "<td><a href='medico?action=edit&crm=%s'>Editar</a> | "
                    + "<a href='medico?action=delete&crm=%s'>Deletar</a></td></tr>",
                    m.getCrm(), m.getNome(), m.getEspecialidade(), m.getContato(),
                    m.getCrm(), m.getCrm()
            );
        }

        out.println("</table>");
        out.println("<br><a href='index.html'>Voltar</a>");
        out.println("</body></html>");
    }

    private void showForm(HttpServletResponse response, Medico medico) throws IOException {

        PrintWriter out = response.getWriter();
        response.setContentType("text/html");

        out.println("<html><body>");
        out.printf("<h1>%s Medicos</h1>", "Editar");
        out.println("<form method='post' action='medico'>");

        out.printf("CRM: <input type='text' name='crm' value='%s' readonly/><br><br>",
                medico.getCrm()
        );
        out.printf("Nome: <input type='text' name='nome' value='%s'/><br><br>",
                medico.getNome()
        );
        out.printf("Especialidade: <input type='text' name='especialidade' value='%s'/><br><br>",
                medico.getEspecialidade()
        );
        out.printf("Contato: <input type='text' name='contato' value='%s'/><br><br>",
                medico.getContato()
        );

        out.println("<input type='submit' value='Salvar'/>");
        out.println("</form>");
        out.println("<br><a href='medico'>Voltar</a>");
        out.println("</body></html>");
    }

}
