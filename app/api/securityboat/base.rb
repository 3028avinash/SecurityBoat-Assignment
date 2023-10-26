module Securityboat
    class Base < Grape::API
      mount Securityboat::V1::SecurityboatApi
    end
end