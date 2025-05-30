package web2.clinica.model.repositorios;

import web2.clinica.model.negocio.Medico;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class MedicoRepository {
    private List<Medico> medicos = new ArrayList<>();

    public void salvar(Medico medico) {
        medicos.add(medico);
    }

    public List<Medico> listarTodos() {
        return medicos;
    }

    public Optional<Medico> buscarPorCrm(String crm) {
        return medicos.stream()
                .filter(m -> m.getCrm().equals(crm))
                .findFirst();
    }

    public void atualizar(Medico medico) {
        buscarPorCrm(medico.getCrm()).ifPresent(m -> {
            m.setNome(medico.getNome());
            m.setEspecialidade(medico.getEspecialidade());
            m.setContato(medico.getContato());
        });
    }

    public void deletar(String crm) {
        medicos.removeIf(m -> m.getCrm().equals(crm));
    }
}
