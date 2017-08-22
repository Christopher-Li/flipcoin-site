class Admin::MailerController < Admin::ApplicationController

  def preview_activation()
    @user = User.last
    render :file => 'user_mailer/account_activation.html.erb', :layout => 'mailer'
  end

end