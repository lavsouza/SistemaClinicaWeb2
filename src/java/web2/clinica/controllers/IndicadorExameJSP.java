package web2.clinica.controllers;

import web2.clinica.model.negocio.IndicadorExame;
import web2.clinica.model.repositorios.IndicadorExameRepository;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Optional;

@WebServlet(name = "IndicadorExameJSP", urlPatterns = {"/IndicadorExameJSP"})
public class IndicadorExameJSP extends HttpServlet {

    private IndicadorExameRepository indicadorRepo = new IndicadorExameRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String op = request.getParameter("op");
        String codParam = request.getParameter("codigo");

        if (op != null && op.equals("deletar") && codParam != null) {
            int codigo = Integer.parseInt(codParam);
            indicadorRepo.deletar(codigo);
            request.getSession().setAttribute("msg", "Indicador de Exame excluído com sucesso!");
            response.sendRedirect("IndicadorExameJSP");
            return;
        }

        if (codParam != null) {
            int codigo = Integer.parseInt(codParam);
            Optional<IndicadorExame> indicador = indicadorRepo.buscarPorCodigo(codigo);
            if (indicador.isPresent()) {
                request.setAttribute("indicador", indicador.get());
                request.setAttribute("op", "alterar");
                getServletContext()
                        .getRequestDispatcher("/CadastroAlteracaoIndicadorExame.jsp")
                        .forward(request, response);
                return;
            } else {
                response.sendRedirect("IndicadorExameJSP");
                return;
            }
        }

        List<IndicadorExame> indicadores = indicadorRepo.listarTodos();
        request.getSession().setAttribute("indicadores", indicadores);
        response.sendRedirect("IndicadoresExame.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String op = request.getParameter("op");
        int codigo = Integer.parseInt(request.getParameter("codigo"));
        String indicador = request.getParameter("indicador");
        String descricao = request.getParameter("descricao");
        double min = Double.parseDouble(request.getParameter("minValorReferencia"));
        double max = Double.parseDouble(request.getParameter("maxValorReferencia"));

        IndicadorExame ie = new IndicadorExame(codigo, indicador, descricao, min, max);

        if ("alterar".equals(op)) {
            indicadorRepo.atualizar(ie);
            request.getSession().setAttribute("msg", "Indicador de Exame atualizado com sucesso!");
        } else {
            indicadorRepo.salvar(ie);
            request.getSession().setAttribute("msg", "Indicador de Exame cadastrado com sucesso!");
        }

        response.sendRedirect("IndicadorExameJSP");
    }

    @Override
    public String getServletInfo() {
        return "Servlet responsável por gerenciar CRUD de indicadores de exame";
    }
}
