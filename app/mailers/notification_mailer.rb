class NotificationMailer < ApplicationMailer
  default from: "abe.ayumu.infratop@gmail.com"

  def send_confirm_to_user(contact)
    @contact = contact
    mail(
      subject: "お問い合わせありがとうございました。", #メールのタイトル
      to: @contact.user.email #宛先
    ) do |format|
      format.text
    end
  end
end
