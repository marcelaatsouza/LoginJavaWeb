package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Model.Usuarios;
import Model.DAO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Login extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
       
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");        
        
        try ( PrintWriter out = response.getWriter()) {
            
            Connection conn = DAO.getConnection();
            
            if (conn != null) {
                try {
                    String sql = "SELECT * FROM Usuarios WHERE email = ? AND senha = ?";
                    try ( PreparedStatement statement = conn.prepareStatement(sql)) {
                        statement.setString(1, email);
                        statement.setString(2, senha);

                        ResultSet resultSet = statement.executeQuery();
                        if (resultSet.next()) {
                            response.sendRedirect("profile.jsp?email=" + email);
                        } else {
                            request.setAttribute("response", "Não foi possível efetuar o login. Verifique os campos e-mail e senha.");
                            request.getRequestDispatcher("response.jsp").forward(request, response);
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } finally {
                        conn.close();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
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
