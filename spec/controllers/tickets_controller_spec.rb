require 'spec_helper'

describe TicketsController do

  include Devise::TestHelpers

  describe "#index" do
    it "assigns all tickets as @tickets when the user has the role 'support'." do
      @user = FactoryGirl.create(:support_user)
      sign_in @user
      tickets = 5.times.map{ FactoryGirl.create(:ticket)}
      get :index, {}
      assigns(:tickets).sort.should eq(tickets)
    end

    it "assigns all tickets as @tickets when the user has the role 'client'." do
      @client = FactoryGirl.create(:client_user)
      @customer = FactoryGirl.create(:client_user)
      sign_in @client
      
      ticketsClient = 5.times.map{ FactoryGirl.create(:ticket, user: @client)}
      ticketsCustomer = 5.times.map{ FactoryGirl.create(:ticket, user: @customer)}

      get :index, {}
      assigns(:tickets).sort.should eq(ticketsClient)
    end
  end

  describe "#new" do
    it "assigns client to @client" do
      @user = FactoryGirl.create(:support_user)
      sign_in @user
      clients = 5.times.map{ FactoryGirl.create(:client_user) }
      get :new
      assigns(:clients).should eq(clients)
    end

    it "assigns assigned to @assigned" do
      @user = FactoryGirl.create(:client_user)
      sign_in @user
      assigned = 5.times.map{ FactoryGirl.create(:support_user) }
      get :new
      assigns(:assigned).should eq(assigned)
    end

    it "should render to new" do
      @user = FactoryGirl.create(:client_user)
      sign_in @user
      get :new
      response.should render_template('new')
    end
  end

  describe "#create" do
    it "should assign all users with role 'client' to @clients" do
      @user = FactoryGirl.create(:support_user)
      ticket = FactoryGirl.create(:ticket, user: @user)
      sign_in @user
      clients = 5.times.map { FactoryGirl.create(:client_user)  }
      post :create, { id: ticket}
      assigns(:clients).should eq(clients)
    end

    it "should save ticket" do
      @user = FactoryGirl.create(:client_user)
      sign_in @user

      attrs = FactoryGirl.attributes_for(:ticket, user: @user)

      expect{
        post :create, ticket: attrs 
      }.to change{Ticket.count}.by(1)
      ticket = assigns(:ticket)
      response.should redirect_to edit_ticket_path(ticket.id)
      flash[:notice].should match("Ticket was successfully created.")
    end

  end

  describe "#show" do
    it "should redirect to edit" do
      @user = FactoryGirl.create(:support_user)
      sign_in @user
      ticket = FactoryGirl.create(:ticket)
      get :show, { id: ticket }
      response.should redirect_to edit_ticket_path(ticket)
    end

    it "should show flash error if ticket isn't accessible" do
      @user = FactoryGirl.create(:client_user)
      @other_user = FactoryGirl.create(:user)
      sign_in @user
      ticket = FactoryGirl.create(:ticket, user: @other_user)
      get :show, { id: ticket}
      flash[:error].should_not be_nil
    end
  end

  describe "#edit" do
    it "should show form ticket when the user has the role 'support'." do
      @user = FactoryGirl.create(:support_user)
      sign_in @user
      ticket = FactoryGirl.create(:ticket)
      get :edit, { id: ticket }
      assigns(:ticket).should eq(ticket)
    end

    it "should show your own form ticket when the user has the role 'client'." do
      @client = FactoryGirl.create(:client_user)
      @customer = FactoryGirl.create(:client_user)
      sign_in @client

      ticketClient = FactoryGirl.create(:ticket, user: @client)
      ticketCustomer = FactoryGirl.create(:ticket, user: @customer)
      get :edit, { id: ticketClient }
      assigns(:ticket).should eq(ticketClient)
    end

    it "should redirect to tickets path with flash error if can't access to ticket" do
      @client = FactoryGirl.create(:client_user)
      @customer = FactoryGirl.create(:client_user)
      sign_in @client

      ticketClient = FactoryGirl.create(:ticket, user: @client)
      ticketCustomer = FactoryGirl.create(:ticket, user: @customer)
      
      get :edit, { id: ticketCustomer }
      
      response.should redirect_to tickets_path
      flash[:error].should_not be_nil
    end

    it "should redirect to tickets path with flash error if the ticket id is invalid" do
      @user = FactoryGirl.create(:support_user)
      sign_in @user

      get :edit, { id: 999 }

      response.should redirect_to tickets_path
      flash[:error].should_not be_nil
    end

    it "should assign the curren user to @user" do
      @user = FactoryGirl.create(:support_user)
      ticket = FactoryGirl.create(:ticket, user: @user)
      sign_in @user
      get :edit, { id: ticket}
      assigns(:user).should eq(@user)
    end

    it "should assign all users with role 'client' to @clients" do
      @user = FactoryGirl.create(:support_user)
      ticket = FactoryGirl.create(:ticket, user: @user)
      sign_in @user
      clients = 5.times.map { FactoryGirl.create(:client_user)  }
      get :edit, { id: ticket}
      assigns(:clients).should eq(clients)
    end 
  end

  describe '#update' do
    before :each do
      @user = FactoryGirl.create(:support_user)
      sign_in @user
      @ticket = FactoryGirl.create(:ticket)
    end

    it "should show flash error" do
      put :update, { id: @ticket }
      flash[:error].should_not be_nil
    end

    it "located the requested ticket" do
      put :update, { id: @ticket } 
      assigns(:ticket).should eq(@ticket)
    end
  end

  describe 'DELETE destroy' do
    it "should delete the ticket" do
      @user = FactoryGirl.create(:client_user)
      sign_in @user
      @ticket = FactoryGirl.create(:ticket, user: @user)
     
      expect{
        delete :destroy, id: @ticket        
      }.to change(Ticket, :count).by(-1)
    end
      
  end

end
