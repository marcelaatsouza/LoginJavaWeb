package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Model.DAO;
import Model.Usuarios;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Cadastro extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        Usuarios usuario = new Usuarios();
        usuario.setNome(request.getParameter("nome"));
        usuario.setSobrenome(request.getParameter("sobrenome"));
        usuario.setEmail(request.getParameter("email"));
        usuario.setSenha(request.getParameter("senha"));

        try ( PrintWriter out = response.getWriter()) {
            if (usuario.getNome().isEmpty() || usuario.getSobrenome().isEmpty() || usuario.getEmail().isEmpty() || usuario.getSenha().isEmpty()) {
                request.setAttribute("response", "Por favor, preencha todos os campos.");
                request.getRequestDispatcher("response.jsp").forward(request, response);
                return;
            }
            try ( Connection conn = DAO.getConnection()) {
                if (conn != null) {

                    String emailExistQuery = "SELECT COUNT(*) FROM Usuarios WHERE email = ?";
                    try ( PreparedStatement emailExistStatement = conn.prepareStatement(emailExistQuery)) {
                        emailExistStatement.setString(1, usuario.getEmail());
                        ResultSet resultSet = emailExistStatement.executeQuery();
                        if (resultSet.next() && resultSet.getInt(1) > 0) {
                            request.setAttribute("response", "O email já está em uso.");
                            request.getRequestDispatcher("response.jsp").forward(request, response);
                            return;
                        }
                    }

                    String sql = "INSERT INTO Usuarios (nome, sobrenome, email, senha) VALUES (?, ?, ?, ?)";
                    try ( PreparedStatement statement = conn.prepareStatement(sql)) {
                        statement.setString(1, usuario.getNome());
                        statement.setString(2, usuario.getSobrenome());
                        statement.setString(3, usuario.getEmail());
                        statement.setString(4, usuario.getSenha());

                        int rowsAffected = statement.executeUpdate();

                        if (rowsAffected > 0) {
                            request.setAttribute("response", "Cadastro Efetuado!");
                            request.getRequestDispatcher("response.jsp").forward(request, response);
                        } else {
                            request.setAttribute("response", "Erro ao cadastrar o usuário.");
                            request.getRequestDispatcher("response.jsp").forward(request, response);
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
