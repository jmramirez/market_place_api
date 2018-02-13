require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do # changed to Api::V1:: like the path spec/controllers/api/v1/
  before(:each) { request.headers['Accept'] = "application/vnd.marketplace.v1, application/json" } # run before each test in this scope, Mime::JSON lets us remove every `format: :json` param to requests

  describe "GET #show" do
    before(:each) do # run before each test in this scope
      @user = FactoryBot.create :user # create (so save also?) the instance of User model
      get :show, params: { id: @user.id , format: :json } # issue GET request to UsersController#show, with id param of @user.id and in format of json
    end

    it "returns the information about a reporter on a hash" do
      user_response = JSON.parse(response.body, symbolize_names: true)
      expect(user_response[:email]).to eql @user.email
    end

    it { should respond_with 200 }
  end
end

