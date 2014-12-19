class QuestionMailer < ActionMailer::Base
  default from: "from@example.com"


  def send_question(params)
    @recipient = Order.find(params[:order][:id]).user.email
    @question = params[:question]
    @questioner_email = params[:email]

    mail :to => @recipient, :subject => "Question from notice board."
  end
end
