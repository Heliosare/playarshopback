require 'airborne'
require 'base64'
Airborne.configure do |config|
  config.base_url = 'http://localhost:3000'
  # config.base_url = 'http://api.playarshop.com/'
end


describe 'Company' do
  it 'Sign Up' do
    post '/shops/sign_up',
      {
          "email": "scenario1@example.com",
          "password": "password"
      }
      token = json_body[:auth_token]
      Airborne.configure do |config|
        config.headers = {
            'Authorization': 'AUTH-BASIC ' + token,
            'Content-Type': 'application/json'
        }
      end
    expect_status(200)
  end
  it 'Connexion' do
    post '/shops/sign_in',
      {
          "email": "scenario1@example.com",
          "password": "password"
      }
      token = json_body[:auth_token]
      puts token
      Airborne.configure do |config|
        config.headers = {
            'Authorization': 'AUTH-BASIC ' + token,
            'Content-Type': 'application/json'
        }
      end
    expect_status(200)
  end
  it 'POST target' do
    get '/company/location'
    expect_status(200)
  end
end
