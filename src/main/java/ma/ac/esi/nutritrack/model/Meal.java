package ma.ac.esi.nutritrack.model;

import ma.ac.esi.nutritrack.model.Ingredient;
import java.util.List;
public class Meal {
	private int mealId;
	private String name;
	private List<Ingredient> ingredients;
	
	
	public void setName(String name)
	{
		this.name=name;
	}
	
	public int getMealId() {
		return mealId;
	}

	public void setMealId(int mealId) {
		this.mealId = mealId;
	}

	public String getName()
	{
		return name ;
	}
	/*
	void addIngredient(Ingredient i)
	{
		this.ingredients.add(i);
	}
	
	void removeIngredient(Ingredient i)
	{
		this.ingredients.remove(i);
	}
	*/
	public List<Ingredient> getIngredients() {
		return ingredients;
	}

	public void setIngredients(List<Ingredient> ingredients) {
		this.ingredients = ingredients;
	}

	public Meal(int mealId, String name,List<Ingredient> ingredients)
	{
		this.mealId=mealId;
		this.name  = name;
		this.ingredients=ingredients;
	}
}
