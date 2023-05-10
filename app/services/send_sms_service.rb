require 'nexmo'

class SendSmsService
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def call
    client = Nexmo::Client.new(api_key: nexmo_api_key, api_secret: nexmo_api_secret)
    response = client.sms.send( 
      from: ENV['TELEPHONE_NUMBER'], 
      to: "+55#{user.telephone}", 
      text: message
    )

    if response.messages.first.status == '0'
      puts 'Mensagem enviada com sucesso!'
    else
      puts 'Erro no envio da mensagem: #{response.messages.first.error_text}' 
    end
  end

  private 

  def nexmo_api_key 
    ENV['NEXMO_API_KEY']
  end

  def nexmo_api_secret
    ENV['NEXMO_API_SECRET']
  end

  def message
    "Segue o código de ativação: #{user.activation_code}"
  end
end