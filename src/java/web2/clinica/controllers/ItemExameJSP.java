/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package web2.clinica.controllers;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Optional;
import web2.clinica.model.negocio.IndicadorExame;
import web2.clinica.model.negocio.ItemExame;
import web2.clinica.model.repositorios.IndicadorExameRepository;
import web2.clinica.model.repositorios.ItemExameRepository;

/**
 *
 * @author lucas
 */
@WebServlet(name = "ItemExameJSP", urlPatterns = {"/ItemExameJSP"})
public class ItemExameJSP extends HttpServlet {

    private ItemExameRepository itemRepo = new ItemExameRepository();
    private IndicadorExameRepository indicadorRepo = new IndicadorExameRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String op = request.getParameter("op");
        String codParam = request.getParameter("codigo");

        if (op != null && op.equals("deletar") && codParam != null) {
            int codigo = Integer.parseInt(codParam);
            itemRepo.deletar(codigo);
            request.getSession().setAttribute("msg", "Item de Exame excluído com sucesso!");
            response.sendRedirect("ItemExameJSP");
            return;
        }

        if (codParam != null) {
            int codigo = Integer.parseInt(codParam);
            Optional<ItemExame> item = itemRepo.buscarPorCodigo(codigo);
            if (item.isPresent()) {
                request.setAttribute("itemexame", item.get());
                request.setAttribute("op", "alterar");
                getServletContext()
                        .getRequestDispatcher("/CadastroAlteracaoItemExame.jsp")
                        .forward(request, response);
                return;
            } else {
                response.sendRedirect("ItemExameJSP");
                return;
            }
        }

        List<ItemExame> itens = itemRepo.listarTodos();
        request.getSession().setAttribute("itens", itens);
        response.sendRedirect("ItensExame.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String op = request.getParameter("op");

        int codigo = Integer.parseInt(request.getParameter("codigo"));
        String valorIndicador = request.getParameter("valorIndicador");
        String observacao = request.getParameter("observacao");
        int codIndicador = Integer.parseInt(request.getParameter("codIndicador"));

        Optional<IndicadorExame> indicador = indicadorRepo.buscarPorCodigo(codIndicador);

        ItemExame ie = new ItemExame(codigo, valorIndicador, observacao, indicador.get());

        if ("alterar".equals(op)) {
            itemRepo.atualizar(ie);
            request.getSession().setAttribute("msg", "Item de Exame atualizado com sucesso!");
        } else {
            itemRepo.salvar(ie);
            request.getSession().setAttribute("msg", "Item de Exame cadastrado com sucesso!");
        }

        response.sendRedirect("ItemExameJSP");
    }

    @Override
    public String getServletInfo() {
        return "Servlet responsável por gerenciar CRUD de itens de exame";
    }
}
