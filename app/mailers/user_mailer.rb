class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("mailer.user_mailer.account_text")
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: t("mailer.user_mailer.password_text")
  end
end
