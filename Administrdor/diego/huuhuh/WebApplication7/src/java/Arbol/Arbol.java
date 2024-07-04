/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Arbol;

import java.util.ArrayList;

/**
 *
 * @author Pablo
 */
public class Arbol {

    private NodoArbol nodoar;

    public Arbol() {
        nodoar = null;
    }



    public NodoArbol retornaraiz() {
        return nodoar;
    }

    public synchronized void insertarNodo(Persona nuevaPersona) {
        if (nodoar == null) {
            nodoar = new NodoArbol(nuevaPersona);
            System.out.println("\nInsertado en la Raiz...");
        } else {
            nodoar.insertar(nuevaPersona);
        }
    }

    /**
     * Fragmento tomado del proyecto algoritmos compartido por usted Master
     *
     * @param raiz
     */
    public synchronized void getInOrden(NodoArbol raiz) {
        if (raiz != null) {
            getInOrden(raiz.li); // Visita en Orden árbol izquierdo
            System.out.print(" " + raiz.persona.getNombreTaller()); // Visita nodo
            getInOrden(raiz.ld); // Visita EnOrden árbol derecho
        }
    }

    public synchronized void getPreOrden(NodoArbol raiz) {
        if (raiz != null) {
            System.out.print(" " + raiz.persona.getNombreTaller()); // Visita nodo
            getPreOrden(raiz.li); // Visita en Orden árbol izquierdo
            getPreOrden(raiz.ld); // Visita EnOrden árbol derecho
        }
    }

    public synchronized void getPostOrden(NodoArbol raiz) {
        if (raiz != null) {
            getPostOrden(raiz.li); // Visita en Orden árbol izquierdo
            getPostOrden(raiz.ld); // Visita EnOrden árbol derecho
            System.out.print(" " + raiz.persona.getNombreTaller()); // Visita nodo
        }
    }

    /**
     * metodo para elimnar datos en un arbol
     *
     * @param cedula recibe de parametro la cedula Video del codigo:
     * https://youtu.be/Q_0h4iALDfY?si=GoEnLzguSXEjT1pE modificado por el manudo
     * mayor
     */
//    public synchronized void eliminar(String cedula) {
//        nodoar = eliminarN(nodoar, cedula);
//    }

//    public NodoArbol eliminarN(NodoArbol aux, String cedula) {
//        if (aux == null) {
//            System.out.println("Nodo no encontrado");
//        } else if (cedula < aux.persona.getNombreTaller()) {
//            NodoArbol iz = eliminarN(aux.li, cedula);
//            aux.li = iz;
//        } else if (cedula > aux.persona.getNombreTaller()) {
//            System.out.println("cedula " + cedula);
//            NodoArbol der = eliminarN(aux.ld, cedula);
//            aux.ld = der;
//        } else {
//            NodoArbol p = aux;
//            if (p.ld == null) {
//                aux = p.li;
//            } else if (p.li == null) {
//                aux = p.ld;
//            } else {
//                p = cambiar(p);
//            }
//            p = null;
//        }
//        return aux;
//    }
//
//    protected NodoArbol cambiar(NodoArbol aux) {
//        NodoArbol p = aux;
//        NodoArbol a = aux.li;
//        while (a.ld != null) {
//            p = a;
//            a = a.ld;
//        }
//        aux.persona = a.persona;
//        if (p == aux) {
//            p.li = a.li;
//        } else {
//            p.ld = a.li;
//        }
//        return a;
//    }

    public void editarDato(String viejoTaller, String nuevoTaller) {
        nodoar = editar(nodoar, viejoTaller, nuevoTaller);
    }

    private NodoArbol editar(NodoArbol nodo, String viejoTaller,String nuevoTaller) {
        if (nodo == null) {
            System.out.println("Nuevo dato insertado en el árbol.");
            return new NodoArbol(new Persona(nuevoTaller));
        }
        if (viejoTaller.equals(nodo.persona.getNombreTaller())) {
            nodo.persona.setNombreTaller(nuevoTaller);
            System.out.println("Dato editado correctamente.");
        } else if (viejoTaller.compareTo(nuevoTaller) == 0) {
            nodo.li = editar(nodo.li, viejoTaller, nuevoTaller);
        } else {
            nodo.ld = editar(nodo.ld, viejoTaller, nuevoTaller);
        }

        return nodo;
    }

}