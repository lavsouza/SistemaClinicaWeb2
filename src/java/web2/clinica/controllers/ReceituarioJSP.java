package web2.clinica.controllers;

import java.io.IOException;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import web2.clinica.model.negocio.*;
import web2.clinica.model.repositorios.ConsultaRepository;
import web2.clinica.model.repositorios.MedicamentoRepository;

@WebServlet(name = "ReceituarioJSP", urlPatterns = {"/ReceituarioJSP"})
public class ReceituarioJSP extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int codigoConsulta = Integer.parseInt(request.getParameter("codigoConsulta"));
        String observacaoReceituario = request.getParameter("observacao");

        String[] codigosMedicamentos = request.getParameterValues("medicamentoCodigo");
        String[] dosagens = request.getParameterValues("dosagem");
        String[] intervalos = request.getParameterValues("intervalo");
        String[] observacoesItens = request.getParameterValues("obsItem");

        ConsultaRepository consultaRepo = new ConsultaRepository();
        Optional<Consulta> consultaOpt = consultaRepo.buscarPorCodigo(codigoConsulta);

        if (consultaOpt.isPresent()) {
            Consulta consulta = consultaOpt.get();

            Receituario receituario = consulta.getReceituario();
            if (receituario == null) {
                receituario = new Receituario();
                receituario.setConsulta(consulta);
                consulta.setReceituario(receituario);
            }

            receituario.setObservacao(observacaoReceituario);

            List<ItemReceituario> listaItens = new ArrayList<>();

            if (codigosMedicamentos != null) {
                for (int i = 0; i < codigosMedicamentos.length; i++) {
                    if (codigosMedicamentos[i] == null || codigosMedicamentos[i].trim().isEmpty()) {
                        continue;
                    }

                    try {
                        int codMedicamento = Integer.parseInt(codigosMedicamentos[i]);
                        Optional<Medicamento> medOpt = MedicamentoRepository.buscarPorCodigo(codMedicamento);

                        if (!medOpt.isPresent()) {
                            continue;
                        }

                        ItemReceituario item = new ItemReceituario();
                        item.setMedicamento(medOpt.get());
                        item.setDosagem(Integer.parseInt(dosagens[i]));
                        item.setIntervalorEntreDoses(Integer.parseInt(intervalos[i]));
                        item.setObservacao(observacoesItens[i]);
                        item.setReceituario(receituario);

                        listaItens.add(item);
                    } catch (NumberFormatException e) {
                        // Ignora campos inválidos
                    }
                }
            }

            receituario.setItensReceituario(listaItens);

            request.getSession().setAttribute("msg", "Receituário salvo com sucesso.");
            response.sendRedirect("ConsultaJSP?codigo=" + codigoConsulta + "&op=visualizar");
        } else {
            request.getSession().setAttribute("msg", "Consulta não encontrada.");
            response.sendRedirect("TelaInicialMedico.jsp");
        }
    }
}
