package web2.clinica.model.negocio;

import java.util.List;

public class Receituario {
    private int codigo;
    private String observacao;
    private List<ItemReceituario> itensReceituario;

    public List<ItemReceituario> getItensReceituario() {
        return itensReceituario;
    }

    public void setItensReceituario(List<ItemReceituario> itensReceituario) {
        this.itensReceituario = itensReceituario;
    }

    public String getObservacao() {
        return observacao;
    }

    public void setObservacao(String observacao) {
        this.observacao = observacao;
    }

    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }
}
