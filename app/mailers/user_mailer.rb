# app/mailers/user_mailer.rb
class UserMailer < ApplicationMailer
  default from: 'notifications@odinbook.com'

  def welcome_email(user)
    @user = user
    @url  = 'http://localhost:3000/'
    mail(to: @user.email, subject: 'Welcome to odinbook!')
  end
end
