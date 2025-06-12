package web2.clinica.model.negocio;

public class Medico {
    private String crm;
    private String nome;
    private String especialidade;
    private String contato;
    private String senha;

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public Medico(String crm, String nome, String especialidade, String contato, String senha) {
        this.crm = crm;
        this.nome = nome;
        this.especialidade = especialidade;
        this.contato = contato;
        this.senha = senha;
    }
    
    public String getContato() {
        return contato;
    }

    public void setContato(String contato) {
        this.contato = contato;
    }

    public String getCrm() {
        return crm;
    }

    public void setCrm(String crm) {
        this.crm = crm;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getEspecialidade() {
        return especialidade;
    }

    public void setEspecialidade(String especialidade) {
        this.especialidade = especialidade;
    }

}
