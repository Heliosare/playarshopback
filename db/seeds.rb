# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
GameList.create(name: "Eclates Ballons", description: "Eclates le maximum de ballon en les touchants sur l'écran pour remporter le jeu", level: ['100', '200', '300'])
GameList.create(name: "Beer pong", description: "Lance la balle dans le verre pour gagber", level: ['1', '2', '3'])
GameList.create(name: "Chasse taupes", description: "Chasse Taupe", level: ['100', '200', '300'])
GameList.create(name: "Chasse au trésor", description: "Trouves les trésors", level: ['1', '2', '3'])
GameList.create(name: "Beer pong", description: "Lance la balle dans le verre pour gagber", level: ['1', '2', '3'])
GameList.create(name: "Chasse taupes", description: "Chasse Taupe", level: ['100', '200', '300'])
Score.create(target_id: 1, player_id: 1, game_id: 4, score: 42, created_at: "2016-12-25")