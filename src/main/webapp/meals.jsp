<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="ma.ac.esi.nutritrack.model.Meal" %>
<%@ page import="ma.ac.esi.nutritrack.model.Ingredient" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Meal Plan - Gain Weight</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <!-- Bootstrap CSS -->
  <link 
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" 
    rel="stylesheet">
  <!-- Bootstrap Icons -->
  <link 
    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" 
    rel="stylesheet">

  <style>
    body {
      background-color: #f8f9fa;
    }
    .sidebar {
      height: 100vh;
      background-color: #2c2c54;
      color: white;
      padding-top: 20px;
    }
    .sidebar a {
      color: white;
      display: block;
      padding: 15px;
      text-decoration: none;
      text-align: center;
    }
    .sidebar a:hover {
      background-color: #57577d;
    }
    .meal-card {
      border-radius: 15px;
      box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }
    .kcal-box {
      background-color: #fff;
      padding: 20px;
      border-radius: 15px;
      box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }
    .meal-item {
      border-radius: 10px;
      background-color: #fff;
      padding: 10px;
      margin-bottom: 10px;
      text-align: center;
      box-shadow: 0 1px 3px rgba(0,0,0,0.1);
    }
    .meal-item img {
      width: 40px;
      height: 40px;
      display: block;
      margin: 0 auto 5px;
    }
    .logout-btn {
      background-color: #dc3545; /* or any color you like */
      color: #fff;
      border: none;
      padding: 8px 16px;
      border-radius: 5px;
      cursor: pointer;
    }
    .logout-btn:hover {
      background-color: #c82333;
    }
    .ingredient-img {
    width: 50px; /* Adjust size */
    height: 50px;
    display: block;
    margin: 0 auto;
}

.btn-sm i {
    font-size: 1.2rem; /* Make icons bigger */
}

.card {
    border-radius: 10px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    padding: 15px;
    position: relative;
}
    
  </style>
</head>

<body>
  <div class="container-fluid">
    <div class="row">
      <!-- Sidebar -->
      <div class="col-md-2 sidebar d-flex flex-column align-items-center">
        <a href="#"><i class="bi bi-grid"></i></a>
        <a href="#"><i class="bi bi-search"></i></a>
        <a href="#"><i class="bi bi-people"></i></a>
        <a href="#"><i class="bi bi-star"></i></a>
        <a href="#"><i class="bi bi-calendar"></i></a>
        <a href="#"><i class="bi bi-check-square"></i></a>
        <a href="#"><i class="bi bi-chat"></i></a>
        <a href="#"><i class="bi bi-envelope"></i></a>
      </div>

      <!-- Main Content -->
      <div class="col-md-10 p-4">
        <!-- Title -->
        <h2><strong>Meal plans</strong> / Gain weight</h2>

        <!-- Session & User Info -->
<!-- Top Right User Info -->
<%
  String fullEmail = (String) session.getAttribute("login");
  String displayName = "Utilisateur";

  if (fullEmail != null && fullEmail.contains("@")) {
    String usernamePart = fullEmail.substring(0, fullEmail.indexOf("@"));
    String[] parts = usernamePart.split("\\.");

    StringBuilder formattedName = new StringBuilder();
    for (String part : parts) {
        if (!part.isEmpty()) {
            formattedName.append(Character.toUpperCase(part.charAt(0)))
                         .append(part.substring(1))
                         .append(" ");
        }
    }

    displayName = formattedName.toString().trim();
  }
%>

<!-- ✅ User info and logout nicely styled -->
<div class="d-flex justify-content-end align-items-center bg-white p-2 rounded shadow-sm mb-4" style="gap: 15px;">
  <div class="d-flex align-items-center">
    <i class="bi bi-person-circle me-2 fs-5 text-primary"></i>
    <span class="fw-bold text-dark"><%= displayName %></span>
  </div>
  <form action="LogoutController" method="post" class="m-0">
    <button type="submit" class="btn btn-link text-danger fw-semibold text-decoration-none">
      <i class="bi bi-box-arrow-right me-1"></i> Déconnexion
    </button>
  </form>
</div>


        <!-- *** Dynamic Calories Bar *** -->
<%
    // Retrieve values from request
    int totalMealCalories = (int) request.getAttribute("totalMealCalories");
    int burnedCalories = (int) request.getAttribute("burnedCalories");

    // Set a goal for daily calories (e.g., 2500 kcal)
    int calorieGoal = 2500;

    // Progress percentage (cap at 100%)
    double progressPercent = (calorieGoal > 0) ? ((double) totalMealCalories / calorieGoal) * 100 : 0;
    int progressWidth = (int) Math.min(progressPercent, 100);

    // 🔥 Dynamic Progress Bar Color
    String progressColor;
    if (progressPercent < 50) {
        progressColor = "#007bff"; // Blue 🟦 (Low Intake)
    } else if (progressPercent < 80) {
        progressColor = "#ffa500"; // Orange 🟧 (Medium Intake)
    } else {
        progressColor = "#dc3545"; // Red 🔴 (High Intake)
    }
