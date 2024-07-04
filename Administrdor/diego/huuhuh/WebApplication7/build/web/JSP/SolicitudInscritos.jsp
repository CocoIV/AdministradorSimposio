<%-- 
    Document   : SolicitudInscritos
    Created on : 3 jul. 2024, 23:01:23
    Author     : Julieth
--%>

<%@page import="java.io.FileReader"%>
<%@page import="java.util.List"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Solicitud de Inscritos</title>
        <link rel="stylesheet" href="../CSS/SolicitudInscritos.css">
    </head>
    <body>
        <h1>Usuarios Registrados</h1>
        <form method="post">
            <table border="1">
                <tr>
                    <th>Nombre</th>
                    <th>Email</th>
                    <th>Contraseña</th>
                    <th>Aceptar</th>
                </tr>
                <%
                    String Maldades = "123456789ABCDEFGHIJKMNÑOPQRSTUVWXYZ";
                    String rutaArchivo = "D:\\SimposioData\\UsuariosRegistrados.txt";
                    String rutaAceptados = "D:\\SimposioData\\aceptados.txt";

                    List<String[]> usuarios = new ArrayList<>();

                    // Leer y decodificar el archivo
                    try ( BufferedReader reader = new BufferedReader(new FileReader(rutaArchivo))) {
                        String line;
                        while ((line = reader.readLine()) != null) {
                            String[] datosArchivo = line.split(",");
                            if (datosArchivo.length >= 3) {
                                String nombre = Utilidades.descodificar(Maldades, datosArchivo[0]);
                                String email = Utilidades.descodificar(Maldades, datosArchivo[1]);
                                String contraseña = Utilidades.descodificar(Maldades, datosArchivo[2]);
                                usuarios.add(new String[]{nombre, email, contraseña});
                            }
                        }
                    } catch (IOException e) {
                        out.println("<p>Error al leer el archivo: " + e.getMessage() + "</p>");
                    }

                    for (String[] usuario : usuarios) {
                        out.println("<tr>");
                        out.println("<td>" + usuario[0] + "</td>");
                        out.println("<td>" + usuario[1] + "</td>");
                        out.println("<td>" + usuario[2] + "</td>");
                        out.println("<td><input type='checkbox' name='aceptar' value='" + usuario[1] + "'></td>");
                        out.println("</tr>");
                    }
                %>
            </table>
            <input type="submit" value="Aceptar Usuarios">
        </form>

        <%
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String[] aceptados = request.getParameterValues("aceptar");

                if (aceptados != null) {
                    try ( BufferedWriter writer = new BufferedWriter(new FileWriter(rutaAceptados, true))) {
                        for (String email : aceptados) {
                            for (String[] usuario : usuarios) {
                                if (usuario[1].equals(email)) {
                                    writer.write(Utilidades.codificar(Maldades, usuario[0]) + "," + Utilidades.codificar(Maldades, usuario[1]) + "," + Utilidades.codificar(Maldades, usuario[2]));
                                    writer.newLine();
                                }
                            }
                        }
                        out.println("<p>Usuarios aceptados con éxito</p>");
                    } catch (IOException e) {
                        out.println("<p>Error al escribir en el archivo de aceptados: " + e.getMessage() + "</p>");
                    }
                }
            }
        %>
    </body>
</html>

<%!
    public static class Utilidades {

        public static String codificar(String Maldades, String dato) {
            StringBuilder textoCodificado = new StringBuilder();
            for (int i = 0; i < dato.length(); i++) {
                char caracter = dato.charAt(i);
                int pos = Maldades.indexOf(caracter);
                if (pos == -1) {
                    textoCodificado.append(caracter);
                } else {
                    textoCodificado.append(Maldades.charAt((pos + 5) % Maldades.length()));
                }
            }
            return textoCodificado.toString();
        }

        public static String descodificar(String Maldades, String datoCodificado) {
            StringBuilder textoDescodificado = new StringBuilder();
            for (int i = 0; i < datoCodificado.length(); i++) {
                char caracter = datoCodificado.charAt(i);
                int pos = Maldades.indexOf(caracter);
                if (pos == -1) {
                    textoDescodificado.append(caracter);
                } else {
                    textoDescodificado.append(Maldades.charAt((pos - 5 + Maldades.length()) % Maldades.length()));
                }
            }
            return textoDescodificado.toString();
        }
    }
%>