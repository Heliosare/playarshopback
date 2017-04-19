require 'rails_helper'

RSpec.describe "scores/edit", type: :view do
  before(:each) do
    @score = assign(:score, Score.create!(
      :target_id => "MyString",
      :player_id => "MyString",
      :game_id => "MyString",
      :success => "MyString",
      :score => "MyString",
      :lieu => "MyString",
      :location_gps => "MyString"
    ))
  end

  it "renders the edit score form" do
    render

    assert_select "form[action=?][method=?]", score_path(@score), "post" do

      assert_select "input#score_target_id[name=?]", "score[target_id]"

      assert_select "input#score_player_id[name=?]", "score[player_id]"

      assert_select "input#score_game_id[name=?]", "score[game_id]"

      assert_select "input#score_success[name=?]", "score[success]"

      assert_select "input#score_score[name=?]", "score[score]"

      assert_select "input#score_lieu[name=?]", "score[lieu]"

      assert_select "input#score_location_gps[name=?]", "score[location_gps]"
    end
  end
end
