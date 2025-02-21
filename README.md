 📌 TaskList Backend - Ruby on Rails API

A RESTful API built with Ruby on Rails, providing CRUD operations for managing to-do tasks.

 🚀 Getting Started

 📦 Prerequisites
Ensure you have the following installed:
- Ruby (>= 3.2.0)
- Rails (>= 8.0.1)
- PostgreSQL (as the database)

 🔧 Installation
1. Clone the repository:
   ------------------------
   git clone https://github.com/your-username/tasklist-backend.git
   cd tasklist-backend
   ------------------------

2. Install dependencies:
   ------------------------
   bundle install
   ------------------------

3. Set up the database:
   ------------------------
   rails db:create
   rails db:migrate
   rails db:seed   (optional: if you have seed data)
   ------------------------

4. Start the server:
   ------------------------
   rails s -p 3001 -b 0.0.0.0 -e development
   ------------------------

 📌 API Endpoints

| Method | Endpoint              | Description                |
|--------|----------------------|----------------------------|
| `GET`  | `/todos`             | List all to-dos            |
| `GET`  | `/todos/:id`         | Get a single to-do         |
| `POST` | `/todos`             | Create a new to-do         |
| `PATCH` | `/todos/:id`        | Update an existing to-do   |
| `DELETE` | `/todos/:id`       | Delete a to-do             |
| `PATCH` | `/todos/:id/complete` | Mark a to-do as complete |

 📌 Example Request: Create a To-Do
------------------------
curl -X POST "http://localhost:3001/todos" \
     -H "Content-Type: application/json" \
     -d '{"todo": {"title": "New Task", "description": "This is a test task", "completed": false}}'
------------------------

 📌 Example Response
------------------------
{
  "id": 1,
  "title": "New Task",
  "description": "This is a test task",
  "completed": false,
  "created_at": "2025-02-20T12:34:56Z",
  "updated_at": "2025-02-20T12:34:56Z"
}
------------------------

 🛠 Running Tests

 ✅ Run Tests not yet updated with new version
------------------------
rails test test/controllers/todos_controller_test.rb
------------------------

 ✅ Run RSpec Tests 
------------------------
bundle exec rspec
------------------------

 📌 Project Structure
------------------------
tasklist-backend/
│── app/
│   ├── controllers/
│   │   ├── todos_controller.rb
│   ├── models/
│   │   ├── todo.rb
│   ├── views/
│── config/
│── db/
│   ├── migrate/
│   ├── schema.rb
│── spec/ (for RSpec tests)
│── test/ (for Minitest tests)
│── Gemfile
│── README.md
------------------------

 📌 Environment Variables
This project uses dotenv to manage environment variables.

1. Create a `.env` file:
   ------------------------
   touch .env
   ------------------------

2. Add database credentials:
   ------------------------
   DATABASE_URL=postgres://username:password@localhost:5432/tasklist_development
   ------------------------

3. Load environment variables:
   ------------------------
   source .env
   ------------------------

 🚀 Deployment
For production:
------------------------
RAILS_ENV=production rails db:migrate
RAILS_ENV=production rails s
------------------------

 📜 License
This project is licensed under the MIT License.
------------------------
Let me know if you want any modifications! 🚀🔥