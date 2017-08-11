# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)




Cocktail.destroy_all
puts""
Ingredient.destroy_all
puts""
puts 'creating cocktails'
url = 'http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
ingredient_serialized = open(url).read
ingredients = JSON.parse(ingredient_serialized)

ingredients['drinks'].each do |ingredient|
  my_ingredient = ingredient["strIngredient1"]
  Ingredient.create(name: my_ingredient)
end

url = 'http://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic'
cocktails_serialized = open(url).read
cocktails = JSON.parse(cocktails_serialized)
cocktails['drinks'].first(20).each do |cocktail|
  my_cocktail = Cocktail.new(name: cocktail["strDrink"] )
  my_cocktail.photo_url = cocktail["strDrinkThumb"]
  my_id = cocktail["idDrink"]
  url = "http://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=#{my_id}"
  doses_serialized = open(url).read
  doses = JSON.parse(doses_serialized)
  doses['drinks'].each do |dose|
    ingredient = Ingredient.find_by_name(dose['strIngredient1'])
    my_dose = Dose.new(description: dose["strMeasure1"], ingredient: ingredient, cocktail: my_cocktail )
    my_dose.save
    my_cocktail.save
  end
end
puts "done"





