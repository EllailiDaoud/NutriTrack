package ma.ac.esi.nutritrack.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ma.ac.esi.nutritrack.service.IngredientService;

import java.io.IOException;

/**
 * Servlet implementation class IngredientController
 */
@WebServlet("/IngredientController")
public class IngredientController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IngredientService ingredientService;

    @Override
    public void init() {
        ingredientService = new IngredientService();
    }
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IngredientController() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String action = request.getParameter("action");

            if (action == null || action.isEmpty()) {
                // 🛑 Add Ingredient Validation
                int mealId = Integer.parseInt(request.getParameter("mealId"));
                String name = request.getParameter("name");
                int calories = Integer.parseInt(request.getParameter("calories"));

                if (name == null || name.trim().isEmpty() || name.length() < 2 || calories <= 0) {
                    request.setAttribute("error", "Nom invalide ou calories négatives !");
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                    return;
                }

                boolean isAdded = ingredientService.addIngredientToMeal(mealId, name.trim(), calories);

                if (isAdded) {
                    response.sendRedirect(request.getContextPath() + "/MealController");
                } else {
                    response.sendRedirect("error.jsp");
                }
            } 
            // 📝 Update Ingredient Validation
            else if ("update".equals(action)) {
                int ingredientId = Integer.parseInt(request.getParameter("ingredientId"));
                String name = request.getParameter("name");
                int calories = Integer.parseInt(request.getParameter("calories"));

                if (name == null || name.trim().isEmpty() || name.length() < 2 || calories <= 0) {
                    request.setAttribute("error", "Nom invalide ou calories négatives !");
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                    return;
                }

                ingredientService.updateIngredient(ingredientId, name.trim(), calories);
                response.sendRedirect(request.getContextPath() + "/MealController");
            } 
            // ❌ Delete Ingredient
            else if ("delete".equals(action)) {
                int ingredientId = Integer.parseInt(request.getParameter("ingredientId"));
                ingredientService.deleteIngredient(ingredientId);
                response.sendRedirect(request.getContextPath() + "/MealController");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("error", "Valeur invalide !");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }


}
