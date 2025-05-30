package web2.clinica.controllers;

import web2.clinica.model.negocio.IndicadorExame;
import web2.clinica.model.repositorios.IndicadorExameRepository;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Optional;

@WebServlet("/indicadorExame")
public class CadastroIndicadorExame extends HttpServlet {

    private final IndicadorExameRepository repository = new IndicadorExameRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "new":
                showForm(response, null);
                break;
            case "edit":
                int codigo = Integer.parseInt(request.getParameter("codigo"));
                Optional<IndicadorExame> indicador = repository.buscarPorCodigo(codigo);

                if (indicador.isPresent()) {
                    showForm(response, indicador.get());
                } else {
                    response.sendRedirect("indicadorExame");
                }
                break;
            case "delete":
                int codigoDelete = Integer.parseInt(request.getParameter("codigo"));
                repository.deletar(codigoDelete);
                response.sendRedirect("indicadorExame");
                break;
            default:
                showList(response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int codigo = Integer.parseInt(request.getParameter("codigo"));
        String indicador = request.getParameter("indicador");
        String descricao = request.getParameter("descricao");
        double minValor = Double.parseDouble(request.getParameter("minValorReferencia"));
        double maxValor = Double.parseDouble(request.getParameter("maxValorReferencia"));

        IndicadorExame obj = new IndicadorExame(codigo, indicador, descricao, minValor, maxValor);

        if (repository.buscarPorCodigo(codigo).isPresent()) {
            repository.atualizar(obj);
        } else {
            repository.salvar(obj);
        }

        response.sendRedirect("indicadorExame");
    }

    private void showList(HttpServletResponse response) throws IOException {
        List<IndicadorExame> indicadores = repository.listarTodos();

        PrintWriter out = response.getWriter();
        response.setContentType("text/html");

        out.println("<html><body>");
        out.println("<h1>Lista de Indicadores de Exame</h1>");
        out.println("<a href='indicadorExame?action=new'>Novo Indicador</a><br><br>");
        out.println("<table border='1'>");
        out.println("<tr><th>Código</th><th>Indicador</th><th>Descrição</th><th>Valor Mínimo</th><th>Valor Máximo</th><th>Ações</th></tr>");

        for (IndicadorExame i : indicadores) {
            out.printf(
                    "<tr><td>%d</td><td>%s</td><td>%s</td><td>%.2f</td><td>%.2f</td>"
                    + "<td><a href='indicadorExame?action=edit&codigo=%d'>Editar</a> | "
                    + "<a href='indicadorExame?action=delete&codigo=%d'>Deletar</a></td></tr>",
                    i.getCodigo(), i.getIndicador(), i.getDescricao(),
                    i.getMinValorReferencia(), i.getMaxValorReferencia(),
                    i.getCodigo(), i.getCodigo()
            );
        }

        out.println("</table>");
        out.println("<br><a href='index.html'>Voltar</a>");
        out.println("</body></html>");
    }

    private void showForm(HttpServletResponse response, IndicadorExame indicador) throws IOException {
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");

        out.println("<html><body>");
        out.printf("<h1>%s Indicador de Exame</h1>", (indicador == null) ? "Novo" : "Editar");
        out.println("<form method='post' action='indicadorExame'>");

        out.printf("Código: <input type='number' name='codigo' value='%s' %s/><br><br>",
                (indicador != null) ? indicador.getCodigo() : "",
                (indicador != null) ? "readonly" : ""
        );
        out.printf("Indicador: <input type='text' name='indicador' value='%s'/><br><br>",
                (indicador != null) ? indicador.getIndicador() : ""
        );
        out.printf("Descrição: <input type='text' name='descricao' value='%s'/><br><br>",
                (indicador != null) ? indicador.getDescricao() : ""
        );
        out.printf("Valor Mínimo de Referência: <input type='number' step='0.01' name='minValorReferencia' value='%s'/><br><br>",
                (indicador != null) ? indicador.getMinValorReferencia() : ""
        );
        out.printf("Valor Máximo de Referência: <input type='number' step='0.01' name='maxValorReferencia' value='%s'/><br><br>",
                (indicador != null) ? indicador.getMaxValorReferencia() : ""
        );

        out.println("<input type='submit' value='Salvar'/>");
        out.println("</form>");
        out.println("<br><a href='indicadorExame'>Voltar</a>");
        out.println("</body></html>");
    }
}
