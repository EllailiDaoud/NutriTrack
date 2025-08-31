package ma.ac.esi.nutritrack.service;

import ma.ac.esi.nutritrack.model.Ingredient;
import ma.ac.esi.nutritrack.repository.IngredientRepository;

public class IngredientService {

    private IngredientRepository ingredientRepository;

    public IngredientService() {
        this.ingredientRepository = new IngredientRepository();
    }

    public boolean addIngredientToMeal(int mealId, String name, int calories) {
        Ingredient ingredient = new Ingredient(name, calories);
        return ingredientRepository.addIngredientToMeal(mealId, ingredient);
    }
    
    // 📝 Update Ingredient
    public boolean updateIngredient(int ingredientId, String name, int calories) {
        return ingredientRepository.updateIngredient(ingredientId, name, calories);
    }

    // ❌ Delete Ingredient
    public boolean deleteIngredient(int ingredientId) {
        return ingredientRepository.deleteIngredient(ingredientId);
    }
}


