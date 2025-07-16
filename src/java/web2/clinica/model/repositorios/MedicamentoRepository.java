package web2.clinica.model.repositorios;

import web2.clinica.model.negocio.Medicamento;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class MedicamentoRepository {
    private static List<Medicamento> medicamentos = new ArrayList<>();
    
    static {
        MedicamentoRepository.medicamentos = new ArrayList<>();
    }
    
    static {
        medicamentos.add(new Medicamento(1, "Paracetamol", 500, "mg", "Analgésico", "Tomar após refeições"));
        medicamentos.add(new Medicamento(2, "Ibuprofeno", 200, "mg", "Anti-inflamatório", "Não usar com estômago vazio"));
        medicamentos.add(new Medicamento(3, "Amoxicilina", 875, "mg", "Antibiótico", "Tomar de 8 em 8 horas"));
        medicamentos.add(new Medicamento(4, "Losartana", 50, "mg", "Pressão arterial", "Uso diário"));
        medicamentos.add(new Medicamento(5, "Omeprazol", 20, "mg", "Estômago", "Tomar em jejum"));
    }
    
    public void salvar(Medicamento medicamento) {
        medicamentos.add(medicamento);
    }

    public List<Medicamento> listarTodos() {
        return medicamentos;
    }

    static public Optional<Medicamento> buscarPorCodigo(int codigo) {
        return medicamentos.stream()
                .filter(m -> m.getCodigo() == codigo)
                .findFirst();
    }

    public void atualizar(Medicamento medicamento) {
        buscarPorCodigo(medicamento.getCodigo()).ifPresent(m -> {
            m.setNome(medicamento.getNome());
            m.setDosagem(medicamento.getDosagem());
            m.setTipoDosagem(medicamento.getTipoDosagem());
            m.setDescricao(medicamento.getDescricao());
            m.setObservacao(medicamento.getObservacao());
        });
    }

    public void deletar(int codigo) {
        medicamentos.removeIf(m -> m.getCodigo() == codigo);
    }
}
