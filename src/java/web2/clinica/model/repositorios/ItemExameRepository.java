package web2.clinica.model.repositorios;

import web2.clinica.model.negocio.ItemExame;
import java.util.ArrayList;
import java.util.List;

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
}
