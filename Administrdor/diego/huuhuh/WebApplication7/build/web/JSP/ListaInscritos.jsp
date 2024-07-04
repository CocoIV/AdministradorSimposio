<%-- 
    Document   : ListaInscritos
    Created on : 3 jul 2024, 08:13:17
    Author     : metal
--%>

<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lista de Inscritos</title>
        <link rel="stylesheet" href="../CSS/lista.css">
    </head>
    <body>
        <div class="container">
            <h1>Lista de Documentos</h1>
            <form method="post" action="ListaInscritos.jsp">
                <label for="folder">Seleccione una carpeta:</label>
                <select name="folder" id="folder" onchange="this.form.submit()">
                    <option value="">Seleccione una carpeta</option>
                    <%
                        // Directorio base
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
            %>
            <h2>Documentos en la carpeta <%= selectedFolder%>:</h2>
            <ul>
                <%
                    for (File file : folder.listFiles()) {
                        if (file.isFile() && file.getName().endsWith(".txt")) {
                            out.println("<li>" + file.getName() + "</li>");
                            BufferedReader reader = null;
                            try {
                                reader = new BufferedReader(new FileReader(file));
                                String line;
                                while ((line = reader.readLine()) != null) {
                                    out.println("<p>" + line + "</p>");
                                }
                            } catch (IOException e) {
                                e.printStackTrace();
                            } finally {
                                if (reader != null) {
                                    try {
                                        reader.close();
                                    } catch (IOException e) {
                                        e.printStackTrace();
                                    }
                                }
                            }
                        }
                    }
                %>
            </ul>
            <%
                    }
                }
            %>
        </div>
    </body>
</html>
