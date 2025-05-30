package web2.clinica.model.negocio;

public class IndicadorExame {
    private int codigo;
    private String indicador;
    private String descricao;
    private double minValorReferencia;
    private double maxValorReferencia;

    public IndicadorExame(int codigo, String indicador, String descricao, double minValorReferencia, double maxValorReferencia) {
        this.codigo = codigo;
        this.indicador = indicador;
        this.descricao = descricao;
        this.minValorReferencia = minValorReferencia;
        this.maxValorReferencia = maxValorReferencia;
    }

    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    public String getIndicador() {
        return indicador;
    }

    public void setIndicador(String indicador) {
        this.indicador = indicador;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public double getMinValorReferencia() {
        return minValorReferencia;
    }

    public void setMinValorReferencia(double minValorReferencia) {
        this.minValorReferencia = minValorReferencia;
    }

    public double getMaxValorReferencia() {
        return maxValorReferencia;
    }

    public void setMaxValorReferencia(double maxValorReferencia) {
        this.maxValorReferencia = maxValorReferencia;
    }
}
