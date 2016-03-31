require "rails_helper"

RSpec.describe UserNotifier, type: :mailer do
  describe "send order confirmation email" do
    order = Order.new(id: 25, status: "ordered")
    user = User.new(username: "nickynonaps",
                    first_name: "Nick",
                    last_name: "Dorans",
                    email: "bdiddybreeze@yahoo.com",
                    orders: [order])
    mail = UserNotifier.send_confirmation(user)

    it "renders the subject" do
      expect(mail.subject).to eql("Order #25 confirmation. Thank you for your order, Nick Dorans. We hope you enjoy your fresh produce!")
    end

    it "renders the receiver email" do
      expect(mail.to).to eql([user.email])
    end

    it "renders the sender email" do
      expect(mail.from).to eql(["noreply@carrots-n-stuff.com"])
    end
  end
end
