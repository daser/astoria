class AdminController < ApplicationController
  def home
  	  	@users = User.find(:all, :conditions=>{:approve =>0})
  end

  def approve
  	  	    userid = [params[:id]]
  	  	    #            logger.info('hashed password 2: ' + userid.to_sentence)
  	  	    user = User.find_by_id(userid)
  	  	    # logger.info('hashed password 2: ' + user.id)
  	  	    user.approve = 1
  	  	    if user.save
            #UserMailer.successful_registration(@user).deliver
            #redirect_to root_url, :notice => "Account Activated! You can now login"
            flash[:notice] = 'User Approved'
          	redirect_to "/admin"

          #redirect_to profile_path(@get_user.username)
          else
            #logger.info('hashed password 2: '+ @user.password)
            flash[:alert] = 'User Not Approved'
          	redirect_to "/admin"

         #   flash[:notice] = 'Your password could not be changed. Please try again'
          #@page = "Change Password"
          #@header_image = 'change-password'
          #render(:action => 'password')
          end    


  end

  def disapprove
  end

  def grant

  	  	    userid = [params[:id]]
  	  	    #            logger.info('hashed password 2: ' + userid.to_sentence)
  	  	    user = User.find_by_id(userid)
  	  	    # logger.info('hashed password 2: ' + user.id)
  	  	    user.accessflag = 1
  	  	    if user.save
            #UserMailer.successful_registration(@user).deliver
            #redirect_to root_url, :notice => "Account Activated! You can now login"
            UserMailer.new_registration(user).deliver
            flash[:notice] = 'User Granted Access'
          	redirect_to "/grantaccess"

          #redirect_to profile_path(@get_user.username)
          else
            #logger.info('hashed password 2: '+ @user.password)
            flash[:alert] = 'User Not Granted Access'
          	redirect_to "/grantaccess"

         #   flash[:notice] = 'Your password could not be changed. Please try again'
          #@page = "Change Password"
          #@header_image = 'change-password'
          #render(:action => 'password')
          end    

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
            user.paidflag = 1
            user.activation_token = gen
            if user.save
            #UserMailer.successful_registration(@user).deliver
            #redirect_to root_url, :notice => "Account Activated! You can now login"
            UserMailer.activation_email(user).deliver
            flash[:notice] = 'User Granted Access'
            redirect_to "/confirm"

          #redirect_to profile_path(@get_user.username)
          else
            #logger.info('hashed password 2: '+ @user.password)
            flash[:alert] = 'User Not Granted Access'
            redirect_to "/confirm"

         #   flash[:notice] = 'Your password could not be changed. Please try again'
          #@page = "Change Password"
          #@header_image = 'change-password'
          #render(:action => 'password')
          end    
    
  end

  # Random code, used for salt and temporary tokens.
  def generate_random_token
    SecureRandom.hex(15)
  end
end
