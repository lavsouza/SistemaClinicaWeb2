package web2.clinica.model.repositorios;

import web2.clinica.model.negocio.Consulta;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class ConsultaRepository {

    private static List<Consulta> consultas = new ArrayList<>();

    public void salvar(Consulta consulta) {
        consultas.add(consulta);
    }

    public List<Consulta> listarTodas() {
        return new ArrayList<>(consultas);
    }

    public Optional<Consulta> buscarPorCodigo(int codigo) {
        return consultas.stream()
                .filter(c -> c.getCodigo() == codigo)
                .findFirst();
    }

    public static List<Consulta> listarPorCrmMedicoSemProntuario(String crm) {
        List<Consulta> resultado = new ArrayList<>();
        for (Consulta c : consultas) {
            if (c.getMedico().getCrm().equals(crm) && c.getProntuario() == null) {
                resultado.add(c);
            }
        }
        return resultado;
    }

    public static List<Consulta> listarPorCrmMedicoComProntuario(String crm) {
        List<Consulta> resultado = new ArrayList<>();
        for (Consulta c : consultas) {
            if (c.getMedico().getCrm().equals(crm) && c.getProntuario() != null) {
                resultado.add(c);
            }
        }
        return resultado;
    }

    public void deletar(int codigo) {
        consultas.removeIf(c -> c.getCodigo() == codigo);
    }
}
