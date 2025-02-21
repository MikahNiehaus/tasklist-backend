# spec/requests/todos_spec.rb

RSpec.describe "Todos API", type: :request do
    # it "fetches todos successfully" do
    #   get "/rooms/:room_code/todos"
    #   expect(response).to have_http_status(:success)
    # end
  
    # it "creates a new todo" do
    #   post "/rooms/:room_code/todos", params: { todo: { title: "Test Todo", completed: false } }
    #   expect(response).to have_http_status(:created)
    # end
  
    # it "does not create a todo with an empty title" do
    #   post "/rooms/:room_code/todos", params: { todo: { title: "", completed: false } }
    #   expect(response).to have_http_status(:unprocessable_entity)
    # end
  
    # it "updates a todo" do
    #   patch "/rooms/:room_code/todos/:id", params: { todo: { title: "Updated Task" } }
    #   expect(response).to have_http_status(:success)
    # end
  
    # it "toggles a todo" do
    #   patch "/rooms/:room_code/todos/:id/toggle"
    #   expect(response).to have_http_status(:success)
    # end
  
    # it "deletes a todo" do
    #   delete "/rooms/:room_code/todos/:id"
    #   expect(response).to have_http_status(:no_content)
    # end
  end
  