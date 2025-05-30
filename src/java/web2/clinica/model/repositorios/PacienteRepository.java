package web2.clinica.model.repositorios;

import web2.clinica.model.negocio.Paciente;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class PacienteRepository  {
    private static List<Paciente> paciente;

    static {
        PacienteRepository .paciente = new ArrayList<>();
    }

    public void salvar(Paciente novoPaciente) {
        paciente.add(novoPaciente);
    }

    public List<Paciente> listarTodos() {
        return paciente;
    }

    public Optional<Paciente> buscarPorCpf(String cpf) {
        return paciente.stream()
                .filter(p -> p.getCpf().equals(cpf))
                .findFirst();
    }

    public void atualizar(Paciente pacientes) {
        buscarPorCpf(pacientes.getCpf()).ifPresent(p -> {
            p.setNome(pacientes.getNome());
            p.setEndereco(pacientes.getEndereco());
            p.setContato(pacientes.getContato());
            p.setPlanoDeSaude(pacientes.getPlanoDeSaude());
        });
    }

    public void deletar(String cpf) {
        paciente.removeIf(p -> p.getCpf().equals(cpf));
    }
}
