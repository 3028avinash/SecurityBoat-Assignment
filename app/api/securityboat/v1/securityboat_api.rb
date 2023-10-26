require 'securerandom'

module Securityboat
  module V1
    class SecurityboatApi < Grape::API
      include Securityboat::V1::Defaults

        ##################################################################
        # => Sign Up API
        ##################################################################
        resource :signUp do
          desc "User-SignUp API"
          before {api_params}
          params do

            requires :name, type: String, allow_blank: false
            requires :password, type: String, allow_blank: false
            requires :mobile_number, type: String, allow_blank: false
            requires :email, type: String, allow_blank: false
            
          end

          post do
            begin


              if params[:email]

                user = User.find_or_initialize_by(email: params[:email] ) do |new_user|

                  new_user.name = params[:name]
                  new_user.password = params[:password]
                  new_user.mobile_number = params[:mobile_number]
                  new_user.email = params[:email]
                  new_user.security_token = SecureRandom.hex(10)

                end
                  
                if user.new_record?
                  user.save
                  {message: MSG_SUCCESS, status: 200, userId: user.id, securityToken: user.security_token, data: "You can Access Your Account by using security-token and password with email or mobile number" }
                else 
                  {message: "User Already Exist", status: 200, userId: user.id, securityToken: user.security_token, data: "You can Access Your Account by using security-token and password with email or mobile number" } 
                end

              else
                {message: INVALID_SIGN_UP_DATA, status: 500}
              end
            rescue Exception => e
              logger.info "API Exception-#{Time.now}-SignUp-API-#{params.inspect}-Error-#{e}"
              {message: MSG_ERROR, status: 500}
            end
          end
        end








        ##################################################################
        # => Inviting Refering API
        ##################################################################
        resource :userDetails do
          desc "Invite Page API"
          before {api_params}
          params do
            requires :email, type: String, allow_blank: false             
            requires :securityToken, type: String, allow_blank: true
            requires :password, type: String, allow_blank: true
          end

          post do
            begin
              if params[:email] && (params[:securityToken] || params[:password])
              
                user = User.find_by(email: params[:email])
                user = user && ( user.password == params[:password] || user.security_token == params[:securityToken] )

                if user
                  user = User.find_by(email: params[:email])
                  data = {
                    user_id: user.id,
                    name: user.name,
                    mobile_number: user.mobile_number,
                    email: user.email,
                    joined_on: user.created_at,
                  }
                    

                  {message: MSG_SUCCESS, status: 200, data: data}
                else
                  { message: INVALID_USER, status: 500 }
                end
              else
                {message: MSG_ERROR, status: 500}
              end
            rescue Exception => e
              logger.info "API Exception-#{Time.now}-Invite-Page-API-#{params.inspect}-Error-#{e}"
              {message: MSG_ERROR, status: 500}
            end
          end
        end



        ##################################################################
        # => Inviting Refering API
        ##################################################################
        resource :create_task do
          desc "Invite Page API"
          before {api_params}
          params do
            requires :email, type: String, allow_blank: false             
            requires :title, type: String, allow_blank: false             
            requires :description, type: String, allow_blank: false             
            requires :due_date, type: String, allow_blank: false             
            requires :securityToken, type: String, allow_blank: true
            requires :password, type: String, allow_blank: true
          end

          post do
            begin
              if params[:email] && (params[:securityToken] || params[:password])
              
                user = User.find_by(email: params[:email])
                user = user && ( user.password == params[:password] || user.security_token == params[:securityToken] )

                if user
                  user = User.find_by(email: params[:email])
                  task = user.tasks.create(title: params[:title], description: params[:description], due_date: params[:due_date])
                    

                  {message: MSG_SUCCESS, status: 200, task_id: task.id}

                else
                  { message: INVALID_USER, status: 500 }
                end
              else
                {message: MSG_ERROR, status: 500}
              end
            rescue Exception => e
              logger.info "API Exception-#{Time.now}-Invite-Page-API-#{params.inspect}-Error-#{e}"
              {message: MSG_ERROR, status: 500}
            end
          end
        end



        ##################################################################
        # => Inviting Refering API
        ##################################################################
        resource :show_tasks do
          desc "Invite Page API"
          before {api_params}
          params do
            requires :email, type: String, allow_blank: false             
            requires :securityToken, type: String, allow_blank: true
            requires :password, type: String, allow_blank: true
          end

          post do
            begin
              if params[:email] && (params[:securityToken] || params[:password])
              
                user = User.find_by(email: params[:email])
                user = user && ( user.password == params[:password] || user.security_token == params[:securityToken] )

                if user
                  user = User.find_by(email: params[:email])
                  data = []
                  user.tasks.each do |task|
                    data << {
                      task_id: task.id,
                      title: task.title,
                      description: task.description,
                      due_date: task.due_date,
                      completed: task.completed,
                      created_at: task.created_at,
                    }
                  end
                  {message: MSG_SUCCESS, status: 200, data: data}
                else
                  { message: INVALID_USER, status: 500 }
                end
              else
                {message: MSG_ERROR, status: 500}
              end
            rescue Exception => e
              logger.info "API Exception-#{Time.now}-Invite-Page-API-#{params.inspect}-Error-#{e}"
              {message: MSG_ERROR, status: 500}
            end
          end
        end


        
    end 
  end
end 
