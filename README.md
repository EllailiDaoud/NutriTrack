# NutriTrack

A Java EE (Servlet/JSP) web application for tracking meals and ingredients.

---

## ✨ Overview
NutriTrack lets users manage **meals** and **ingredients**. The project follows a clean layered structure (MVC-like):

- **Controller**: Servlets handling HTTP requests (`IngredientController`, `MealController`, `LoginController`, `LogoutController`).
- **Service**: Business logic (`IngredientService`, `MealService`, `UserService`).
- **Repository**: Data access using JDBC (`IngredientRepository`, `MealRepository`, `UserRepository`).
- **Model**: Domain objects (`Ingredient`, `Meal`, `User`).
- **Util**: Shared utilities (e.g., `DBUtil` for database connections).

Static pages and views live under `src/main/webapp` (e.g., `index.html`, `home.html`, `meals.jsp`, and `/img` assets).

---

## 🧱 Tech Stack
- **Java**: 8+ (11 recommended)
- **Build**: Maven (`pom.xml`)
- **Web**: Servlet / JSP (Java EE / Jakarta EE on Tomcat)
- **App Server**: Apache Tomcat 9.x (Tomcat 10 works if the app uses Jakarta namespaces)
- **Persistence**: JDBC via `DBUtil.java`

> Found files include: `pom.xml`, `src/main/webapp/WEB-INF/web.xml`, `src/main/webapp/index.html`, `src/main/webapp/meals.jsp`, images under `src/main/webapp/img`.

---

## 📁 Project Structure (important parts)
```
NutriTrack/
├─ pom.xml
├─ src/
│  └─ main/
│     ├─ java/
│     │  └─ ma/ac/esi/nutritrack/
│     │     ├─ controller/
│     │     │  ├─ IngredientController.java
│     │     │  ├─ MealController.java
│     │     │  ├─ LoginController.java
│     │     │  └─ LogoutController.java
│     │     ├─ model/
│     │     │  ├─ Ingredient.java
│     │     │  ├─ Meal.java
│     │     │  └─ User.java
│     │     ├─ repository/
│     │     │  ├─ IngredientRepository.java
│     │     │  ├─ MealRepository.java
│     │     │  └─ UserRepository.java
│     │     ├─ service/
│     │     │  ├─ IngredientService.java
│     │     │  ├─ MealService.java
│     │     │  └─ UserService.java
│     │     └─ util/
│     │        └─ DBUtil.java
│     └─ webapp/
│        ├─ WEB-INF/
│        │  └─ web.xml
│        ├─ index.html
│        ├─ home.html
│        ├─ error.html
│        ├─ meals.jsp
│        └─ img/
│           ├─ Apple.jpg
│           ├─ Bread.jpg
│           ├─ Carot.jpg
│           ├─ Cheese.jpg
│           ├─ Cookies.jpg
│           ├─ Egg.jpg
│           ├─ Letuce.jpg
│           ├─ Mais.jpg
│           ├─ RiceCake.jpg
│           ├─ Spinach.jpg
│           ├─ SweetPotato.jpg
│           └─ Tomato.jpg
└─ target/ ... (build output)
```

---

## ⚙️ Prerequisites
- **JDK** 8 or 11
- **Maven** 3.8+
- **Tomcat** 9.x installed and running
- **Database** (e.g., MySQL or another JDBC-compatible DB)

---

## 🗄️ Database Configuration
Database connectivity is handled in **`src/main/java/ma/ac/esi/nutritrack/util/DBUtil.java`**.  
Open that file and set JDBC URL, user, and password.

**Example (MySQL):**
```java
// DBUtil.java (example values — adjust to  setup)
private static final String URL  = "jdbc:mysql://localhost:3306/nutritrack?useSSL=false&serverTimezone=UTC";
private static final String USER = "root";
private static final String PASS = "password";
```

> Check `*Repository.java` files to confirm table names/columns before creating schema.

---

## ▶️ Run Locally

### Option A — Maven build & deploy to Tomcat
```bash
# from the project root (where pom.xml is)
mvn clean package

# copy the generated WAR to Tomcat
cp target/NutriTrack-0.0.1-SNAPSHOT.war $TOMCAT_HOME/webapps/

# start Tomcat and open:
# http://localhost:8080/NutriTrack-0.0.1-SNAPSHOT/ 
```

### Option B — Run from IDE (Eclipse/IntelliJ)
1. Import as **Maven** project.
2. Add a **Tomcat 9** server in  IDE.
3. Deploy the web module to Tomcat and click **Run**.

---

## 🔐 Authentication
`LoginController` / `LogoutController` are present. Ensure  user table and credentials are configured in  database. Session handling is typically managed in the controllers.

---

## 🚦 Typical Endpoints (examples)
Exact mappings live in  servlets’ `@WebServlet` annotations or `web.xml`. Common patterns might be:
- `/login`, `/logout`
- `/ingredients/*` (list/create/update/delete)
- `/meals/*` (list/create/update/delete)

---

## 🧪 Testing
- After deployment, visit: `http://localhost:8080/<context>/`
- Try navigating to `/meals.jsp` or from `index.html` / `home.html`.
- Watch Tomcat logs for JDBC connection errors and fix DB config if needed.

---

## 📦 .gitignore (recommended)
Create a `.gitignore` at the repo root:

---

## 📜 License
Add a license of  choice (e.g., MIT) or keep it private.

---

## 👤 Author
- **Daoud ELLAILI**
