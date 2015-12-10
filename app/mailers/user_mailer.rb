class UserMailer < ActionMailer::Base
  default from: "noreply@whateveryoueventuallychoose.com"

  def daily_email(date = Event.current_date)
    @user = User.primary_user
    @events = Event.events_by_display_category(date)
    mail(to: @user.contact_info(:email), subject: "Mnemonic To-dos for #{date.strftime("%m/%d/%Y")}")
  end
  
end
