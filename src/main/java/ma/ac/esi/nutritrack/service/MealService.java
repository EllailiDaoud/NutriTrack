package ma.ac.esi.nutritrack.service;

import java.util.List;

import ma.ac.esi.nutritrack.model.Meal;
import ma.ac.esi.nutritrack.repository.MealRepository;

public class MealService {
	public final MealRepository MR;
	
	public MealService()
	{
		this.MR=new MealRepository();
	}
	
	public List<Meal> getMeals()
	{
		return this.MR.getAllMeals();
	}
	
	
}
