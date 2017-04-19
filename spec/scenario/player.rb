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
  it 'Change User Info' do
    post '/users',
    {
      "email": "player@test.com",
      "password": "newPassword"
    }
    expect_status(200)
  end
  it 'Sign In after Update' do
    post '/players/sign_in',
      {
          "email": "player@test.com",
          "password": "newPassword"
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
  it 'GET info' do
    get '/users'
    expect_status(200)
  end

  if 'POST Score' do
    post '/scores'
    {
      "game_id" : "1",
      "target_id" :   "1",
      "score" : "41"
    }
  end
  if 'POST Score' do
    post '/scores'
    {
      "game_id" : "1",
      "target_id" :   "1",
      "score" : "42"
    }
  end
  if 'POST Score' do
    post '/scores'
    {
      "game_id" : "1",
      "target_id" :   "1",
      "score" : "43"
    }
  end
  # it 'Change User Info' do
  #   post '/users',
  #   {
  #     "email": "player@test.com",
  #     "password": "password"
  #   }
  #   expect_status(200)
  # end
end
