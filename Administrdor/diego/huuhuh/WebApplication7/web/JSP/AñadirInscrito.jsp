<%-- 
    Document   : AñadirInscrito
    Created on : 3 jul 2024, 08:11:49
    Author     : metal
--%>

<%@page import="java.io.FileWriter"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.BufferedReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Añadir Información a Archivos</title>
        <link rel="stylesheet" href="../CSS/añadirInscrito.css">
    </head>
    <body>
        <div class="container">
            <div class="form-container">
                <h1>Añadir Información a Archivos</h1>

                <!-- Formulario para seleccionar carpeta y archivo -->
                <form method="post" action="AñadirInscrito.jsp">
                    <label for="folder">Seleccione una carpeta:</label>
                    <select name="folder" id="folder" onchange="this.form.submit()">
                        <option value="">Seleccione una carpeta</option>
                        <%
                            String baseDir = "D:\\SimposioData\\";
                            File baseFolder = new File(baseDir);
                            if (baseFolder.exists() && baseFolder.isDirectory()) {
                                for (File folder : baseFolder.listFiles()) {
                                    if (folder.isDirectory()) {
                                        String selected = request.getParameter("folder") != null && request.getParameter("folder").equals(folder.getName()) ? "selected" : "";
                        %>
                        <option value='<%= folder.getName()%>' <%= selected%>><%= folder.getName()%></option>
                        <%
                                    }
                                }
                            }
                        %>
                    </select>

                    <%-- Selección de archivo dentro de la carpeta seleccionada --%>
                    <%
                        String selectedFolder = request.getParameter("folder");
                        if (selectedFolder != null && !selectedFolder.isEmpty()) {
                            File folder = new File(baseDir + selectedFolder);
                            if (folder.exists() && folder.isDirectory()) {
                    %>
                    <br><br>
                    <label for='file'>Seleccione un archivo:</label>
                    <select name='file' id='file'>
                        <option value="">Seleccione un archivo</option>
                        <%
                            for (File file : folder.listFiles()) {
                                if (file.isFile() && file.getName().endsWith(".txt")) {
                                    String selected = "";
                                    if (request.getParameter("file") != null && request.getParameter("file").equals(file.getName())) {
                                        selected = "selected";
                                    }
                        %>
                        <option value='<%= file.getName()%>' <%= selected%>><%= file.getName()%></option>
                        <%
                                }
                            }
                        %>
                    </select>
                    <%
                            }
                        }
                    %>

                    <%-- Campos para añadir información --%>
                    <div class="form-group">
                        <input type="text" id="name" name="name" placeholder="Nombre">
                        <span id="name-error" class="error-message">Este campo es obligatorio.</span>
                    </div>
                    <div class="form-group">
                        <input type="email" id="email" name="email" placeholder="Correo electrónico">
                        <span id="email-error" class="error-message">Este campo es obligatorio.</span>
                    </div>
                    <div class="form-group">
                        <input type="password" id="password" name="password" placeholder="Contraseña">
                        <span id="password-error" class="error-message">Este campo es obligatorio.</span>
                    </div>
                    <div class="form-group">
                        <input type="text" id="numeroID" name="numeroID" placeholder="Número de Identificación">
                        <span id="numeroID-error" class="error-message">Este campo es obligatorio.</span>
                    </div>
                    <div class="form-group">
                        <input type="text" id="InstitucionEducativa" name="InstitucionEducativa" placeholder="Institución Educativa">
                        <span id="InstitucionEducativa-error" class="error-message">Este campo es obligatorio.</span>
                    </div>
                    <div class="form-group">
                        <input type="text" id="AreadeInteres" name="AreadeInteres" placeholder="Área de Interés">
                        <span id="AreadeInteres-error" class="error-message">Este campo es obligatorio.</span>
                    </div>
                    <div class="form-group">
                        <select id="TipoDeUsuario" name="TipoDeUsuario">
                            <option value="" disabled selected>Selecciona el tipo de usuario</option>
                            <option value="Estudiante">Estudiante</option>
                            <option value="Profesor">Profesor</option>
                            <option value="Asistente">Asistente</option>
                            <option value="Ponente">Ponente</option>
                            <option value="Empresa">Empresa</option>
                        </select>
                        <span id="TipoDeUsuario-error" class="error-message">Este campo es obligatorio.</span>
                    </div>

                    <%-- Botón para guardar información --%>
                    <button type='submit' name='saveInformation' value='saveInformation'>Guardar Información</button>
                </form>

                <%-- Procesamiento para guardar la información en el archivo seleccionado --%>
                <%
                    if ("saveInformation".equals(request.getParameter("saveInformation"))) {
                        String folderName = request.getParameter("folder");
                        String fileName = request.getParameter("file");
                        String name = request.getParameter("name");
                        String email = request.getParameter("email");
                        String password = request.getParameter("password");
                        String numeroID = request.getParameter("numeroID");
                        String institucion = request.getParameter("InstitucionEducativa");
                        String areaInteres = request.getParameter("AreadeInteres");
                        String tipoUsuario = request.getParameter("TipoDeUsuario");

                        if (folderName != null && fileName != null) {
                            File file = new File(baseDir + folderName + "\\" + fileName);
                            if (file.exists() && file.isFile()) {
                                try ( BufferedWriter writer = new BufferedWriter(new FileWriter(file, true))) {
                                    // Escribir los datos con formato CSV (separados por comas)
                                    writer.write(name + ",");
                                    writer.write(email + ",");
                                    writer.write(password + ",");
                                    writer.write(numeroID + ",");
                                    writer.write(institucion + ",");
                                    writer.write(areaInteres + ",");
                                    writer.write(tipoUsuario);
                                    writer.newLine();
                                } catch (IOException e) {
                                    e.printStackTrace();
                                }
                %>
                <p class='success'>Información guardada en el archivo <%= fileName%> en la carpeta <%= folderName%>.</p>
                <%
                } else {
                %>
                <p class='error'>Archivo no encontrado.</p>
                <%
                            }
                        }
                    }
                %>

                <%-- Mostrar contenido del archivo seleccionado --%>
                <%
                    String selectedFile = request.getParameter("file");
                    if (selectedFolder != null && selectedFile != null) {
                        File fileToShow = new File(baseDir + selectedFolder + "\\" + selectedFile);
                        if (fileToShow.exists() && fileToShow.isFile()) {
                %>
                <div class='file-content'>
                    <h2>Contenido del archivo <%= selectedFile%> en la carpeta <%= selectedFolder%></h2>
                    <pre>
                        <%
                            try ( BufferedReader reader = new BufferedReader(new FileReader(fileToShow))) {
                                String line;
                                while ((line = reader.readLine()) != null) {
                                    out.println(line);
                                }
                            } catch (IOException e) {
                                e.printStackTrace();
                            }
                        %>
                    </pre>
                </div>
                <%
                        }
                    }
                %>
            </div>
        </div>
    </body>
</html>

