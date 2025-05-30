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
import web2.clinica.model.negocio.Medicamento;
import web2.clinica.model.repositorios.MedicamentoRepository;

/**
 *
 * @author lucas
 */
@WebServlet("/medicamento")
public class CadastroMedicamento extends HttpServlet {

    private final MedicamentoRepository repository = new MedicamentoRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "new":
                response.sendRedirect("CadastroMedicamento.html");
                break;
            case "edit":
                int codigo = Integer.parseInt(request.getParameter("codigo"));
                Optional<Medicamento> medicamento = repository.buscarPorCodigo(codigo);

                if (medicamento.isPresent()) {
                    showForm(response, medicamento.get());
                } else {
                    response.sendRedirect("medicamento");
                }
                break;
            case "delete":
                repository.deletar(Integer.parseInt(request.getParameter("codigo")));
                response.sendRedirect("medicamento");
                break;
            default:
                showList(response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int codigo = Integer.parseInt(request.getParameter("codigo"));
        String nome = request.getParameter("nome");
        int dosagem = Integer.parseInt(request.getParameter("dosagem"));
        String tipoDosagem = request.getParameter("tipoDosagem");
        String descricao = request.getParameter("descricao");
        String observacao = request.getParameter("observacao");

        Medicamento medicamento = new Medicamento(codigo, nome, dosagem, tipoDosagem, descricao, observacao);

        if (repository.buscarPorCodigo(codigo).isPresent()) {
            repository.atualizar(medicamento);
        } else {
            repository.salvar(medicamento);
        }

        response.sendRedirect("medicamento");
    }

    private void showList(HttpServletResponse response) throws IOException {
        List<Medicamento> medicamentos = repository.listarTodos();

        PrintWriter out = response.getWriter();
        response.setContentType("text/html");

        out.println("<html><body>");
        out.println("<h1>Lista de Medicamentos</h1>");
        out.println("<a href='medicamento?action=new'>Novo Medicamento</a><br><br>");
        out.println("<table border='1'>");
        out.println("<tr>"
                + "<th>Código</th>"
                + "<th>Nome</th>"
                + "<th>Dosagem</th>"
                + "<th>Tipo Dosagem</th>"
                + "<th>Descrição</th>"
                + "<th>Observação</th>"
                + "<th>Ações</th>"
                + "</tr>");

        for (Medicamento m : medicamentos) {
            out.printf(
                    "<tr>"
                    + "<td>%d</td>"
                    + "<td>%s</td>"
                    + "<td>%d</td>"
                    + "<td>%s</td>"
                    + "<td>%s</td>"
                    + "<td>%s</td>"
                    + "<td>"
                    + "<a href='medicamento?action=edit&codigo=%d'>Editar</a> | "
                    + "<a href='medicamento?action=delete&codigo=%d'>Deletar</a>"
                    + "</td>"
                    + "</tr>",
                    m.getCodigo(),
                    m.getNome(),
                    m.getDosagem(),
                    m.getTipoDosagem(),
                    m.getDescricao(),
                    m.getObservacao(),
                    m.getCodigo(),
                    m.getCodigo()
            );
        }

        out.println("</table>");
        out.println("<br><a href='index.html'>Voltar</a>");
        out.println("</body></html>");
    }

    private void showForm(HttpServletResponse response, Medicamento medicamento) throws IOException {
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");

        out.println("<html><body>");
        out.printf("<h1>%s Medicamento</h1>", "Editar");
        out.println("<form method='post' action='medicamento'>");

        out.printf("Código: <input type='text' name='codigo' value='%d' readonly/><br><br>",
                medicamento.getCodigo()
        );
        out.printf("Nome: <input type='text' name='nome' value='%s'/><br><br>",
                medicamento.getNome()
        );
        out.printf("Dosagem: <input type='number' name='dosagem' value='%d'/><br><br>",
                medicamento.getDosagem()
        );
        out.printf("Tipo de Dosagem: <input type='text' name='tipoDosagem' value='%s'/><br><br>",
                medicamento.getTipoDosagem()
        );
        out.printf("Descrição: <input type='text' name='descricao' value='%s'/><br><br>",
                medicamento.getDescricao()
        );
        out.printf("Observação: <input type='text' name='observacao' value='%s'/><br><br>",
                medicamento.getObservacao()
        );

        out.println("<input type='submit' value='Salvar'/>");
        out.println("</form>");
        out.println("<br><a href='medicamento'>Voltar</a>");
        out.println("</body></html>");
    }
}
