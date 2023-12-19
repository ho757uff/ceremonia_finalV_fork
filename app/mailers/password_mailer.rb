class PasswordMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.passord_mailer.reset.subject
  #
  def reset
    @user = params[:user]
    mail to: @user.email
  end
end
