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
          "email": "scenario_basket@example.com",
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
          "email": "scenario_basket@example.com",
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

  it 'POST Company' do
    logo = Base64.encode64(File.read("./public/logo.png"))
    post '/companies',
    {
      "company": {
          "name": "playarshop",
          "logo": "data:image/png;base64," + logo
        }
    }
    expect_status(201)
  end



  it 'POST Target' do
    target1 = Base64.encode64(File.read("./public/bandit.jpg"))
    post '/targets',
    {
        "target": [{
            "place": "rennes",
            "city": "RENNES",
            "image": "data:image/png;base64," + target1
              }
            ]
      }
    GAME_REF = json_body[:game_ref]
    expect_status(201)
  end

  it 'POST games' do
    post '/games',
    {
      "game_ref": GAME_REF,
      "game": {
          "ref": 5,
          "name": "Bandit",
          "description": "Touches la poignée",
          "color1": "#8F3985",
          "color2": "#61E786",
          "perso1": "Blabla",
          "perso2": "Bloblo",
          "custom": "custom"
        }
    }
    expect_status(201)
  end

  it 'POST DISCOUNTS' do
    post '/discounts',
      {
        "game_ref": GAME_REF,
        "discount": [{
          "success": "Gagne",
          "fail": "Raté"
        }]
      }
    expect_status(201)
  end

end
