class UserMailer < ApplicationMailer

    def example(user)
      @user = user
      mail(to: @user.email, subject: 'User sign-up successfully')
    end
  
  end