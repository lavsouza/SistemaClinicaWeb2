package web2.clinica.model.negocio;

import java.util.List;

public class Consulta {
    private int codigo;
    private String dataHora;
    private String dataHoraVolta;
    private String observacao;

    private Medico medico;
    private Paciente paciente;
    private Prontuario prontuario;

    public Consulta(int codigo, String dataHora, Medico medico, Paciente paciente) {
        this.codigo = codigo;
        this.dataHora = dataHora;
        this.medico = medico;
        this.paciente = paciente;
    }

    public Prontuario getProntuario() {
        return prontuario;
    }

    public void setProntuario(Prontuario prontuario) {
        this.prontuario = prontuario;
    }

    public Paciente getPaciente() {
        return paciente;
    }

    public void setPaciente(Paciente paciente) {
        this.paciente = paciente;
    }

    public Medico getMedico() {
        return medico;
    }

    public void setMedico(Medico medico) {
        this.medico = medico;
    }

    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    public String getDataHora() {
        return dataHora;
    }

    public void setDataHora(String dataHora) {
        this.dataHora = dataHora;
    }

    public String getDataHoraVolta() {
        return dataHoraVolta;
    }

    public void setDataHoraVolta(String dataHoraVolta) {
        this.dataHoraVolta = dataHoraVolta;
    }

    public String getObservacao() {
        return observacao;
    }

    public void setObservacao(String observacao) {
        this.observacao = observacao;
    }
}

