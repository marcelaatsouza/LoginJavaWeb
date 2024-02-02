<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="Model.DAO" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
    <title>Atualizar Perfil</title>
</head>
<body>
    <%
        String email = request.getParameter("email");
        String nome = request.getParameter("nome");
        String senha = request.getParameter("senha");
        String sobrenome = request.getParameter("sobrenome");
        Connection conn = DAO.getConnection();

        try {
            String sql = "UPDATE Usuarios SET nome = ?, sobrenome = ?, email = ?, senha = ? WHERE email = ?";
            try (PreparedStatement statement = conn.prepareStatement(sql)) {
                    statement.setString(1, nome);
                    statement.setString(2, sobrenome);
                    statement.setString(3, email);
                    statement.setString(4, senha);
                    statement.setString(5, email);
                int rowsUpdated = statement.executeUpdate();
                if (rowsUpdated > 0) {
    %>                        
                    <div class="container-response">
                        <h2>Perfil Atualizado!</h2>
                        <a href="profile.jsp?email=<%= email %>"><button class="btn">Voltar</button></a>
                    </div>
    <%
                } else {
    %>                     
                    <div class="container-response">
                        <h2>Erro ao atualizar o perfil.</h2>
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
