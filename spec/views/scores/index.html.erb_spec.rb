require 'rails_helper'

RSpec.describe "scores/index", type: :view do
  before(:each) do
    assign(:scores, [
      Score.create!(
        :target_id => "Target",
        :player_id => "Player",
        :game_id => "Game",
        :success => "Success",
        :score => "Score",
        :lieu => "Lieu",
        :location_gps => "Location Gps"
      ),
      Score.create!(
        :target_id => "Target",
        :player_id => "Player",
        :game_id => "Game",
        :success => "Success",
        :score => "Score",
        :lieu => "Lieu",
        :location_gps => "Location Gps"
      )
    ])
  end

  it "renders a list of scores" do
    render
    assert_select "tr>td", :text => "Target".to_s, :count => 2
    assert_select "tr>td", :text => "Player".to_s, :count => 2
    assert_select "tr>td", :text => "Game".to_s, :count => 2
    assert_select "tr>td", :text => "Success".to_s, :count => 2
    assert_select "tr>td", :text => "Score".to_s, :count => 2
    assert_select "tr>td", :text => "Lieu".to_s, :count => 2
    assert_select "tr>td", :text => "Location Gps".to_s, :count => 2
  end
end
