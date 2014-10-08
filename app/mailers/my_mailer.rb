class MyMailer < Devise::Mailer 
  default from: "admin@chalenge.yum.pl"

  def answer_notification(answer)
  	@user = answer.question.user
  	@answer = answer
  	mail(to: @user.email, subject: 'You have answer for your question')
  end

  def accepted_answer_notification(answer)
  	@user = answer.user
  	@answer = answer
  	mail(to: @user.email, subject: 'You have accepted answer')
  end

end
