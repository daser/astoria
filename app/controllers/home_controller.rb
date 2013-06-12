class HomeController < ApplicationController
    before_filter :save_login_state!, :only =>[:login, :signup]

  def index
  	@user = User.new(params[:user])
  	if request.post?
  		if @user.save
  			if request.xhr?
  				logger.info("i am here")
  			else
  				logger.info("user added")
  			end
  		else
  			if request.xhr?
  				logger.info("403")
  			else
  				logger.info("could not insert")
  			end
  		end
  	end
  	#logger.info('check out: '+ @user)
  end

  def login
    
  end

  def signup
    @user = User.new(params[:user])
    @checkin = true
      if request.post?
        if @user.save
          UserMailer.new_registration(@user).deliver
          flash[:notice] = "Thanks for your interest"
          @checkin = false
        else
          #flash[:alert] = "Form is invalid"
        end
      end
  end

def activate
      @token = [params[:token]]
      ifexist = User.find_by_activation_token(@token)
      if ifexist
      @user = ifexist
      if request.post?
        password = params[:user][:password]
        password_confirmation = params[:user][:password_confirmation]
        if password != password_confirmation
          flash[:alert] = "***** password doesn't match confirmation"
          flash[:color] = "invalid"
        else
          @user.updating_password = true
          @user.password = password
          @user.active = 1
          @user.activation_token = nil
          if @user.save
            UserMailer.successful_registration(@user).deliver
            invit = Invitation.find(:all, :conditions=>{:email=>@user.email})

            if invit
               invitt = invit.update_all({:invited => @user.id})
             end

            redirect_to root_url, :notice => "Account Activated! You can now login"

          #redirect_to profile_path(@get_user.username)
          else
            logger.info('hashed password 2: '+ @user.password)
            flash[:alert] = 'Your password could not be changed. Please try again'
          #@page = "Change Password"
          #@header_image = 'change-password'
          #render(:action => 'password')
          end    
        end
      end
  else
    flash[:notice] = "Invalid token"
    redirect_to :action=>"index"
  end


  
end


def signin
    if request.post?
      user = User.authenticate(params[:email], params[:password])
      if user
        if user.active != 0
          session[:user_id] = user.id
          redirect_to "/home"
          #logger.info("This is it " + user)
        else
        flash[:alert] = "This account has not been activated"
        render "login"          
        end
      else
        flash[:alert] = "Invalid email or password"
        render "login"
      end
    else
      render "login"
    end
  end

  def passwordreset
    if request.post?
        user = User.find_by_email(params[:email])
        if user
        user.send_password_reset 
        flash[:notice] = "Email sent with password reset instructions."
        else
          flash[:flag] = "This email " + params[:email] +" does not exist."
         # flash[:notice] = "Please ensure that the username is spelled correctly and try again, or use the domain field instead. 
          #flash[:notice] = "If this problem continues, please contact support."

        end
    end
  end 

  def passresedit
    @user = User.find_by_password_reset_token(params[:token])
    if @user
      if request.post?

        password = params[:user][:password]
        password_confirmation = params[:user][:password_confirmation]
        if password != password_confirmation
          logger.info("***** password doesn't match confirmation")
          flash[:alert] = "***** password doesn't match confirmation"
        elsif @user.password_reset_sent_at < 2.hours.ago
          flash[:alert] = "Password reset has expired."
        else
          #@user.update_attributes(params[:user])
          @user.updating_password = true
          @user.password = password
          @user.password_reset_token = nil
          if @user.save
          flash[:notice] = "Password has been reset!"
          #redirect_to profile_path(@get_user.username)
          else
            flash[:alert] = 'Your password could not be changed. Please try again'
          end    
        end
      end
  else
    flash[:notice] = "Invalid token"
    redirect_to :action=>"index"
  end
end

 def logout
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end

def dashboard
  
end

def invitefriend
  @invite = Invitation.new(params[:invitation])
    if request.post?
      if User.find_by_email(@invite.email)
          flash[:alert] = "User already an astoria member"
       else 
        myid = session[:user_id]
        @invite.invitee = myid

        if checkusertoinvited(myid,@invite.email)
            if @invite.save
            #UserMailer.new_registration(@invite).deliver
            invitee = User.find_by_id(myid)
            inviteefname = invitee.fname
            inviteelname = invitee.lname
            UserMailer.send_invitation(inviteefname,inviteelname,@invite.name,@invite.email).deliver

            flash[:notice] = "User already contacted"
            else
            flash[:alert] = "Form is invalid"
            end
        else
            flash[:alert] = "You have already sent invitation to this user"
        end
      end

    end

end


def checkusertoinvited(invitee,email)
#invite = Invitation.find(:all, :conditions=>['invitee=? AND email=?',invitee,email])
#invite = Invitation.where("invitee = ? AND email = ?",1,email)
#Client.where("orders_count = ? AND locked = ?", params[:orders], false)
invite = Invitation.find_by_email_and_invitee(email,invitee)
#invite = Invitation.find(:all, :conditions=>"invitee = 1 AND invited=3")

# logger.info("Something like this " + invitee)
  #logger.info(invite)
  if invite
    return false
  else
    return true
  end
end


end
