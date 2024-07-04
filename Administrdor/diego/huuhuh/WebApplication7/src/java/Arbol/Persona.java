/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Arbol;

/**
 *
 * @author usuario
 */
public class Persona {
    private String nombreTaller;
    private int numeroAula;
    private int cupoMaximo;
    private String profesorEncargado;

    public Persona(String nombreTaller) {
        this.nombreTaller = nombreTaller;
    }
    
    

    public Persona(String nombreTaller, int numeroAula, int cupoMaximo, String profesorEncargado) {
        this.nombreTaller = nombreTaller;
        this.numeroAula = numeroAula;
        this.cupoMaximo = cupoMaximo;
        this.profesorEncargado = profesorEncargado;
    }


    public String getNombreTaller() {
        return nombreTaller;
    }

    public void setNombreTaller(String nombreTaller) {
        this.nombreTaller = nombreTaller;
    }

    public int getNumeroAula() {
        return numeroAula;
    }

    public void setNumeroAula(int numeroAula) {
        this.numeroAula = numeroAula;
    }

    public int getCupoMaximo() {
        return cupoMaximo;
    }

    public void setCupoMaximo(int cupoMaximo) {
        this.cupoMaximo = cupoMaximo;
    }

    public String getProfesorEncargado() {
        return profesorEncargado;
    }

    public void setProfesorEncargado(String profesorEncargado) {
        this.profesorEncargado = profesorEncargado;
    }

    @Override
    public String toString() {
        return "Persona{" + "nombreTaller=" + nombreTaller + 
                ", numeroAula=" + numeroAula + 
                ", cupoMaximo=" + cupoMaximo + 
                ", profesorEncargado=" + profesorEncargado + '}';
    }
}