%>

<!-- Right-aligned kcal display -->
<div class="d-flex justify-content-end">
  <div class="col-md-6 kcal-box">
    <h3 class="text-end"><strong><%= totalMealCalories %> kcal</strong></h3>

    <!-- Progress Bar -->
    <div class="progress my-3">
      <div class="progress-bar"
           role="progressbar"
           style="width: <%= progressWidth %>% ; background-color: <%= progressColor %>;"
           aria-valuenow="<%= progressWidth %>"
           aria-valuemin="0"
           aria-valuemax="100">
      </div>
    </div>

    <!-- 🔥 Dynamic Burned Calories -->
    <p class="text-end">
      <i class="bi bi-fire"></i> <%= burnedCalories %> kcal burned
    </p>
  </div>
</div>






        <!-- Button to Add Ingredient -->
        <button class="btn btn-primary mb-3" 
                data-bs-toggle="modal" data-bs-target="#addIngredientModal">
          <i class="bi bi-plus-lg"></i> Ajouter un ingrédient
        </button>

        <!-- Modal: Add Ingredient -->
        <div class="modal fade" id="addIngredientModal" tabindex="-1" 
             aria-labelledby="addIngredientModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <h5>Ajouter un nouvel ingrédient</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" 
                        aria-label="Close"></button>
              </div>
              <div class="modal-body">
<form action="IngredientController" method="post" onsubmit="return validateAddIngredientForm(this);">
                  <div class="mb-3">
                    <label class="form-label">Repas</label>
                    <select class="form-control" id="mealId" name="mealId" required>
                      <%
                        List<Meal> meals = (List<Meal>) request.getAttribute("meals");
                        if (meals != null) {
                          for (Meal meal : meals) {
                      %>
                            <option value="<%= meal.getMealId() %>">
                              <%= meal.getName() %>
                            </option>
                      <%
                          }
                        }
                      %>
                    </select>
                  </div>

                  <div class="mb-3">
                    <label class="form-label">Nom de l'ingrédient</label>
<input type="text" class="form-control"
       id="ingredientName" name="name"
       required
       oninput="this.setCustomValidity('');"
       oninvalid="this.setCustomValidity('Veuillez entrer au moins 2 lettres.')">

       </div>

				  <div class="mb-3">
				    <label class="form-label">Calories</label>
				    <input type="number" class="form-control"
				           id="ingredientCalories" name="calories" required min="1">
				  </div>


                  <button type="submit" class="btn btn-success">Ajouter</button>
                </form>
              </div>
            </div>
          </div>
        </div>

<script>
function validateAddIngredientForm(form) {
  let nameInput = form.name;
  let caloriesInput = form.calories;
  
  let name = nameInput.value.trim();
  let calories = parseInt(caloriesInput.value, 10);
  
  // clear native error
  nameInput.setCustomValidity("");
  caloriesInput.setCustomValidity("");

  let isValid = true;

  if (name.length < 2) {
    nameInput.setCustomValidity("Veuillez entrer au moins 2 lettres.");
    nameInput.reportValidity();
    isValid = false;
  }

  if (isNaN(calories) || calories < 1) {
    caloriesInput.setCustomValidity("Veuillez entrer un nombre positif.");
    caloriesInput.reportValidity();
    isValid = false;
  }

  return isValid;
}
</script>

        <!-- Display the Meals and Ingredients -->
        <div class="row mt-4">
          <%
            // We fetched 'meals' above for the modal, re-use it to display
            if (meals != null && !meals.isEmpty()) {
              for (Meal meal : meals) {
          %>
                <div class="col-md-3 mb-4">
                  <h5><%= meal.getName() %></h5>
<%
    List<Ingredient> ingList = meal.getIngredients();
    for (Ingredient ing : ingList) {
%>
    <div class="meal-item card p-3 text-center position-relative">
        <!-- 🥖 Ingredient Image -->
        <img src="img/<%= ing.getName().replaceAll(" ", "") %>.jpg"
             alt="<%= ing.getName() %>"
             class="ingredient-img mb-2">

        <!-- 🍞 Ingredient Name & Calories -->
        <strong><%= ing.getName() %></strong>
        <br>
        <small><%= ing.getCalories() %> kcal</small>

        <!-- 📝 Edit & ❌ Delete Icons -->
        <div class="position-absolute top-0 end-0 p-2">
            <!-- Edit Button (Opens Modal) -->
            <button class="btn btn-sm text-primary edit-btn"
                    data-bs-toggle="modal"
                    data-bs-target="#editIngredientModal"
                    data-id="<%= ing.getIngredientId() %>"
                    data-name="<%= ing.getName() %>"
                    data-calories="<%= ing.getCalories() %>">
                <i class="bi bi-pencil-square" style="font-size: 1.2rem;"></i>
            </button>

            <!-- Delete Button (Opens Confirmation Modal) -->
            <button class="btn btn-sm text-danger delete-btn"
                    data-bs-toggle="modal"
                    data-bs-target="#deleteIngredientModal"
                    data-id="<%= ing.getIngredientId() %>">
                <i class="bi bi-trash" style="font-size: 1.2rem;"></i>
            </button>
        </div>
    </div>
<%
    } // end ingredient loop
%>

                </div>
          <%
              } // end for each meal
            } else {
          %>
              <p>Aucun repas disponible.</p>
          <%
            }
          %>
        </div>

      </div> <!-- end col-md-10 -->
    </div> <!-- end row -->
  </div> <!-- end container-fluid -->
  
  <!-- 📝 Edit Ingredient Modal -->
