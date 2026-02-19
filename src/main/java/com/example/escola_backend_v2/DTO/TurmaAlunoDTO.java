package com.example.escola_backend_v2.DTO;

public class TurmaAlunoDTO {
    private TurmaDTO turma;
    private Double nota1;
    private Double nota2;
    private String observacoes;
    private AlunoDTO aluno;
    private Double media;

    public TurmaAlunoDTO(TurmaDTO turma, Double nota1, Double nota2, String observacoes, AlunoDTO aluno) {
        this.turma = turma;
        this.nota1 = nota1;
        this.nota2 = nota2;
        this.observacoes = observacoes;
        this.aluno = aluno;
    }

    public TurmaAlunoDTO() {
    }

    public TurmaDTO getTurma() {
        return turma;
    }

    public void setTurma(TurmaDTO turma) {
        this.turma = turma;
    }

    public Double getNota1() {
        return nota1;
    }

    public void setNota1(Double nota1) {
        this.nota1 = nota1;
    }

    public Double getNota2() {
        return nota2;
    }

    public void setNota2(Double nota2) {
        this.nota2 = nota2;
    }

    public String getObservacoes() {
        return observacoes;
    }

    public void setObservacoes(String observacoes) {
        this.observacoes = observacoes;
    }

    public Double getMedia() {

        double n1 = (nota1 != null) ? nota1 : 0.0;
        double n2 = (nota2 != null) ? nota2 : 0.0;

        return (n1 + n2) / 2;
    }


    public AlunoDTO getAluno() {
        return aluno;
    }

    public void setAluno(AlunoDTO aluno) {
        this.aluno = aluno;
    }

    public void setMedia(Double media) {
        this.media = media;
    }

    @Override
    public String toString() {
        return "TurmaAlunoDTO{" +
                "turma=" + turma +
                ", nota1=" + nota1 +
                ", nota2=" + nota2 +
                ", observacoes='" + observacoes + '\'' +
                '}';
    }
}
