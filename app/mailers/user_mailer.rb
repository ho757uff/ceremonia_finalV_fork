class UserMailer < ApplicationMailer

    default from: 'amachermathieu@gmail.com'

    def welcome_email(user)
        @user = user
        
        @url = 'http://monsite.fr/login'

        mail(to: @user.email, subject: "Votre inscription sur Ceremonia")
    end

    def password_reset(user)
        @user = user

        @url = 'http://monsite.fr/login'

        mail(to: @user.email, subject: "Nouveau Mot de Passe")
    end
    
end
