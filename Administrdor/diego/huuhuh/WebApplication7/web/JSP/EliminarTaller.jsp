<%-- 
    Document   : EliminarTaller
    Created on : 3 jul 2024, 08:12:56
    Author     : metal
--%><%@page import="java.io.File"%>



<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.io.FileFilter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Eliminar Carpeta</title>
           <link rel="stylesheet" href="../CSS/eliminarTaller.css">
    </head>
    <body>
        <h1>Eliminar Carpeta</h1>

        <%
            String basePath = "D:\\SimposioData\\";
            File baseDir = new File(basePath);
            
            File[] subDirectories = baseDir.listFiles(new FileFilter() {
                @Override
                public boolean accept(File file) {
                    return file.isDirectory();
                }
            });

            List<String> subfolderNames = new ArrayList<>();
            for (File dir : subDirectories) {
                subfolderNames.add(dir.getName());
            }
                //solicitud de eliminar 
            String selectedFolder = request.getParameter("selectedFolder");

            if (selectedFolder != null && !selectedFolder.isEmpty()) {
                String folderPathToDelete = basePath + selectedFolder;

                class FolderDeleter {

                    public boolean deleteFolder(String folderPath) {
                        File folder = new File(folderPath);
                        return deleteFolder(folder);
                    }

                    private boolean deleteFolder(File folder) {
                        if (folder.isDirectory()) {
                            File[] files = folder.listFiles();
                            if (files != null) {
                                for (File file : files) {
                                    deleteFolder(file);
                                }
                            }
                        }
                        return folder.delete();
                    }
                }

                FolderDeleter folderDeleter = new FolderDeleter();
                boolean deletionResult = folderDeleter.deleteFolder(folderPathToDelete);

                if (deletionResult) {
                    out.println("<p>Carpeta " + selectedFolder + " y su contenido eliminados correctamente.</p>");
                } else {
                    out.println("<p>Error al eliminar la carpeta " + selectedFolder + " y su contenido.</p>");
                }
            }
        %>

        <form method="post" action="EliminarTaller.jsp">
            <label for="selectedFolder">Selecciona la carpeta a eliminar:</label>
            <select id="selectedFolder" name="selectedFolder">
                <option value="" selected disabled>Selecciona una carpeta</option>
                <%
                    for (String folderName : subfolderNames) {
                        out.println("<option value=\"" + folderName + "\">" + folderName + "</option>");
                    }
                %>
            </select><br><br>
            <input type="submit" value="Eliminar">
        </form>

    </body>
</html>