/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Arbol;

/**
 *
 * @author Pablo
 */
import java.util.ArrayList;

public class NodoArbol {

    Persona persona;
    NodoArbol li;
    NodoArbol ld;

    public NodoArbol(Persona nuevaPersona) {
        this.persona = nuevaPersona;
        li = null;
        ld = null;
    }

    public void busquedaProvincia(ArrayList<String> lista, String cedula) {
        if (this.persona.getNombreTaller().compareTo(cedula)== 0) {
            lista.add(String.valueOf(this.persona.getNombreTaller()));
            System.out.println("Cedula encontrada " + cedula + "(La cedula a "
                    + "buscar se cambia en la linea 14 de principal)");
        }
        if (li != null) {
            li.busquedaProvincia(lista, cedula);
        }
        if (ld != null) {
            ld.busquedaProvincia(lista, cedula);
        }
        if (!lista.contains(String.valueOf(cedula))) {
            System.out.println("Cedula no encontrada.");
        }
    }

    public synchronized void insertar(Persona nuevaPersona) {
        int comparacion = this.persona.getNombreTaller().compareTo(nuevaPersona.getNombreTaller());

        if (comparacion == 0) {
            return;
        }
        if (comparacion > 0) {
            if (li == null) {
                li = new NodoArbol(nuevaPersona);
                System.out.println("\nInsertado a la izquierda...");
            } else {
                li.insertar(nuevaPersona);
            }
        } else {
            if (ld == null) {
                ld = new NodoArbol(nuevaPersona);
                System.out.println("\nInsertado a la derecha...");
            } else {
                ld.insertar(nuevaPersona);
            }
        }
    }

}
