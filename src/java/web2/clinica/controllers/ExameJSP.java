package web2.clinica.controllers;

import java.io.IOException;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import web2.clinica.model.negocio.*;
import web2.clinica.model.repositorios.*;

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

            Exame exame = consulta.getExame();
            if (exame == null) {
                exame = new Exame();
                exame.setConsulta(consulta);
                consulta.setExame(exame);
            }
            exame.setObservacao(observacao);

            exame.getItens().clear();

            String[] codigosIndicador = request.getParameterValues("codigoIndicador");
            String[] valores = request.getParameterValues("valorIndicador");
            String[] observacoesItem = request.getParameterValues("observacaoItem");

            if (codigosIndicador != null) {
                IndicadorExameRepository indicadorRepo = new IndicadorExameRepository();
                ItemExameRepository itemRepo = new ItemExameRepository();

                for (int i = 0; i < codigosIndicador.length; i++) {
                    try {
                        int codIndicador = Integer.parseInt(codigosIndicador[i]);
                        Optional<IndicadorExame> indicadorOpt = indicadorRepo.buscarPorCodigo(codIndicador);

                        if (indicadorOpt.isPresent()) {
                            IndicadorExame indicador = indicadorOpt.get();
                            String valor = valores[i];
                            String obs = observacoesItem[i];

                            ItemExame item = new ItemExame(gerarCodigoUnico(itemRepo), valor, obs, indicador);
                            item.setExame(exame);
                            exame.getItens().add(item);
                            itemRepo.salvar(item);
                        }
                    } catch (Exception e) {
                       
                    }
                }
            }

            request.getSession().setAttribute("msg", "Exame salvo com sucesso.");
            response.sendRedirect("ConsultaJSP?codigo=" + codigoConsulta + "&op=visualizar");
        } else {
            request.getSession().setAttribute("msg", "Consulta não encontrada.");
            response.sendRedirect("TelaInicialMedico.jsp");
        }
    }

    private int gerarCodigoUnico(ItemExameRepository repo) {
        int codigo = 1;
        while (repo.buscarPorCodigo(codigo).isPresent()) {
            codigo++;
        }
        return codigo;
    }
}
