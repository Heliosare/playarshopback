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
    # logo = Base64.encode64(File.read("./public/logo_stmich.jpg"))
    target = Base64.encode64(File.read("./public/target_stmich.jpg"))
    # target = Base64.encode64(File.open("./public/uploads/6b48abcc-a3e5-4b41-b830-8d49ba6353fe.jpg") {|img| img.read})
    # puts "data:image/png;base64," + target
    post '/targets',
    {
      "targets": [{
            "place": "Name 1",
            "image": "data:image/png;base64," + target
        },{
            "place": "Name 2",
            "image": "data:image/png;base64," + target
          }]
        }
    expect_status(302)
  end

  # it 'editor' do
  #   get '/games/1/editor'
  #   expect_status(200)
  # end
  #
  # it 'GET GAMES' do
  #   post '/games/1',
  #     {
  #         "ref": 1,
  #         "name": "a change",
  #         "description": "Eclates les ballons",
  #         "logo": "logo",
  #         "color1": "rouge",
  #         "color2": "bleu",
  #         "perso1": "Jeu de Jacquie",
  #         "perso2": "et Michèle",
  #         "custom": "custom"
  #     }
  #   expect_json(name: 'a change')
  # end

end
