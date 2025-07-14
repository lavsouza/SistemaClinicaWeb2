package web2.clinica.model.repositorios;

import web2.clinica.model.negocio.Receituario;
import java.util.ArrayList;
import java.util.List;

public class ReceituarioRepository {

    private static List<Receituario> receituarios = new ArrayList<>();

    public void salvar(Receituario receituario) {
        receituarios.add(receituario);
    }

    public static Receituario buscarPorConsulta(int codigoConsulta) {
        for (Receituario r : receituarios) {
            if (r.getCodigo() == codigoConsulta) {
                return r;
            }
        }
        return null;
    }
}
