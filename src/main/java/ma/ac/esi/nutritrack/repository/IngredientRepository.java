package ma.ac.esi.nutritrack.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import ma.ac.esi.nutritrack.model.Ingredient;
import ma.ac.esi.nutritrack.util.DBUtil;

public class IngredientRepository {

    public boolean addIngredientToMeal(int mealId, Ingredient ingredient) {
        String sql = "INSERT INTO ingredients (meal_id, name, calories) VALUES (?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, mealId);// -----------0 or 1--------------
            stmt.setString(2, ingredient.getName());
            stmt.setInt(3, ingredient.getCalories());

            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean updateIngredient(int ingredientId, String name, int calories) {
        String sql = "UPDATE ingredients SET name = ?, calories = ? WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, name);
            stmt.setInt(2, calories);
            stmt.setInt(3, ingredientId);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteIngredient(int ingredientId) {
        String sql = "DELETE FROM ingredients WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, ingredientId);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
