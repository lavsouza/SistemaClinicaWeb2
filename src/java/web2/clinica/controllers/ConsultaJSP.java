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
import web2.clinica.model.negocio.Consulta;
import web2.clinica.model.negocio.Medico;
import web2.clinica.model.negocio.Paciente;
import web2.clinica.model.repositorios.MedicoRepository;
import web2.clinica.model.repositorios.PacienteRepository;
import web2.clinica.model.repositorios.ConsultaRepository;

@WebServlet(name = "ConsultaJSP", urlPatterns = {"/ConsultaJSP"})
public class ConsultaJSP extends HttpServlet {

    private ConsultaRepository consultaRepo = new ConsultaRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String codParam = request.getParameter("codigo");
        String operacao = request.getParameter("op");

        if (operacao != null && operacao.equals("deletar")) {
            int codigo = Integer.parseInt(codParam);
            consultaRepo.deletar(codigo);
            request.getSession().setAttribute("msg", "Consulta excluída com sucesso!");
            response.sendRedirect("ConsultaJSP");
            return;
        }

        if (operacao != null && operacao.equals("visualizar")) {
            int codigo = Integer.parseInt(codParam);
            Optional<Consulta> consultaOpt = consultaRepo.buscarPorCodigo(codigo);

            if (consultaOpt.isPresent()) {
                Consulta consulta = consultaOpt.get();
                String[] partes = consulta.getDataHora().split(" : ");

                request.setAttribute("data", partes[0]);
                request.setAttribute("hora", partes.length > 1 ? partes[1] : "");
                request.setAttribute("consulta", consulta);

                getServletContext()
                        .getRequestDispatcher("/DetalharConsulta.jsp")
                        .forward(request, response);
            } else {
                request.getSession().setAttribute("msg", "Consulta não encontrada!");
                response.sendRedirect("ConsultaJSP");
            }
            return;
        }

        if (codParam != null) {
            int codigo = Integer.parseInt(codParam);
            Optional<Consulta> c = consultaRepo.buscarPorCodigo(codigo);
            if (c.isPresent()) {
                String[] partes = c.get().getDataHora().split(" : ");
                request.setAttribute("data", partes[0]);
                request.setAttribute("hora", partes[1]);
                request.setAttribute("consulta", c.get());
                request.setAttribute("op", "alterar");
                getServletContext()
                        .getRequestDispatcher("/CadastroAlteracaoConsulta.jsp")
                        .forward(request, response);
            } else {
                response.sendRedirect("ConsultaJSP");
            }
            return;
        }

        List<Consulta> consultas = consultaRepo.listarTodas();
        request.getSession().setAttribute("consultas", consultas);
        response.sendRedirect("Consultas.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String operation = request.getParameter("op");

        if ("dataAlt".equals(operation)) {
            String codigoStr = request.getParameter("codigo");
            String dataRetorno = request.getParameter("dataRetorno");

            if (codigoStr == null || dataRetorno == null || dataRetorno.trim().isEmpty()) {
                request.getSession().setAttribute("msg", "Erro: Código da consulta ou data de retorno inválidos.");
                response.sendRedirect("DetalharConsulta.jsp"); // Ou a página atual
                return;
            }

            int codigo = Integer.parseInt(codigoStr);

            Optional<Consulta> consultaOpt = consultaRepo.buscarPorCodigo(codigo);
            if (consultaOpt.isPresent()) {
                Consulta consulta = consultaOpt.get();
                consulta.setDataHoraVolta(dataRetorno); // Supondo que você tem esse método

                // Atualizar a consulta no repositório
                consultaRepo.deletar(codigo);
                consultaRepo.salvar(consulta);

                request.getSession().setAttribute("msg", "Data de retorno atualizada com sucesso!");
                response.sendRedirect("ConsultaJSP?codigo=" + codigo + "&op=visualizar");
            } else {
                request.getSession().setAttribute("msg", "Consulta não encontrada.");
                response.sendRedirect("ConsultaJSP");
            }

            return;
        }
        
        String data = request.getParameter("data");
        String hora = request.getParameter("hora");
        String cpf = request.getParameter("cpf");
        String crm = request.getParameter("crm");
        String dataRetorno = request.getParameter("dataRetorno");

        String dataHora = data + " : " + hora;
        Optional<Medico> medico = MedicoRepository.buscarPorCrm(crm);
        Optional<Paciente> paciente = PacienteRepository.buscarPorCpf(cpf);

        if (!medico.isPresent() || !paciente.isPresent()) {
            request.getSession().setAttribute("msg", "Erro: Médico ou paciente não encontrado.");
            response.sendRedirect("CadastroAlteracaoConsulta.jsp");
            return;
        }

        int codigo = Integer.parseInt(request.getParameter("codigo"));

        Consulta c = new Consulta(codigo, dataHora, medico.get(), paciente.get());

        if ("alterar".equals(operation)) {
            consultaRepo.deletar(codigo);
            consultaRepo.salvar(c);
            request.getSession().setAttribute("msg", "Consulta atualizada com sucesso!");
        } else {
            consultaRepo.salvar(c);
            request.getSession().setAttribute("msg", "Consulta cadastrada com sucesso!");
        }

        response.sendRedirect("ConsultaJSP");
    }

    @Override
    public String getServletInfo() {
        return "Servlet responsável por gerenciar CRUD de consultas";
    }
}
