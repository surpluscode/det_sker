# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create([{ key: :party }, { key: :food }, { key: :exercise },
                 { key: :workshop }, { key: :demo }, { key: :talk },
                { key: :meeting }, { key: :other }])

folkets = {name: 'Folkets Hus',street_address: 'Stengade 50',
           postcode: '2200', town: 'København N.',
           description: 'Folkets Hus er et lokalt, social og politisk brugerstyret hus i hjertet af Nørrebro.',
           longitude: 12.554228, latitude: 55.687301}
bumzen = {name: 'Bumzen', street_address: 'Baldersgade 20-22',
          postcode: '2200', town: 'København N.',
          description: 'BumZen er et aktivistisk kollektiv på ydre Nørrebro som har sit udgangspunkt i udenomsparlamentarisme og er en del af det venstreradikale miljø.',
          longitude:12.544694, latitude: 55.69899}
bolsje = {name: 'BolsjeFabrikken', street_address: 'Ragnhildgade 1 bygning 3',
          postcode: '2100', town: 'København N.',
          description: 'Bolsjefabrikkerne er non-profit, non-kommercielle kulturelle foreninger, som huser sociale og kreative aktiviteter med hjemsted på Ragnhildgade 1 i København.',
          longitude: 12.553738, latitude: 55.708267}
ungdomshuset = {name: 'Ungdomshuset', street_address: 'Dortheavej 61',
          postcode: '2400', town: 'København NV.',
          description: 'Ungdomshuset på Dortheavej 61 er et selvstyrende kulturhus og undergrundsscene for forskellige grupper af fortrinsvis unge, der kulturelt og/eller politisk tager afstand fra det etablerede samfund, beliggende på Dortheavej 61 i Københavns Nordvest-kvarter.',
          longitude: 12.523445, latitude: 55.708801}
kafax = { name: 'Kafa-X', street_address: 'Korsgade 19, kld',
        postcode: '2200', town: 'København N.',
        description: 'Den erklærede feministiske og anti-fascistiske café har holdt åbent på Nørrebro siden 1993. Kafa-X agerer ugentligt mødested for en række projekter på den udenomsparlamentariske venstrefløj. ',
        longitude: 12.557256, latitude: 55.685334}
solihuset = { name: 'SolidaritetsHuset', street_address: 'Griffenfeldsgade 41',
          postcode: '2200', town: 'København N.',
          description: 'Solidaritet består af: Tidsskriftet Solidaritet. Forlaget Solidaritet. Forlaget er et løst samarbejde mellem folk fra forskellige politiske grupperinger og bevægelser med det formål mere metodisk at udgive progressive / socialistiske bøger.
          Trykkeriet. Trykkeriet sørger I første række for at producere tidsskrift og bøger for Solidaritet, men har derudover en række eksterne kunder.',
          longitude: 12.552641, latitude: 55.68585}
Location.create([folkets, bumzen, bolsje, ungdomshuset, kafax, solihuset])
