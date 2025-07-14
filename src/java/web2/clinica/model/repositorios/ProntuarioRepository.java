package web2.clinica.model.repositorios;

import web2.clinica.model.negocio.Prontuario;
import java.util.ArrayList;
import java.util.List;

public class ProntuarioRepository {
    private static List<Prontuario> prontuarios = new ArrayList<>();
    
    public void salvar(Prontuario prontuario) {
        prontuarios.add(prontuario);
    }
    
    public static List<Prontuario> listarTodos() {
        return new ArrayList<>(prontuarios);
    }
}