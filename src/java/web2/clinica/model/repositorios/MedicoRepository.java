package web2.clinica.model.repositorios;

import web2.clinica.model.negocio.Medico;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class MedicoRepository {
    private static List<Medico> medicos = new ArrayList<>();

    public static void salvar(Medico medico) {
        medicos.add(medico);
    }

    public static List<Medico> listarTodos() {
        return medicos;
    }

    public static Optional<Medico> buscarPorCrm(String crm) {
        return medicos.stream()
                .filter(m -> m.getCrm().equals(crm))
                .findFirst();
    }

    public Medico login(String crm, String senha) {
        for (Medico m : this.medicos) {
            if (m.getCrm().equals(crm) && m.getSenha().equals(senha)) {
                return m;
            }
        }
        return null;
    }

    public static void atualizar(Medico medico) {
        buscarPorCrm(medico.getCrm()).ifPresent(m -> {
            m.setNome(medico.getNome());
            m.setEspecialidade(medico.getEspecialidade());
            m.setContato(medico.getContato());
            m.setSenha(medico.getSenha());
        });
    }

    public static void deletar(String crm) {
        medicos.removeIf(m -> m.getCrm().equals(crm));
    }
}
