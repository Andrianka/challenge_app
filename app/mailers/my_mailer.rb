class MyMailer < Devise::Mailer 
  default from: "from@example.com"

  def answer_notification(answer)
  	@user = answer.question.user
  	@answer = answer
  	mail(to: @user.email, subject: 'You have answer for your question').deliver!
  end

  def accepted_answer_notification(answer)
  	@user = answer.user
  	@answer = answer
  	mail(to: @user.email, subject: 'You have accepted answer').deliver!
  end

end
