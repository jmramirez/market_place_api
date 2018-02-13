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

  describe "POST #create" do

    context "when is successfully created" do
      before(:each) do
        @user_attributes = FactoryBot.attributes_for :user
        post :create, params: { user: @user_attributes }, format: :json
      end

      it "renders the json representation for the user record just created" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:email]).to eql @user_attributes[:email]
      end

      it { should respond_with 201 }

    end

    context "when is not created" do
      before(:each) do
        #notice I'm not including the email
        @invalid_user_attributes = { password: "12345678",password_confirmation: "12345678"}
        post :create, params: { user: @invalid_user_attributes }, format: :json
      end

      it "renders an errors json" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response).to have_key(:errors)
      end

      it "renders the json errors on why the user could not be created" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:errors][:email]).to include "can't be blank"
      end

      it { should respond_with 422}

    end

  end


end

