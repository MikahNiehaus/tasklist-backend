require 'rails_helper'

RSpec.describe Todo, type: :model do
  it 'is valid with a title and completed status' do
    todo = FactoryBot.build(:todo)
    expect(todo).to be_valid
  end

  it 'is invalid without a title' do
    todo = FactoryBot.build(:todo, title: nil)
    expect(todo).to_not be_valid
  end
end
