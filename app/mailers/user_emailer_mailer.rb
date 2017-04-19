class UserEmailerMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Mot de passe perdu.')
  end
end
