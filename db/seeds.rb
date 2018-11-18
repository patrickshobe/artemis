# Builds All Series and then the episodes for those series

SeriesBuilder.build_all
EpisodeBuilder.build_all

# Creates the two apoolo workers
Worker.create( name: 'apollo-1',
               location: 'http://localhost:3100',
               access_token: 'XJwOmou4jaiyFWx4Q2SM6Q' )

