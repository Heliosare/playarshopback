require 'airborne'
require 'base64'
Airborne.configure do |config|
  config.base_url = 'http://localhost:3000'
  # config.base_url = 'http://api.playarshop.com/'
end


describe 'PLAYER' do
  it 'Sign Up' do
    post '/players/sign_in',
      {
          "email": "player@test.com",
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
  it 'ADD scores' do
    post '/scores',
    {
      "game_id": "1",
      "score": "12"
     }
    expect_status(200)
  end       
  it 'ADD scores' do
    post '/scores',
    {
      "game_id": "1",
      "score": "12"
     }
    expect_status(200)
  end

  it 'GET scores' do
    get '/scores'
    expect_json_types(scores: :array)
  end
end
