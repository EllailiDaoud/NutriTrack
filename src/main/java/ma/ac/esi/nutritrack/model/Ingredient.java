package ma.ac.esi.nutritrack.model;

public class Ingredient {
    private int ingredientId;
    private String name;
    private int calories;

    // ✅ Add this constructor to fix the issue
    public Ingredient(String name, int calories) {
        this.name = name;
        this.calories = calories;
    }

    // ✅ Ensure you also have this constructor if needed
    public Ingredient(int ingredientId, String name, int calories) {
        this.ingredientId = ingredientId;
        this.name = name;
        this.calories = calories;
    }

    // Getters and Setters
    public int getIngredientId() { return ingredientId; }
    public void setIngredientId(int ingredientId) { this.ingredientId = ingredientId; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public int getCalories() { return calories; }
    public void setCalories(int calories) { this.calories = calories; }
}
