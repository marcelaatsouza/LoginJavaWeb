<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="Model.DAO" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
    <title>Editar Perfil</title>
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
                            ResultSet resultSet = statement.executeQuery();
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
             
                
                <div class="container-edit">
                    <div class="log-box">
                        <div class="form-box">
                            <form method="post" action="update-user.jsp">
                                <h2>Editar Perfil</h2>

                                <div class="input-box">
                                    <span class="icon"><i class="bi bi-person-fill"></i></span>
                                    <input type="text" name="nome" value="<%= nome %>">
                                </div>

                                <div class="input-box">
                                    <span class="icon"><i class="bi bi-person-lines-fill"></i></span>
                                    <input type="text" name="sobrenome" value="<%= sobrenome %>">
                                </div>

                                <div class="input-box">
                                    <span class="icon"><i class="bi bi-envelope-fill"></i></span>
                                    <input type="email" name="email" value="<%= email %>">
                                </div>

                                <div class="input-box">
                                    <span class="icon"><i class="bi bi-lock-fill"></i></span>
                                    <input type="password" name="senha" value="<%= senha %>">
                                </div>

                                <button type="submit" class="btn">Editar</button>

                                <div class="links">
                                    <a class="back-profile" href="profile.jsp?email=<%= email %>">Voltar ao Perfil</a>
                                    <a class="delete-profile" href="delete-user.jsp?email=<%= email %>">Excluir Perfil</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
</body>
</html>
