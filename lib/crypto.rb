 # ligne très importante qui appelle la gem.
require 'nokogiri'
require 'rubygems'
require 'open-uri'

def crypto_array
#determine les tableaux vident
  value = []
  currency = []

#quel site est utilisé pour le scrapping
  page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

#recuperation du xpath du nm de la devis et integration dans le tableau currency[]
  page.xpath('//a[@class = "link-secondary"]').each do |devise|

    currency << devise.text

  end
#print currency

#recuperation du xpath du cours de la devise et integration dans le tableu value[]
  page.xpath('//a[@class = "price"]').each do |valeur|

    value << valeur.text

  end
#print value

#supprime le $ devant la valeur et transforme l'argument en float pour pouvoir le traiter
  value_without_dollar = value.map{|e| e.delete('$').to_f }

#associe le nom de la monnaie(key du hash) et sa valeur dans une liste (Hash)
#.zip lien = https://blog.fourk.io/zip-arrays-ranges-hashes-in-ruby-f63c255dd07c
#a.zip(b) permet d'associer l'element du tableau a et du tableau b (qui est en argument de la methode zip)
# dans une liste parente des deux child array 
  hash_currency_value = Hash[currency.zip(value_without_dollar.map)]

#puts hash_currency_value

#création d'un tableau (array)
  array_currency_value = []

#met chaque element de la liste currency_value " monnaie(index[0]) => sa valeur(index[1]) " dans un tableau à la ligne dans un hash
  hash_currency_value.each {|index| array_currency_value << {index[0] => index[1]}}

  return array_currency_value
end

puts crypto_array
