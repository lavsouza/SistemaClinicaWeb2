package web2.clinica.model.repositorios;

import web2.clinica.model.negocio.ItemExame;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class ItemExameRepository {

    private static List<ItemExame> itens = new ArrayList<>();

    public void salvar(ItemExame item) {
        itens.add(item);
    }

    public List<ItemExame> listarTodos() {
        return itens;
    }

    public List<ItemExame> listarPorExame(int idExame) {
        List<ItemExame> resultado = new ArrayList<>();
        for (ItemExame i : itens) {
            if (i.getCodigo() == idExame) {
                resultado.add(i);
            }
        }
        return resultado;
    }
    
    public void atualizar(ItemExame item) {
        buscarPorCodigo(item.getCodigo()).ifPresent(i -> {
            i.setIndicador(item.getIndicador());
            i.setValorIndicador(item.getValorIndicador());
            i.setObservacao(item.getObservacao());
        });
    }
    
    public Optional<ItemExame> buscarPorCodigo(int codigo) {
        return itens.stream()
                .filter(i -> i.getCodigo() == codigo)
                .findFirst();
    }
    
    public void deletar(int codigo) {
        itens.removeIf(i -> i.getCodigo() == codigo);
    }
}
