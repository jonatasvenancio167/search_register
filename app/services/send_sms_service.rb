class SendSmsService
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def call
    client = Twilio::REST::Client.new(account_sid, auth_token)
    client.messages.create( from: ENV['TO_NUMBER'], to: "+55#{user.telephone}", body: message)
  end

  private 

  def account_sid 
    ENV['TWILIO_ACCOUNT_SID']
  end

  def auth_token
    ENV['TWILIO_AUTH_TOKEN']
  end

  def message
    "Segue o código de ativação: #{user.activation_code}"
  end
end