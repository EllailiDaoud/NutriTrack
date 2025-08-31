package ma.ac.esi.nutritrack.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ma.ac.esi.nutritrack.model.Ingredient;
import ma.ac.esi.nutritrack.model.Meal;
import ma.ac.esi.nutritrack.service.MealService;

import java.io.IOException;
import java.util.List;

/**
 * Servlet implementation class MealController
 */
@WebServlet("/MealController")
public class MealController extends HttpServlet {
	MealService mealService = new MealService();
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MealController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Retrieve the list of meals from your service
        List<Meal> meals = mealService.getMeals();
        request.setAttribute("meals", meals);

        // 2. Compute totalMealCalories from the meals (if desired).
        //    This simple example sums all ingredients across all meals:
        int totalMealCalories = 0;
        for (Meal meal : meals) {
            if (meal.getIngredients() != null) {
                for (Ingredient ing : meal.getIngredients()) {
                    totalMealCalories += ing.getCalories();
                }
            }
        }

        // 🔥 Calculate burned calories (Example: 20% of total)
        int burnedCalories = (int) (totalMealCalories * 0.2);  // Adjust percentage as needed

        // 3. Store these values in request attributes
        request.setAttribute("totalMealCalories", totalMealCalories);
        request.setAttribute("burnedCalories", burnedCalories);

        // 4. Forward to the JSP
        request.getRequestDispatcher("meals.jsp").forward(request, response);
    }


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
