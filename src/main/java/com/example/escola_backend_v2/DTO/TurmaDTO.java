package com.example.escola_backend_v2.DTO;

import java.util.List;

public class TurmaDTO {
    private int id;
    private String periodoLetivo;
    private DisciplinaDTO disciplina;
    private SalaDTO sala;
    private List<TurmaAlunoDTO> alunos;
    private List<ProfessorDTO> professores;

    public TurmaDTO() {
    }

    public TurmaDTO(int id, String periodoLetivo, DisciplinaDTO disciplina, SalaDTO sala, List<TurmaAlunoDTO> alunos, List<ProfessorDTO> professores) {
        this.id = id;
        this.periodoLetivo = periodoLetivo;
        this.disciplina = disciplina;
        this.sala = sala;
        this.alunos = alunos;
        this.professores = professores;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPeriodoLetivo() {
        return periodoLetivo;
    }

    public void setPeriodoLetivo(String periodoLetivo) {
        this.periodoLetivo = periodoLetivo;
    }

    public DisciplinaDTO getDisciplina() {
        return disciplina;
    }

    public void setDisciplina(DisciplinaDTO disciplina) {
        this.disciplina = disciplina;
    }

    public SalaDTO getSala() {
        return sala;
    }

    public void setSala(SalaDTO sala) {
        this.sala = sala;
    }

    public List<TurmaAlunoDTO> getAlunos() {
        return alunos;
    }

    public void setAlunos(List<TurmaAlunoDTO> alunos) {
        this.alunos = alunos;
    }

    public List<ProfessorDTO> getProfessores() {
        return professores;
    }

    public void setProfessores(List<ProfessorDTO> professores) {
        this.professores = professores;
    }

    @Override
    public String toString() {
        return "TurmaDTO{" +
                "id=" + id +
                ", periodoLetivo='" + periodoLetivo + '\'' +
                ", disciplina=" + disciplina +
                ", sala=" + sala +
                ", alunos=" + alunos +
                ", professores=" + professores +
                '}';
    }
}
