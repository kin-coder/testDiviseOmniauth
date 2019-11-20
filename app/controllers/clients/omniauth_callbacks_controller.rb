class Clients::OmniauthCallbacksController < Devise::OmniauthCallbacksController

    def facebook
        # You need to implement the method below in your model (e.g. app/models/user.rb)
        @client = Client.from_omniauth(request.env["omniauth.auth"])
    
        if @client.persisted?
          sign_in_and_redirect @client, event: :authentication #this will throw if @client is not activated
          set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
        else
          session["devise.facebook_data"] = request.env["omniauth.auth"]
          redirect_to new_client_registration_url
        end
      end
    
      def failure
        redirect_to root_path
      end
end