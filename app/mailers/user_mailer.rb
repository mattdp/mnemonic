class UserMailer < ActionMailer::Base
  default from: "noreply@whateveryoueventuallychoose.com"

  def daily_email(date)
    @user = User.primary_user
    mail(to: @user.email, subject: "Mnemonic To-dos for #{date.strftime("%m/%d/%Y")}")
  end
  
end
