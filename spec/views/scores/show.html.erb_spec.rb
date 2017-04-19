require 'rails_helper'

RSpec.describe "scores/show", type: :view do
  before(:each) do
    @score = assign(:score, Score.create!(
      :target_id => "Target",
      :player_id => "Player",
      :game_id => "Game",
      :success => "Success",
      :score => "Score",
      :lieu => "Lieu",
      :location_gps => "Location Gps"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Target/)
    expect(rendered).to match(/Player/)
    expect(rendered).to match(/Game/)
    expect(rendered).to match(/Success/)
    expect(rendered).to match(/Score/)
    expect(rendered).to match(/Lieu/)
    expect(rendered).to match(/Location Gps/)
  end
end
