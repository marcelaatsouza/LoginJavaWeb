<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="Model.DAO" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
    <title>Excluir Perfil</title>
</head>
<body>
        <%
            String email = request.getParameter("email");
            Connection conn = DAO.getConnection();

            try {
                String sql = "DELETE FROM Usuarios WHERE email = ?";
                try (PreparedStatement statement = conn.prepareStatement(sql)) {
                    statement.setString(1, email);
                    int rowsDeleted = statement.executeUpdate();
                    if (rowsDeleted > 0) {
        %>
            <div class="container-response">
                <h2>Perfil Excluído!</h2>
                <a href="index.html"><button class="btn">Voltar</button></a>
            </div>
        <%
                    } else {
        %>
            <div class="container-response">
                <h2>Erro ao excluir o perfil.</h2>
                <a href="profile.jsp?email=<%= email %>"><button class="btn">Voltar</button></a>
            </div>
        <%
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            } finally {
                conn.close();
            }
        %>
</body>
</html>
