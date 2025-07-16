package web2.clinica.model.repositorios;

import web2.clinica.model.negocio.Paciente;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class PacienteRepository {

    private static List<Paciente> paciente;

    static {
        paciente = new ArrayList<>();
        paciente.add(new Paciente("111.111.111-11", "Maria Souza", "Rua A", "11-9999-0001", "Unimed"));
        paciente.add(new Paciente("222.222.222-22", "Carlos Silva", "Rua B", "11-9999-0002", "Bradesco"));
        paciente.add(new Paciente("333.333.333-33", "Fernanda Rocha", "Rua C", "11-9999-0003", "Amil"));
        paciente.add(new Paciente("444.444.444-44", "Ricardo Lima", "Rua D", "11-9999-0004", "SulAmérica"));
        paciente.add(new Paciente("555.555.555-55", "Juliana Costa", "Rua E", "11-9999-0005", "Porto Seguro"));
    }

    public void salvar(Paciente novoPaciente) {
        paciente.add(novoPaciente);
    }

    public List<Paciente> listarTodos() {
        return paciente;
    }

    public static Optional<Paciente> buscarPorCpf(String cpf) {
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
