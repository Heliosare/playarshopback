require 'airborne'
require 'base64'
Airborne.configure do |config|
  config.base_url = 'http://localhost:3000'
  # config.base_url = 'http://api.playarshop.com/'
end


describe 'Company' do
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
    logo = Base64.encode64(File.read("./public/logo_stmich.jpg"))
    target = Base64.encode64(File.read("./public/target_stmich.jpg"))
    # target = Base64.encode64(File.open("./public/uploads/6b48abcc-a3e5-4b41-b830-8d49ba6353fe.jpg") {|img| img.read})
    puts "data:image/png;base64," + target
    post '/companies',
    {
      "company": {
          "name": "playarshop2",
          "logo": "data:image/png;base64," + logo
        }
    }
    expect_status(201)
  end

end
