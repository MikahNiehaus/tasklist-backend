require 'rails_helper'

RSpec.describe 'Todos API', type: :request do
  let!(:todo) { create(:todo) }  # Create a test todo
  let(:todo_id) { todo.id }  # Get the todo's ID

  describe 'POST /todos' do
    it 'creates a new to-do item' do
      valid_params = { todo: { title: 'New Task', description: 'Test description', completed: false } }

      post '/todos', params: valid_params

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['title']).to eq('New Task')
    end
  end

  describe 'PATCH /todos/:id' do
    it 'updates a to-do item' do
      update_params = { todo: { title: 'Updated Task' } }

      patch "/todos/#{todo_id}", params: update_params

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['title']).to eq('Updated Task')
    end
  end

  describe 'DELETE /todos/:id' do
    it 'deletes a to-do item' do
      expect {
        delete "/todos/#{todo_id}"
      }.to change(Todo, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end

  describe 'PATCH /todos/:id/complete' do
    it 'marks a to-do item as completed' do
      patch "/todos/#{todo_id}/complete"

      expect(response).to have_http_status(:ok)
      expect(Todo.find(todo_id).completed).to be true
    end
  end
end
