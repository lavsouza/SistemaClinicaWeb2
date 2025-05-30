package web2.clinica.model.repositorios;

import web2.clinica.model.negocio.Medicamento;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class MedicamentoRepository {
    private List<Medicamento> medicamentos = new ArrayList<>();

    public void salvar(Medicamento medicamento) {
        medicamentos.add(medicamento);
    }

    public List<Medicamento> listarTodos() {
        return medicamentos;
    }

    public Optional<Medicamento> buscarPorCodigo(int codigo) {
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
