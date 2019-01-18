 # ligne très importante qui appelle la gem.
require 'nokogiri'
require 'rubygems'
require 'open-uri'

#methode get_townhall_name qui sors de la page les noms des villes 
def get_townhall_name
page = Nokogiri::HTML(open("http://www.annuaire-des-mairies.com/val-d-oise.html"))
#creation du tableau townhall_array
townhall_array = []
#récupération du contenu de la balise attribut avec la class "lientxt" qui contient le nom des villes
  page.xpath('//a[@class = "lientxt"]').each do |townhall_name|

     townhall_array  << townhall_name.text

  end

  return townhall_array
end
#puts townhall_array
#création de l'argument qui contient l'array des nom de ville
townhall = get_townhall_name
#quel site est utilisé pour le scrapping
page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/95/"))

#creation de la variable haf_links qui contient le morceau de lien pour chaque ville ville.html
half_links = page.xpath('//a/@href')

#création d'une array vide "email"
email = []
#pour chaque element link de l'array half_links
half_links.each do |link|
#creation des sites de scrapping en combinant le début du lien et chaque half_links, afin de récupéré l'xpath des emails pour chaque page perso et intégrer le string dans l'array email
    page_annuaire = Nokogiri::HTML(open("http://annuaire-des-mairies.com/95/#{link}"))
    page_annuaire.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').each do |mail|
        email << mail.text
    end
    
end
#a.zip(b) permet d'associer l'element du tableau a et du tableau b (qui est en argument de la methode zip)
# dans une liste parente des deux child array
hash_townhall_email = Hash[townhall.zip(email.map)]
array_townhall_email = []
#met chaque element de la liste tonhall_email " twonhall(index[0]) => email(index[1]) " dans un tableau à la ligne dans un hash
hash_townhall_email.each {|index| array_townhall_email << {index[0] => index[1]}}

puts array_townhall_email
