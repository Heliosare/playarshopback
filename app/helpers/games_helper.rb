module GamesHelper

    def format_game(ref)
        ref = GameList.find_by(id: ref).name
    end
end
