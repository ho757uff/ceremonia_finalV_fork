# Preview all emails at http://localhost:3000/rails/mailers/passord_mailer
class PassordMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/passord_mailer/reset
  def reset
    PassordMailer.reset
  end

end
