package web2.clinica.model.negocio;

public class ItemReceituario {
    private int codigo;
    private int dosagem;
    private int intervalorEntreDoses;
    private String observacao;
    private Medicamento medicamento;
    private Receituario receituario;

    public Receituario getReceituario() {
        return receituario;
    }

    public void setReceituario(Receituario receituario) {
        this.receituario = receituario;
    }

    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    public int getDosagem() {
        return dosagem;
    }

    public void setDosagem(int dosagem) {
        this.dosagem = dosagem;
    }

    public int getIntervalorEntreDoses() {
        return intervalorEntreDoses;
    }

    public void setIntervalorEntreDoses(int intervalorEntreDoses) {
        this.intervalorEntreDoses = intervalorEntreDoses;
    }

    public String getObservacao() {
        return observacao;
    }

    public void setObservacao(String observacao) {
        this.observacao = observacao;
    }

    public Medicamento getMedicamento() {
        return medicamento;
    }

    public void setMedicamento(Medicamento medicamento) {
        this.medicamento = medicamento;
    }
}
