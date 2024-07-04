<%-- 
    Document   : modificar
    Created on : 3 jul 2024, 08:13:32
    Author     : metal
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.nio.file.Files" %>
<%@ page import="java.nio.file.Paths" %>
<%@ page import="java.util.logging.Logger" %>
<!DOCTYPE html>  
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Modificar Carpeta</title>
        <link rel="stylesheet" href="../CSS/modificar.css">
    </head>
    <body>
        <div class="container">
            <h1>Modificar Carpeta</h1>
            <form action="modificar.jsp" method="post">
                <label for="carpeta">Seleccione una carpeta:</label>
                <select name="carpeta" id="carpeta" required>
                    <option value="">Seleccione una carpeta</option>
                    <%-- Java code to populate the dropdown with folders --%>
                    <%
                        String baseDir = "D:\\SimposioData\\";
                        File baseFolder = new File(baseDir);
                        if (baseFolder.exists() && baseFolder.isDirectory()) {
                            for (File folder : baseFolder.listFiles()) {
                                if (folder.isDirectory()) {
                                    out.println("<option value='" + folder.getAbsolutePath() + "'>" + folder.getName() + "</option>");
                                }
                            }
                        }
                    %>
                </select><br><br>
                <label for="nuevoNombre">Nuevo nombre para la carpeta:</label>
                <input type="text" id="nuevoNombre" name="nuevoNombre" required><br><br>
                <input type="submit" value="Modificar">
            </form>

            <%-- Java code to handle directory renaming --%>
            <%
                Logger logger = Logger.getLogger("ModificarCarpeta");

                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    String folderPath = request.getParameter("carpeta");
                    String nuevoNombre = request.getParameter("nuevoNombre").trim(); // Remove leading and trailing spaces

                    if (folderPath != null && !folderPath.isEmpty()) {
                        File folder = new File(folderPath);

                        // Log folder path
                        logger.info("Ruta completa de la carpeta: " + folder.getAbsolutePath());

                        if (folder.exists() && folder.isDirectory()) {
                            // Create new File object for the renamed folder
                            File newFolder = new File(folder.getParent() + File.separator + nuevoNombre);

                            try {
                                // Rename the folder using Files.move()
                                Files.move(Paths.get(folder.getAbsolutePath()), Paths.get(newFolder.getAbsolutePath()));
                                // Success message
%>
            <p>La carpeta <%= folder.getName()%> ha sido renombrada a <%= nuevoNombre%> con éxito.</p>
            <%
            } catch (IOException e) {
                // Error message if renaming fails
%>
            <p>No se pudo renombrar la carpeta <%= folder.getName()%>. Verifique los permisos o inténtelo nuevamente.</p>
            <%
                    logger.severe("Error al renombrar carpeta: " + e.getMessage());
                    e.printStackTrace();
                }
            } else {
            %>
            <p>No se encontró la carpeta <%= folderPath%>. Verifique que la carpeta exista.</p>
            <%
                }
            } else {
            %>
            <p>Seleccione una carpeta para modificar.</p>
            <%
                    }
                }
            %>
        </div>
    </body>
</html>
