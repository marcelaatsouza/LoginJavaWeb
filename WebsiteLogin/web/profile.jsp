<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="Model.DAO" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
    <title>Perfil</title>
</head>
<body>
            <% 
                String email = request.getParameter("email");
                Connection conn = DAO.getConnection();
                String nome = "";
                String sobrenome = "";
                String senha = "";
                
                try {
                    String sql = "SELECT nome, sobrenome, senha FROM Usuarios WHERE email = ?";
                    try (PreparedStatement statement = conn.prepareStatement(sql)) {
                        statement.setString(1, email);
                        ResultSet resultSet=statement.executeQuery();
                        if (resultSet.next()) {
                            nome = resultSet.getString("nome");
                            sobrenome = resultSet.getString("sobrenome");
                            senha = resultSet.getString("senha");
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                } finally {
                    conn.close();
                }
            %>
    <div class="container-profile">
        <div class="profile-box">
            <div class="profile-top">
                <i class="bi bi-person-circle"></i>
                <h2><%= nome %> <%= sobrenome %></h2>
                <p><%= email %></p>
    
                <div class="social-icons">
                    <a href="#"><i class="bi bi-linkedin"></i></a>
                    <a href="#"><i class="bi bi-github"></i></a>
                    <a href="#"><i class="bi bi-twitter"></i></a>
                </div>
            </div>

            <div class="profile-bottom">
                <div class="container-btn">
                    <a href="edit-user.jsp?email=<%= email %>"><button class="btn-profile">Editar Perfil</button></a>
                    <a href="index.html"><button class="btn-profile">Sair</button></a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>