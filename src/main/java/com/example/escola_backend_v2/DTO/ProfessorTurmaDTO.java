
package com.example.escola_backend_v2.DTO;

public class ProfessorTurmaDTO {
    private ProfessorDTO professor;
    private TurmaDTO turma;

    public void ProfessorDTO() {
    }

    public void ProfessorDTO(ProfessorDTO professor, TurmaDTO turma) {
        this.professor = professor;
        this.turma = turma;
    }

    public ProfessorDTO getProfessor() {
        return professor;
    }
    public void setProfessor(ProfessorDTO professor) {
        this.professor = professor;
    }

    public TurmaDTO getTurma() {
        return turma;
    }
    public void setTurma(TurmaDTO turma) {
        this.turma = turma;
    }

    @Override
    public String toString() {
        return "ProfessorTurmaDTO{" +
                "professor=" + professor +
                "turma=" + '\'' +
                "}";
    }
}