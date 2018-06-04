# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Info.delete_all

introduction = Info.create(:name => "introduction", :content => "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam scelerisque massa id lacinia pretium. Phasellus aliquam vitae est sed viverra. Donec pretium arcu sed sem condimentum, sit amet maximus lectus auctor. Sed aliquet odio in magna molestie, at vulputate magna malesuada. In sollicitudin nibh sit amet odio congue pellentesque. Cras rhoncus fermentum vulputate. Nullam tristique, nibh in elementum finibus, sapien tortor feugiat nibh, dictum luctus orci erat ac orci. Donec sit amet odio et lacus pellentesque ultrices eget nec odio. Aliquam semper mi dolor. Cras vel cursus tortor, eget tempus sem. Nunc at tincidunt mauris. Morbi vestibulum vitae justo convallis semper. Phasellus vel porttitor ex. Sed in egestas nisi.")

help = Info.create(:name => "how we can help you", :content => "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam scelerisque massa id lacinia pretium. Phasellus aliquam vitae est sed viverra. Donec pretium arcu sed sem condimentum, sit amet maximus lectus auctor. Sed aliquet odio in magna molestie, at vulputate magna malesuada. In sollicitudin nibh sit amet odio congue pellentesque. Cras rhoncus fermentum vulputate. Nullam tristique, nibh in elementum finibus, sapien tortor feugiat nibh, dictum luctus orci erat ac orci. Donec sit amet odio et lacus pellentesque ultrices eget nec odio. Aliquam semper mi dolor. Cras vel cursus tortor, eget tempus sem. Nunc at tincidunt mauris. Morbi vestibulum vitae justo convallis semper. Phasellus vel porttitor ex. Sed in egestas nisi.")

organisation = Info.create(:name => "organisation", :content => "Archimedes Earth")

email = Info.create(:name => "email", :content => "fsqualitymark@gmail.com")

phone = Info.create(:name => "phone", :content => "0114 283 4062")

puts "done!"
