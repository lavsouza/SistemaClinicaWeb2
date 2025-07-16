package web2.clinica.model.repositorios;

import web2.clinica.model.negocio.Consulta;
import web2.clinica.model.negocio.Medico;
import web2.clinica.model.negocio.Paciente;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.atomic.AtomicInteger;

public class ConsultaRepository {

    private static final List<Consulta> consultas = new ArrayList<>();
    private static final AtomicInteger codigoConsulta = new AtomicInteger(1);

    static {
        Optional<Medico> medico = MedicoRepository.buscarPorCrm("123456");
        Optional<Paciente> paciente = PacienteRepository.buscarPorCpf("111.111.111-11");

        if (medico.isPresent() && paciente.isPresent()) {
            Consulta consulta = new Consulta();
            consulta.setCodigo(codigoConsulta.getAndIncrement());
            consulta.setDataHora("15-02-2025 15:54");
            consulta.setMedico(medico.get());
            consulta.setPaciente(paciente.get());

            consultas.add(consulta);
        }
    }

    public void salvar(Consulta consulta) {
        if (consulta.getCodigo() == 0) {
            consulta.setCodigo(codigoConsulta.getAndIncrement());
        }
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

    public List<Consulta> listarPorCrmMedicoSemProntuario(String crm) {
        List<Consulta> resultado = new ArrayList<>();
        for (Consulta c : consultas) {
            if (c.getMedico().getCrm().equals(crm) && c.getProntuario() == null) {
                resultado.add(c);
            }
        }
        return resultado;
    }

    public List<Consulta> listarPorCrmMedicoComProntuario(String crm) {
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
