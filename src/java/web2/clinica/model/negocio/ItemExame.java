package web2.clinica.model.negocio;

public class ItemExame {
    private int codigo;
    private String valorIndicador;
    private String observacao;
    private IndicadorExame indicador;

    public IndicadorExame getIndicador() {
        return indicador;
    }

    public void setIndicador(IndicadorExame indicador) {
        this.indicador = indicador;
    }

    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    public String getValorIndicador() {
        return valorIndicador;
    }

    public void setValorIndicador(String valorIndicador) {
        this.valorIndicador = valorIndicador;
    }

    public String getObservacao() {
        return observacao;
    }

    public void setObservacao(String observacao) {
        this.observacao = observacao;
    }
}
