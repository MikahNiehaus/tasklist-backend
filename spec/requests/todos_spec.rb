require 'rails_helper'

RSpec.describe 'Todos API', type: :request do
  let!(:todos) { create_list(:todo, 5) }
  let(:todo_id) { todos.first.id }

  describe 'GET /todos' do
    it 'returns all todos' do
      get '/todos'
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).size).to eq(5)
    end
  end
end
