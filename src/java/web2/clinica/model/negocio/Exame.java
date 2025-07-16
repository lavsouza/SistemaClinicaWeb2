package web2.clinica.model.negocio;

import java.util.List;

public class Exame {
    private int codigo;
    private String observacao;
    private List<ItemExame> itens;
    private Consulta consulta;

    public Consulta getConsulta() {
        return consulta;
    }

    public void setConsulta(Consulta consulta) {
        this.consulta = consulta;
    }

    public List<ItemExame> getItens() {
        return itens;
    }

    public void setItens(List<ItemExame> itens) {
        this.itens = itens;
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
