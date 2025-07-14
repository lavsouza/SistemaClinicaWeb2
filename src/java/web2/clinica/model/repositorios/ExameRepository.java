package web2.clinica.model.repositorios;

import web2.clinica.model.negocio.Exame;
import java.util.ArrayList;
import java.util.List;

public class ExameRepository {
    private static List<Exame> exames = new ArrayList<>();
    
    public void salvar(Exame exame) {
        exames.add(exame);
    }
    
    public List<Exame> listarPorProntuario(int idProntuario) {
        List<Exame> resultado = new ArrayList<>();
        for (Exame e : exames) {
            if (e.getCodigo() == idProntuario) {
                resultado.add(e);
            }
        }
        return resultado;
    }
}