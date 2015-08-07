require Rails.root.join("db/seeds/bad_celebs")
require Rails.root.join("db/seeds/bachelorette")

BadCelebs.seed!
Bachelorette.seed!
