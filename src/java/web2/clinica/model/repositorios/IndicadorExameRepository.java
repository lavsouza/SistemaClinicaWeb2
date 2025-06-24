package web2.clinica.model.repositorios;

import web2.clinica.model.negocio.IndicadorExame;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class IndicadorExameRepository {
    private static List<IndicadorExame> indicadores = new ArrayList<>();
    
    static {
        IndicadorExameRepository .indicadores = new ArrayList<>();
    }
    
    static {
        indicadores.add(new IndicadorExame(1, "Glicose", "Glicemia em jejum", 70, 99));
        indicadores.add(new IndicadorExame(2, "Colesterol Total", "Colesterol total no sangue", 0, 200));
        indicadores.add(new IndicadorExame(3, "Hemoglobina", "Hemoglobina no sangue", 12, 17));
        indicadores.add(new IndicadorExame(4, "Creatinina", "Função renal", 0.6, 1.3));
        indicadores.add(new IndicadorExame(5, "TSH", "Hormônio tireoidiano", 0.4, 4.0));
    }
    
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
