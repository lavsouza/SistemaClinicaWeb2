package web2.clinica.controllers;

import java.io.IOException;
import java.util.Optional;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import web2.clinica.model.negocio.Consulta;
import web2.clinica.model.negocio.Exame;
import web2.clinica.model.repositorios.ConsultaRepository;

@WebServlet(name = "ExameJSP", urlPatterns = {"/ExameJSP"})
public class ExameJSP extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int codigoConsulta = Integer.parseInt(request.getParameter("codigoConsulta"));
        String observacao = request.getParameter("observacao");

        ConsultaRepository consultaRepo = new ConsultaRepository();
        Optional<Consulta> consultaOpt = consultaRepo.buscarPorCodigo(codigoConsulta);

        if (consultaOpt.isPresent()) {
            Consulta consulta = consultaOpt.get();

            if (consulta.getExame() == null) {
                Exame exame = new Exame();
                exame.setObservacao(observacao);
                exame.setConsulta(consulta);
                consulta.setExame(exame);
            } else {
                consulta.getExame().setObservacao(observacao);
            }

            request.getSession().setAttribute("msg", "Exame salvo com sucesso.");
            response.sendRedirect("ConsultaJSP?codigo=" + codigoConsulta + "&op=visualizar");
        } else {
            request.getSession().setAttribute("msg", "Consulta não encontrada.");
            response.sendRedirect("TelaInicialMedico.jsp");
        }
    }
}
