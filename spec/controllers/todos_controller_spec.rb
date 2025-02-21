require "rails_helper"

RSpec.describe TodosController, type: :controller do
  before do
    # ✅ Mock Room (No ActiveRecord)
    @mock_room = double("Room", room_code: "TESTROOM")
    allow(Room).to receive(:find_by).and_return(@mock_room)

    # ✅ Mock Database Calls
    allow(ActiveRecord::Base).to receive(:connection).and_raise("Database should not be accessed in unit tests!")
  end

  it "should define index action" do
    expect(subject).to respond_to(:index)
  end

  it "should define create action" do
    expect(subject).to respond_to(:create)
  end

  it "should define update action" do
    expect(subject).to respond_to(:update)
  end

  it "should define destroy action" do
    expect(subject).to respond_to(:destroy)
  end

  it "should define toggle action" do
    expect(subject).to respond_to(:toggle)
  end
end
