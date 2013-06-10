class UserMailer < ActionMailer::Base
  default :from => "astoria.com.ng"

  def activation_email(user)
    @user = user
    @activation_url = "http://www.astoria.com.ng/confirm/#{user.activation_token}/activation"
    @loginurl = 'astoria.com.ng/login'
    email_with_name = "#{@user.fname} <#{@user.email}>"
    mail(:to=>email_with_name,:subject=>"Confirm your registration at astoria.com.ng") do |format|
      format.html { render 'activation_email' }
    end

    #mail(:to=>email_with_name,:subject=>"Confirm your registration at kungiya.com") do |format|
    #  format.html { render 'activation_email' }
    #end


  end


  def new_registration(user)
    @user = user
    @fname = user.fname
    mail(:to => user.email,:subject=>"Thank You") do |format|
      format.html { render 'new_registration' }
    end
  end


  def activate()
  	
  end

  def granted(user)
    @user = user
    @fname = user.fname  	
    mail(:to => user.email,:subject=>"Further Registration Details") do |format|
      format.html { render 'granted' }
    end
  end

  def successful_registration(user)
    @user = user
    @fname = user.fname
    mail(:to => user.email,:subject=>"Registration Successful")
  end

  def password_reset(user)
    @user = user
    @fname = user.fname
    @reset_url = "http://www.astoria.com.ng/passwordedit/#{user.password_reset_token}"
    mail(:to => user.email,:subject=>"Your Password Reset Request")
  end

end
