/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utilidades;

/**
 *
 * @author usuario
 */
import Arbol.Arbol;
import Arbol.Persona;
import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;



/**
 *
 * @author pablonoguera
 */
public class Archivo {
    
    public boolean guardarUsuario(String nombre, String profesor, String aula, String cupoMAXI) {
        String rutaArchivo = "C:\\Users\\usuario\\OneDrive\\Documentos\\NetBeansProjects\\WebApplication7\\test\\Datos.txt";


        try {
            BufferedWriter writer = new BufferedWriter(new FileWriter(rutaArchivo, true));

            writer.write(nombre + "," + profesor + "," + aula + "," + cupoMAXI);
            writer.newLine();
            writer.newLine();

            writer.close();

            System.out.println("Usuario guardado correctamente en el archivo.");
            return true;
        } catch (IOException e) {
            System.out.println("Error al guardar el usuario: " + e.getMessage());
            return false;
        }
    }
    
    
    public static Arbol cargarDatos(){
        Arbol arbol =new Arbol();
        FileInputStream inputStream =null;
        Scanner sc = null;
        try{
            inputStream = new FileInputStream("C:\\Users\\usuario\\OneDrive\\Documentos\\NetBeansProjects\\WebApplication7\\test\\Datos.txt");
            sc =new Scanner(inputStream, "UTF-8");
            while(sc.hasNextLine()){
                String[] datos = sc.nextLine().split(",");
                
                Persona nuevaPersona=new Persona(datos[0]);
                arbol.insertarNodo(nuevaPersona);
                
                
            }
            if(sc.ioException() != null){
                throw sc.ioException();
            }
            
        } catch (FileNotFoundException ex) {
            Logger.getLogger(Archivo.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(Archivo.class.getName()).log(Level.SEVERE, null, ex);
        }finally{
            if(inputStream != null){
                try{
                    inputStream.close();
                } catch (IOException ex) {
                    Logger.getLogger(Archivo.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if(sc != null){
                sc.close();
            }
        }
        return arbol;
        
    }
    
}
