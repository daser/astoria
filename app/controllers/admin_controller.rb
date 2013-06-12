class AdminController < ApplicationController
  def home
  	  	@users = User.find(:all, :conditions=>{:approve =>0})
  end

  def approve
  	  	    userid = [params[:id]]
  	  	    #            logger.info('hashed password 2: ' + userid.to_sentence)
  	  	    user = User.find_by_id(userid)
  	  	    # logger.info('hashed password 2: ' + user.id)
  	  	    #user.approve = 1

  	  	    
            user.update_attribute("approve", 1)
            #UserMailer.granted(@user).deliver
            invi = Invitation.find_by_email(user.email)
            if invi
            #call mail for invitation:discounted
            UserMailer.successfulreg_invite(user).deliver
            else
              #call mail for signup
              UserMailer.granted(user).deliver
            end


            #redirect_to root_url, :notice => "Account Activated! You can now login"
            flash[:notice] = 'User Approved'
          	redirect_to "/admin"

          #redirect_to profile_path(@get_user.username)

  end

  def disapprove
  end

  def grant

  	  	    userid = [params[:id]]
  	  	    #            logger.info('hashed password 2: ' + userid.to_sentence)
  	  	    user = User.find_by_id(userid)
  	  	    # logger.info('hashed password 2: ' + user.id)

            user.update_attribute("accessflag", 1)
            #UserMailer.successful_registration(@user).deliver
            #redirect_to root_url, :notice => "Account Activated! You can now login"
            #UserMailer.new_registration(user).deliver
            flash[:notice] = 'User Granted Access'
          	redirect_to "/grantaccess"

  end

  def grantaccess
  	  @users = User.find(:all, :conditions=>"approve = 1 AND accessflag=0")
  end

  def confirm
      @users = User.find(:all, :conditions=>"approve = 1 AND accessflag=1 AND paidflag=0")
  end

  def confirmuser
            userid = [params[:id]]
            #            logger.info('hashed password 2: ' + userid.to_sentence)
            user = User.find_by_id(userid)
            # logger.info('hashed password 2: ' + user.id)
            gen = generate_random_token
            user.update_attribute("paidflag", 1)
            user.update_attribute("activation_token", gen)
            #UserMailer.successful_registration(@user).deliver
            #redirect_to root_url, :notice => "Account Activated! You can now login"
            UserMailer.activation_email(user).deliver
            flash[:notice] = 'User Granted Access'
            redirect_to "/confirm"
  end

  # Random code, used for salt and temporary tokens.
  def generate_random_token
    SecureRandom.hex(15)
  end
end
