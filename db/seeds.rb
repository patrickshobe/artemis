# Builds All Series and then the episodes for those series

SeriesBuilder.build_all
EpisodeBuilder.build_all

# Creates the two apoolo workers
Worker.create( name: 'apollo-1',
               location: 'http://192.168.0.49:3100',
               access_token: 'XJwOmou4jaiyFWx4Q2SM6Q' )

Worker.create( name: 'apollo-2',
               location: 'http://192.168.0.48:3100',
               access_token: 'd5HYJMvYKS0_5QiiLtrVDw')
