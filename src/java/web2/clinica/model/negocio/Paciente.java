package web2.clinica.model.negocio;

public class Paciente {
    private String cpf;
    private String nome;
    private String endereco;
    private String contato;
    private String planoDeSaude;

    public Paciente() {}

    public Paciente(String cpf, String nome, String endereco, String contato, String planoDeSaude) {
        this.cpf = cpf;
        this.nome = nome;
        this.endereco = endereco;
        this.contato = contato;
        this.planoDeSaude = planoDeSaude;
    }


    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getContato() {
        return contato;
    }

    public void setContato(String contato) {
        this.contato = contato;
    }

    public String getEndereco() {
        return endereco;
    }

    public void setEndereco(String endereco) {
        this.endereco = endereco;
    }

    public String getPlanoDeSaude() {
        return planoDeSaude;
    }

    public void setPlanoDeSaude(String planoDeSaude) {
        this.planoDeSaude = planoDeSaude;
    }
}
