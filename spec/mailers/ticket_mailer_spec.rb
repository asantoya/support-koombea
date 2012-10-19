require "spec_helper"

describe TicketMailer do

  context "new_ticket" do
    ticket = FactoryGirl.create(:ticket)
    user = FactoryGirl.create(:support_user)
    mail = TicketMailer.new_ticket(ticket, user)

    it 'renders the subject' do
      mail.subject.should_not be_nil
    end
    it 'renders the sender email' do
      mail.from.should eq(["support@koombea.com"])
    end
  end

  context "ticket" do
    comment = FactoryGirl.create(:comment)
    mail = TicketMailer.new_comment(comment)
    it 'renders the subject' do
      mail.subject.should_not be_nil
    end
  end

  context "state_change" do
    ticket = FactoryGirl.create(:ticket)
    user = FactoryGirl.create(:client_user)
    user_mail = FactoryGirl.create(:support_user)
    mail = TicketMailer.state_change(ticket, user, user_mail)
    it 'renders the subject' do
      mail.subject.should_not be_nil
    end
  end

  context "assigned_to" do
    user = FactoryGirl.create(:support_user)
    ticket = FactoryGirl.create(:ticket, assigned_to: user)
    mail = TicketMailer.assigned_to(ticket)
    it 'renders the subject' do
      mail.subject.should_not be_nil
    end
  end

end
