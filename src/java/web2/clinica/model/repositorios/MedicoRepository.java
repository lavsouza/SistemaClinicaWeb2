package web2.clinica.model.repositorios;

import web2.clinica.model.negocio.Medico;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class MedicoRepository {
    private static List<Medico> medicos = new ArrayList<>();
    
    static {
        medicos.add(new Medico("123456", "Dr. João Silva", "Cardiologia", "joao@clinica.com", "teste"));
        medicos.add(new Medico("234567", "Dra. Ana Lima", "Pediatria", "ana@clinica.com", "teste"));
        medicos.add(new Medico("345678", "Dr. Pedro Rocha", "Ortopedia", "pedro@clinica.com", "teste"));
        medicos.add(new Medico("456789", "Dra. Carla Nunes", "Dermatologia", "carla@clinica.com", "teste"));
        medicos.add(new Medico("567890", "Dr. Lucas Almeida", "Neurologia", "lucas@clinica.com", "teste"));
    }
    
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
