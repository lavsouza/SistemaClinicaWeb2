package web2.clinica.model.repositorios;

import web2.clinica.model.negocio.IndicadorExame;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class IndicadorExameRepository {
    private List<IndicadorExame> indicadores = new ArrayList<>();

    public void salvar(IndicadorExame indicador) {
        indicadores.add(indicador);
    }

    public List<IndicadorExame> listarTodos() {
        return indicadores;
    }

    public Optional<IndicadorExame> buscarPorCodigo(int codigo) {
        return indicadores.stream()
                .filter(i -> i.getCodigo() == codigo)
                .findFirst();
    }

    public void atualizar(IndicadorExame indicador) {
        buscarPorCodigo(indicador.getCodigo()).ifPresent(i -> {
            i.setIndicador(indicador.getIndicador());
            i.setDescricao(indicador.getDescricao());
            i.setMinValorReferencia(indicador.getMinValorReferencia());
            i.setMaxValorReferencia(indicador.getMaxValorReferencia());
        });
    }

    public void deletar(int codigo) {
        indicadores.removeIf(i -> i.getCodigo() == codigo);
    }
}