<!-- 📝 Edit Ingredient Modal -->
<div class="modal fade" id="editIngredientModal" tabindex="-1" aria-labelledby="editIngredientModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Modifier un ingrédient</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
				<form action="IngredientController" method="post" onsubmit="return validateIngredientForm(this);">
				    <input type="hidden" name="action" value="update">
				    <input type="hidden" id="editIngredientId" name="ingredientId">
				
				    <div class="mb-3">
				        <label class="form-label">Nom de l'ingrédient</label>
				        <input type="text" class="form-control" id="editIngredientName" name="name" required minlength="2" maxlength="20">
				        <div class="text-danger small mt-1" id="nameError"></div> <!-- Error message -->
				    </div>
				
				    <div class="mb-3">
				        <label class="form-label">Calories</label>
				        <input type="number" class="form-control" id="editIngredientCalories" name="calories" required min="1">
				        <div class="text-danger small mt-1" id="caloriesError"></div> <!-- Error message -->
				    </div>
				
				    <button type="submit" class="btn btn-success">Mettre à jour</button>
				</form>


            </div>
        </div>
    </div>
</div>


<!-- ❌ Delete Confirmation Modal -->
<div class="modal fade" id="deleteIngredientModal" tabindex="-1" aria-labelledby="deleteIngredientModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title text-danger">Confirmer la suppression</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Voulez-vous vraiment supprimer cet ingrédient ?</p>
            </div>
            <div class="modal-footer">
                <form action="IngredientController" method="post">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" id="deleteIngredientId" name="ingredientId">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                    <button type="submit" class="btn btn-danger">Supprimer</button>
                </form>
            </div>
        </div>
    </div>
</div>

  
  
<script>
    // 📝 Fill Edit Modal when "Edit" button is clicked
    document.querySelectorAll('.edit-btn').forEach(button => {
        button.addEventListener('click', function () {
            let ingredientId = this.getAttribute('data-id');
            let ingredientName = this.getAttribute('data-name');
            let ingredientCalories = this.getAttribute('data-calories');

            document.getElementById('editIngredientId').value = ingredientId;
            document.getElementById('editIngredientName').value = ingredientName;
            document.getElementById('editIngredientCalories').value = ingredientCalories;
        });
    });

    // ❌ Pass Ingredient ID to Delete Modal
    document.querySelectorAll('.delete-btn').forEach(button => {
        button.addEventListener('click', function () {
            let ingredientId = this.getAttribute('data-id');
            document.getElementById('deleteIngredientId').value = ingredientId;
        });
    });
    

</script>


<script>
    function validateIngredientForm(form) {
        let nameInput = form.name;
        let caloriesInput = form.calories;
        
        let name = nameInput.value.trim();
        let calories = parseInt(caloriesInput.value, 10);
        
        let isValid = true;

        // Clear previous errors
        document.getElementById('nameError').innerText = "";
        document.getElementById('caloriesError').innerText = "";

        // 🛑 Validate Name (2-20 characters)
        if (name.length < 2 || name.length > 20) {
            document.getElementById('nameError').innerText = "Veuillez entrer entre 2 et 20 lettres.";
            isValid = false;
        }

        // 🛑 Validate Calories (Must be positive)
        if (isNaN(calories) || calories <= 0) {
            document.getElementById('caloriesError').innerText = "Veuillez entrer un nombre positif.";
            isValid = false;
        }

        return isValid; // Prevent form submission if false
    }
</script>


  

  <!-- Bootstrap JS -->
  <script 
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
  </script>
</body>
</html>