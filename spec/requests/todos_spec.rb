require "rails_helper"

RSpec.describe "Todos API", type: :request do
  let!(:room) { Room.create!(room_code: "TEST123") }
  let(:todo_params) { { todo: { title: "Test Todo", description: "Test Description" } } }

  describe "GET /rooms/:room_code/todos" do
    it "fetches todos successfully" do
      get "/rooms/#{room.room_code}/todos"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /rooms/:room_code/todos" do
    it "creates a new todo" do
      post "/rooms/#{room.room_code}/todos", params: todo_params
      expect(response).to have_http_status(:created)
    end

    it "does not create a todo with an empty title" do
      post "/rooms/#{room.room_code}/todos", params: { todo: { title: "", description: "No title" } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PATCH /rooms/:room_code/todos/:id" do
    it "updates a todo" do
      post "/rooms/#{room.room_code}/todos", params: todo_params
      todo_id = JSON.parse(response.body)["id"]

      patch "/rooms/#{room.room_code}/todos/#{todo_id}", params: { todo: { title: "Updated Title", description: "Updated Desc" } }
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /rooms/:room_code/todos/:id/toggle" do
    it "toggles a todo" do
      post "/rooms/#{room.room_code}/todos", params: todo_params
      todo_id = JSON.parse(response.body)["id"]

      patch "/rooms/#{room.room_code}/todos/#{todo_id}/toggle"
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE /rooms/:room_code/todos/:id" do
    it "deletes a todo" do
      post "/rooms/#{room.room_code}/todos", params: todo_params
      todo_id = JSON.parse(response.body)["id"]

      delete "/rooms/#{room.room_code}/todos/#{todo_id}"
      expect(response).to have_http_status(:no_content)
    end
  end
end
