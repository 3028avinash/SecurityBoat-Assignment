module Securityboat
    module V1
      # Defaults
      module Defaults
        extend ActiveSupport::Concern
        CONVERSION_AMOUNT = 100
        TASK_COMPLETE_COIN = 10
        MINIMUM_WITHDRAW_LIMIT = 1
        MAX_IP_COUNT = 10
        MSG_SUCCESS = "Success"
        MSG_WARNING = "Warning"
        # APIKEY = 'f4919ce87ada4fda8952163971ed9fb6'
        MSG_ERROR = "Internal Server Error"
        BLOCKED = "You are Blocked, Max Limit Reached"
        INVALID_USER = 'Invalid User Request'
        INVALID_SIGN_UP_DATA = 'Invalid Sign Up Credectials Povided'
        BASE_URL = "http://spnws.viroshots.com"
        # NEWS_API = News.new("f4919ce87ada4fda8952163971ed9fb6") 
        INVITE_IMAGE_URL = "https://m.media-amazon.com/images/I/61vI32zUXaL.png"
        INVITE_INSTRUCTION = "1). Invite Your Friend to Securityboat.\n\n2). Your friend join Securityboat using your refer code.\n\n3).You will get 200 coins as referral bonus."
        INVITE_URL = "Click here to download this app on this link\nhttp://csly.viroshots.com"


        included do
          prefix 'api'
          version 'v1', using: :path
          default_format :json
          format :json
          #formatter :json, Grape::Formatter::ActiveModelSerializers
  
          helpers do
            
            def permitted_params
              @permitted_params ||= declared(params, include_missing: false)
            end
  
            def api_params
              Rails.logger.info"API Params:#{params.inspect}"
            end
  
            def logger
              Rails.logger
            end
  
            # def current_user
            #   # find token. Check if valid.
            #   token = ApiKey.where(access_token: params[:token]).first
            #   if token && !token.expired?
            #     @current_user = User.find(token.user_id)
            #   else
            #     false
            #   end
            # end

            def valid_user(user_id, security_token)
              user = User.find_by(id: user_id, security_token: security_token) 
              if user          
                return user
              else
                return false
              end
            end

          end

          rescue_from ActiveRecord::RecordNotFound do |e|
            error_response(message: e.message, status: 404)
          end
  
          rescue_from ActiveRecord::RecordInvalid do |e|
            error_response(message: e.message, status: 422)
          end

        end
      end
    end
  end