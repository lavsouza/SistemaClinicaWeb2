package web2.clinica.controllers;

import web2.clinica.model.negocio.Medicamento;
import web2.clinica.model.negocio.Paciente;
import web2.clinica.model.repositorios.MedicamentoRepository;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Optional;

@WebServlet(name = "MedicamentoJSP", urlPatterns = {"/MedicamentoJSP"})
public class MedicamentoJSP extends HttpServlet {

    private MedicamentoRepository medicamentoRepo = new MedicamentoRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String op = request.getParameter("op");
        String codParam = request.getParameter("codigo");

        if (op != null && op.equals("deletar") && codParam != null) {
            int codigo = Integer.parseInt(codParam);
            medicamentoRepo.deletar(codigo);
            request.getSession().setAttribute("msg", "Medicamento excluído com sucesso!");
            response.sendRedirect("MedicamentoJSP");
            return;
        }

        if (codParam != null) {
            int codigo = Integer.parseInt(codParam);
            Optional<Medicamento> m = medicamentoRepo.buscarPorCodigo(codigo);
            if (m.isPresent()) {
                request.setAttribute("medicamentos", m.get());
                request.setAttribute("op", "alterar");
                getServletContext()
                        .getRequestDispatcher("/CadastroAlteracaoMedicamento.jsp")
                        .forward(request, response);
                return;
            } else {
                response.sendRedirect("MedicamentoJSP");
                return;
            }
        }

        List<Medicamento> medicamentos = medicamentoRepo.listarTodos();
        request.getSession().setAttribute("medicamentos", medicamentos);
        response.sendRedirect("Medicamentos.jsp");

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String op = request.getParameter("op");
        int codigo = Integer.parseInt(request.getParameter("codigo"));
        String nome = request.getParameter("nome");
        int dosagem = Integer.parseInt(request.getParameter("dosagem"));
        String tipoDosagem = request.getParameter("tipoDosagem");
        String descricao = request.getParameter("descricao");
        String observacao = request.getParameter("observacao");

        Medicamento medicamento = new Medicamento(codigo, nome, dosagem, tipoDosagem, descricao, observacao);

        if ("alterar".equals(op)) {
            medicamentoRepo.atualizar(medicamento);
            request.getSession().setAttribute("msg", "Medicamento atualizado com sucesso!");
        } else {
            medicamentoRepo.salvar(medicamento);
            request.getSession().setAttribute("msg", "Medicamento cadastrado com sucesso!");
        }

        response.sendRedirect("MedicamentoJSP");
    }

    @Override
    public String getServletInfo() {
        return "Servlet responsável por gerenciar CRUD de medicamentos";
    }
}
