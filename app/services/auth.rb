require 'jwt'
require 'ostruct'
class Auth
  SECRET = Rails.application.credentials.jwt[:secret]
  LEEWAY = 60
  def self.create_token(user, recovery)
    payload = {
      sub: 'login',
      data: user,
      iat: Time.now.to_i,
      exp: recovery == true ? 5.hours.from_now.to_i : (1.month.from_now).to_i
    }
    JWT.encode payload, SECRET, 'HS256'
  end

  def self.decode_token(token)
    begin
      decode = JWT.decode token, SECRET, true, { exp_leeway:  LEEWAY, verify_iat: true, :algorithm => 'HS256' }
      OpenStruct.new(decode.first.merge(status: :ok))
    rescue JWT::VerificationError => e
      OpenStruct.new({ message: "Invalid token", status: :forbidden })
    rescue JWT::ExpiredSignature
      OpenStruct.new({ message: "Token has expired.", status: :unauthorized })
    rescue JWT::DecodeError => e
      OpenStruct.new({ message: "Token is empty", status: :bad_request })
    end
    
  end

  
end