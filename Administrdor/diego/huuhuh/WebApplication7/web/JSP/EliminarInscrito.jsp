<%-- 
    Document   : EliminarInscrito
    Created on : 3 jul 2024, 08:12:34
    Author     : metal
--%>


<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Eliminar Contenido de Archivos</title>
        <link rel="stylesheet" href="../CSS/eliminarInscrito.css">
    </head>
    <body>
        <div class="container">
            <div class="main-content">
                <h1>Eliminar Inscrito</h1>
                <form method="post" action="EliminarInscrito.jsp">
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
                                        out.println("<option value='" + folder.getName() + "' " + selected + ">" + folder.getName() + "</option>");
                                    }
                                }
                            }
                        %>
                    </select>
                </form>
                <%
                    String selectedFolder = request.getParameter("folder");
                    if (selectedFolder != null && !selectedFolder.isEmpty()) {
                        File folder = new File(baseDir + selectedFolder);
                        if (folder.exists() && folder.isDirectory()) {
                            out.println("<form method='post' action='EliminarInscrito.jsp'>");
                            out.println("<input type='hidden' name='folder' value='" + selectedFolder + "' />");
                            out.println("<label for='file'>Seleccione un archivo:</label>");
                            out.println("<select name='file' id='file' onchange='this.form.submit()'>");
                            out.println("<option value=''>Seleccione un archivo</option>");
                            for (File file : folder.listFiles()) {
                                if (file.isFile() && file.getName().endsWith(".txt")) {
                                    String selected = request.getParameter("file") != null && request.getParameter("file").equals(file.getName()) ? "selected" : "";
                                    out.println("<option value='" + file.getName() + "' " + selected + ">" + file.getName() + "</option>");
                                }
                            }
                            out.println("</select>");
                            out.println("</form>");
                        }
                    }

                    String selectedFile = request.getParameter("file");
                    if (selectedFile != null && !selectedFile.isEmpty()) {
                        File file = new File(baseDir + selectedFolder + "\\" + selectedFile);
                        if (file.exists() && file.isFile()) {
                            List<String> lines = new ArrayList<>();
                            try ( BufferedReader reader = new BufferedReader(new FileReader(file))) {
                                String line;
                                while ((line = reader.readLine()) != null) {
                                    lines.add(line);
                                }
                            } catch (IOException e) {
                                e.printStackTrace();
                            }

                            if ("deleteLines".equals(request.getParameter("action"))) {
                                String[] linesToDelete = request.getParameterValues("linesToDelete");
                                if (linesToDelete != null && linesToDelete.length > 0) {
                                    List<Integer> indicesToDelete = new ArrayList<>();
                                    for (String lineIndex : linesToDelete) {
                                        indicesToDelete.add(Integer.parseInt(lineIndex));
                                    }

                                    List<String> deletedNames = new ArrayList<>();
                                    List<String> updatedLines = new ArrayList<>();
                                    for (int i = 0; i < lines.size(); i++) {
                                        if (indicesToDelete.contains(i)) {
                                            deletedNames.add(lines.get(i));
                                        } else {
                                            updatedLines.add(lines.get(i));
                                        }
                                    }

                                    try ( BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
                                        for (String updatedLine : updatedLines) {
                                            writer.write(updatedLine);
                                            writer.newLine();
                                        }
                                    } catch (IOException e) {
                                        e.printStackTrace();
                                    }

                                    // Mostrar los resultados actualizados
                                    out.println("<div class='container'>");

                                    out.println("<div class='side-content deleted-lines'>");
                                    out.println("<div class='box-header'>");
                                    out.println("<h2>Nombres Eliminados:</h2>");
                                    out.println("</div>");
                                    out.println("<ul>");
                                    for (String deletedName : deletedNames) {
                                        out.println("<li>" + deletedName + "</li>");
                                    }
                                    out.println("</ul>");
                                    out.println("</div>");

                                    out.println("<div class='space-between'></div>");

                                    out.println("<div class='side-content updated-list'>");
                                    out.println("<div class='box-header'>");
                                    out.println("<h2>Lista Actualizada:</h2>");
                                    out.println("</div>");
                                    out.println("<ul>");
                                    for (String updatedName : updatedLines) {
                                        out.println("<li>" + updatedName + "</li>");
                                    }
                                    out.println("</ul>");
                                    out.println("</div>");

                                    out.println("</div>");
                                } else {
                                    out.println("<form method='post' action='EliminarInscrito.jsp'>");
                                    out.println("<input type='hidden' name='folder' value='" + selectedFolder + "' />");
                                    out.println("<input type='hidden' name='file' value='" + selectedFile + "' />");
                                    out.println("<h2>Contenido del archivo " + selectedFile + ":</h2>");
                                    out.println("<ul class='file-content'>");
                                    for (int i = 0; i < lines.size(); i++) {
                                        out.println("<li><input type='checkbox' name='linesToDelete' value='" + i + "' /> " + lines.get(i) + "</li>");
                                    }
                                    out.println("</ul>");
                                    out.println("<button type='submit' name='action' value='deleteLines'>Eliminar Líneas Seleccionadas</button>");
                                    out.println("</form>");
                                }
                            } else {
                                out.println("<form method='post' action='EliminarInscrito.jsp'>");
                                out.println("<input type='hidden' name='folder' value='" + selectedFolder + "' />");
                                out.println("<input type='hidden' name='file' value='" + selectedFile + "' />");
                                out.println("<h2>Contenido del archivo " + selectedFile + ":</h2>");
                                out.println("<ul class='file-content'>");
                                for (int i = 0; i < lines.size(); i++) {
                                    out.println("<li><input type='checkbox' name='linesToDelete' value='" + i + "' /> " + lines.get(i) + "</li>");
                                }
                                out.println("</ul>");
                                out.println("<button type='submit' name='action' value='deleteLines'>Eliminar Líneas Seleccionadas</button>");
                                out.println("</form>");
                            }
                        }
                    }
                %>
            </div>
        </div>
    </body>
</html>
