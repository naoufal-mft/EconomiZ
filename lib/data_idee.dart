import 'package:flutter/material.dart';

class BudgetIdea {
  final String category;
  final String name;
  final String details;
  final IconData icon;

  BudgetIdea({
    required this.category,
    required this.name,
    required this.details,
    required this.icon,
  });
}


List<BudgetIdea> getTravelDestinations() {
  return [
    BudgetIdea(
      category: 'Voyage',
      name: 'Prague, République tchèque',
      details: 'Coût estimé : Environ 250 euros pour un séjour de 3 jours.\n\nDescription : Prague est une ville charmante connue pour son architecture magnifique, son histoire riche et son atmosphère vibrante. Elle offre une expérience de voyage abordable avec de nombreuses attractions à explorer.\n\nVol : Le coût d\'un vol aller-retour depuis les principales villes de France, comme Paris ou Lyon, vers Prague est d\'environ 120 euros. Recherchez des compagnies aériennes à bas prix ou des tarifs réduits pour obtenir le meilleur tarif.\n\nHébergement : Des hébergements abordables, tels que des auberges de jeunesse et des hôtels économiques, peuvent être trouvés pour environ 30 euros par nuit. Ces options offrent des séjours confortables sans trop solliciter votre budget.\n\nRepas : Profitez de délicieuse cuisine tchèque sans vous ruiner. Vous pouvez trouver des plats copieux et des spécialités locales pour environ 10 euros dans les restaurants et les cafés de Prague. Ne manquez pas de goûter des plats traditionnels comme le goulash et le trdelník.\n\nAttractions : Prague offre de nombreuses attractions qui peuvent être appréciées avec un budget limité. Explorez le célèbre château de Prague, traversez le mythique pont Charles et promenez-vous dans la pittoresque vieille ville. Bon nombre de ces attractions proposent des tarifs d\'entrée abordables voire gratuits.\n\nTransport : Prague dispose d\'un système de transport public efficace et abordable, comprenant des tramways et le métro. Achetez un pass de transport pour des trajets illimités ou utilisez des billets individuels, qui coûtent environ 1 euro par trajet.\n\nActivités supplémentaires : Profitez des activités gratuites ou peu coûteuses à Prague, telles que visiter les marchés locaux, explorer les magnifiques parcs et assister à des spectacles de rue. N\'oubliez pas de déguster la bière tchèque abordable, qui est incontournable lors d\'un séjour à Prague.',
      icon: Icons.airplanemode_active,
    ),
    BudgetIdea(
      category: 'Voyage',
      name: 'Lisbonne, Portugal',
      details: 'Coût estimé : Environ 300 euros pour un séjour de 4 jours.\n\nDescription : Lisbonne est une destination vibrante et abordable, offrant un mélange de charme historique, de culture animée et de magnifiques vues côtières. Explorez le riche patrimoine de la ville sans trop solliciter votre portefeuille.\n\nVol : Le coût d\'un vol aller-retour depuis les principales villes de France, comme Paris ou Marseille, vers Lisbonne est d\'environ 150 euros. Recherchez les offres et les promotions pour obtenir le meilleur prix.\n\nHébergement : Des hébergements abordables, tels que des maisons d\'hôtes et des hôtels économiques, peuvent être trouvés pour environ 40 euros par nuit. Ces options offrent des séjours confortables et un accès facile aux attractions de Lisbonne.\n\nRepas : Régalez-vous de délicieuse cuisine portugaise avec un budget limité. Dégustez des plats locaux tels que le bacalhau (morue salée), les pastéis de nata (tartes aux flans) et les sardines grillées pour environ 12 euros par repas dans les restaurants et les cafés locaux.\n\nAttractions : Découvrez les quartiers historiques de Lisbonne, tels que l\'Alfama et le Bairro Alto, et visitez des monuments emblématiques tels que la tour de Belém et le château de São Jorge. De nombreuses attractions proposent des tarifs d\'entrée abordables, tandis que certaines, comme les points de vue et l\'art de rue, peuvent être appréciées gratuitement.\n\nTransport : Lisbonne dispose d\'un système de transport public efficace, comprenant des tramways, des bus et le métro. Achetez une carte de transport rechargeable pour bénéficier de tarifs réduits, qui coûtent généralement environ 6 euros par jour.\n\nActivités supplémentaires : Explorez les marchés animés de Lisbonne, détendez-vous sur les magnifiques plages de Cascais ou de Costa da Caparica, et prenez des trajets panoramiques en tramway à travers les ruelles de la ville. Ne manquez pas l\'occasion de découvrir le Fado, la musique portugaise émouvante.',
      icon: Icons.airplanemode_active,
    ),
    BudgetIdea(
      category: 'Voyage',
      name: 'Budapest, Hongrie',
      details: 'Coût estimé : Environ 300 euros pour un séjour de 3 jours.\n\nDescription : Budapest offre un mélange fascinant d\'histoire, d\'architecture magnifique et de bains thermaux, le tout à un prix abordable. Découvrez la "Perle du Danube" sans trop solliciter votre budget de voyage.\n\nVol : Le coût d\'un vol aller-retour depuis les principales villes de France, comme Paris ou Bordeaux, vers Budapest est d\'environ 130 euros. Recherchez les compagnies aériennes à bas prix ou les tarifs réduits pour obtenir la meilleure offre.\n\nHébergement : Budapest propose une gamme d\'hébergements abordables, tels que des hôtels économiques et des auberges de jeunesse, avec des prix à partir d\'environ 25 euros par nuit. Séjournez dans le centre-ville pour un accès pratique aux attractions.\n\nRepas : Savourez une cuisine hongroise copieuse sans trop dépenser. Vous pouvez déguster des spécialités locales comme le goulash, le langos (beignets frits) et le gâteau cheminée pour environ 10 euros par repas dans les restaurants locaux et les stands de street food.\n\nAttractions : Visitez les monuments emblématiques de Budapest, tels que le château de Buda, le Parlement hongrois et le Bastion des pêcheurs. De nombreuses attractions proposent des tarifs d\'entrée abordables, et vous pouvez profiter gratuitement de vues panoramiques depuis la colline de Gellért et les rives du Danube.\n\nTransport : Budapest dispose d\'un système de transport public efficace et abordable, comprenant le métro, les tramways et les bus. Achetez un pass de transport ou utilisez des billets individuels, qui coûtent environ 1 euro par trajet, pour explorer la ville.\n\nActivités supplémentaires : Détendez-vous dans les célèbres bains thermaux de Budapest, tels que les bains Széchenyi ou Gellért, pour une expérience relaxante et abordable. Explorez les bars en ruine animés, découvrez les marchés locaux et faites une croisière panoramique sur le Danube pour un séjour mémorable.',
      icon: Icons.airplanemode_active,
    ),
  ];
}

List<BudgetIdea> getEasyMeals() {
  return [
    BudgetIdea(
      category: 'Repas',
      name: 'Quinoa aux légumes rôtis',
      details: 'Coût estimé : Environ 6 euros par portion.\n\nDescription : Ce plat de quinoa aux légumes rôtis est à la fois nourrissant, délicieux et économique. Les légumes rôtis ajoutent une saveur riche et les graines de quinoa fournissent une source de protéines végétales.\n\nIngrédients :\n- Quinoa : 2 euros\n- Assortiment de légumes (comme des courgettes, des tomates, des poivrons et des oignons) : 3 euros\n- Huile d\'olive, ail, herbes de Provence (pour assaisonner) : 1 euro\n\nInstructions :\n1. Rincez le quinoa à l\'eau froide pour éliminer l\'amertume. Ensuite, faites bouillir 2 volumes d\'eau salée pour 1 volume de quinoa. Ajoutez le quinoa dans l\'eau bouillante, réduisez le feu et laissez cuire pendant environ 15 minutes jusqu\'à ce que les grains soient tendres et que l\'eau soit absorbée. Couvrez et réservez.\n2. Préchauffez votre four à 200°C.\n3. Préparez les légumes en les coupant en morceaux de taille similaire. Placez les légumes sur une plaque de cuisson recouverte de papier sulfurisé.\n4. Dans un petit bol, mélangez l\'huile d\'olive, l\'ail émincé et les herbes de Provence. Arrosez ce mélange sur les légumes et mélangez-les pour bien les enrober.\n5. Placez la plaque de cuisson au four préchauffé et faites rôtir les légumes pendant environ 20-25 minutes, en les retournant à mi-cuisson, jusqu\'à ce qu\'ils soient tendres et légèrement dorés.\n6. Une fois les légumes rôtis prêts, ajoutez-les au quinoa cuit et mélangez délicatement pour les incorporer.\n7. Servez le quinoa aux légumes rôtis chaud ou à température ambiante.',
      icon: Icons.restaurant,
    ),
    BudgetIdea(
      category: 'Repas',
      name: 'Soupe aux lentilles épicées',
      details: 'Coût estimé : Environ 4 euros par portion.\n\nDescription : Cette soupe aux lentilles épicées est réconfortante, savoureuse et abordable. Elle est parfaite pour les jours frais et constitue un repas complet.\n\nIngrédients :\n- Lentilles (vertes ou brunes) : 1 euro\n- Assortiment de légumes (comme des carottes, des poireaux et des tomates) : 2 euros\n- Bouillon de légumes : 1 euro\n- Épices (comme le cumin, le curcuma, le paprika et la cannelle) : 1 euro\n\nInstructions :\n1. Rincez les lentilles à l\'eau froide pour les nettoyer. Dans une casserole, ajoutez les lentilles et couvrez-les d\'eau. Portez à ébullition, puis réduisez le feu et laissez mijoter pendant environ 20-25 minutes, jusqu\'à ce que les lentilles soient tendres mais encore légèrement fermes. Égouttez-les et réservez.\n2. Pendant ce temps, préparez les légumes en les coupant en dés. Par exemple, coupez les carottes en rondelles, les poireaux en tronçons et les tomates en cubes.\n3. Dans une grande casserole, faites chauffer un peu d\'huile d\'olive. Ajoutez les légumes coupés et faites-les revenir pendant quelques minutes jusqu\'à ce qu\'ils soient légèrement ramollis.\n4. Ajoutez les lentilles cuites dans la casserole avec les légumes. Versez le bouillon de légumes et ajoutez les épices de votre choix, comme le cumin, le curcuma, le paprika et une pincée de cannelle. Mélangez bien tous les ingrédients.\n5. Portez la soupe à ébullition, puis réduisez le feu et laissez mijoter pendant environ 20 minutes pour que les saveurs se mélangent.\n6. Une fois la soupe prête, ajustez l\'assaisonnement avec du sel et du poivre selon votre goût.\n7. Servez la soupe aux lentilles épicées bien chaude, accompagnée de pain croûté ou de craquelins.',
      icon: Icons.restaurant,
    ),
    BudgetIdea(
      category: 'Repas',
      name: 'Salade de couscous méditerranéenne',
      details: 'Coût estimé : Environ 5 euros par portion.\n\nDescription : Cette salade de couscous méditerranéenne est légère, fraîche et économique. Elle est parfaite pour les repas légers et estivaux.\n\nIngrédients :\n- Couscous : 1 euro\n- Assortiment de légumes (comme des concombres, des tomates, des poivrons et des oignons rouges) : 3 euros\n- Olives noires : 1 euro\n- Fromage féta : 1 euro\n\nInstructions :\n1. Préparez le couscous en suivant les instructions sur l\'emballage. Généralement, il suffit de verser de l\'eau bouillante sur le couscous et de le laisser reposer pendant quelques minutes jusqu\'à ce qu\'il soit tendre et léger. Égrenez le couscous à l\'aide d\'une fourchette pour éviter qu\'il ne forme des grumeaux.\n2. Pendant que le couscous refroidit, préparez les légumes en les coupant en dés. Par exemple, coupez les concombres, les tomates et les poivrons en petits cubes. Émincez les oignons rouges.\n3. Dans un grand saladier, mélangez le couscous refroidi avec les légumes coupés en dés.\n4. Ajoutez les olives noires dénoyautées à la salade pour ajouter une touche de saveur salée.\n5. Émiettez le fromage féta sur la salade pour ajouter une texture crémeuse et salée.\n6. Si vous le souhaitez, ajoutez un filet d\'huile d\'olive et de jus de citron pour assaisonner la salade. Mélangez tous les ingrédients pour bien les enrober.\n7. Servez la salade de couscous méditerranéenne à température ambiante ou réfrigérée. Elle est délicieuse en accompagnement d\'un barbecue ou en plat principal léger.',
      icon: Icons.restaurant,
    ),
  ];
}

List<BudgetIdea> getActivities() {
  return [
    BudgetIdea(
      category: 'Activités',
      name: 'Pique-nique dans le parc',
      details: 'Coût estimé : Gratuit ou à coût minimal.\n\nDescription : Profitez d\'un pique-nique relaxant dans un parc à proximité ou dans un espace vert. C\'est une façon économique de passer du temps de qualité en plein air et de se connecter avec la nature.\n\nDétails de l\'activité :\n\nTrouvez un parc local ou une zone verte avec des tables de pique-nique ou des espaces ouverts.\nPréparez un pique-nique maison avec des sandwiches, des fruits, des collations et des boissons.\nApportez une couverture pour vous asseoir et des jeux d\'extérieur ou un jeu de cartes pour vous divertir.\nPassez la journée à profiter de l\'air frais, à jouer à des jeux et à pique-niquer en famille ou entre amis.',
      icon: Icons.park,
    ),
    BudgetIdea(
      category: 'Activités',
      name: 'Explorer les musées locaux',
      details: 'Coût estimé : Variable, mais certains musées offrent une entrée gratuite ou à prix réduit.\n\nDescription : Profitez des offres culturelles de votre région en visitant les musées locaux ou les galeries d\'art. C\'est une activité enrichissante et abordable qui vous permet d\'apprendre et d\'apprécier l\'art, l\'histoire et les sciences.\n\nDétails de l\'activité :\n\nRenseignez-vous sur les musées et les galeries locales dans votre ville ou les villes avoisinantes.\nConsultez leurs sites web pour connaître les offres spéciales, les journées d\'entrée gratuite ou les billets à prix réduit.\nPlanifiez votre visite et prévoyez suffisamment de temps pour explorer les expositions.\nPrenez le temps d\'apprécier les œuvres d\'art, de lire les descriptions et de vous plonger dans les expositions.\nCertains musées peuvent avoir des jardins extérieurs ou des espaces à explorer également.',
      icon: Icons.museum,
    ),
    BudgetIdea(
      category: 'Activités',
      name: 'Randonnée pédestre ou promenade en pleine nature',
      details: 'Coût estimé : Gratuit ou à coût minimal.\n\nDescription : Profitez de la beauté naturelle qui vous entoure en faisant une randonnée pédestre ou une promenade en pleine nature. C\'est une activité revigorante qui vous permet d\'explorer des sentiers pittoresques, de profiter de l\'air frais et de vous connecter avec la nature.\n\nDétails de l\'activité :\n\nRenseignez-vous sur les sentiers de randonnée à proximité, les réserves naturelles ou les parcs offrant des itinéraires panoramiques.\nChoisissez un sentier adapté à votre niveau de forme physique et au temps dont vous disposez.\nPortez des chaussures confortables et des vêtements appropriés pour la météo.\nPréparez un sac à dos avec de l\'eau, des collations et un appareil photo pour capturer de beaux moments.\nSuivez les balises du sentier, restez sur les chemins désignés et respectez les consignes de sécurité.\nFaites des pauses en cours de route pour apprécier les environs, prendre des photos et profiter de la tranquillité de la nature.',
      icon: Icons.directions_walk,
    ),
  ];
}

List<BudgetIdea> getShops() {
  return [
    BudgetIdea(
      category: 'Shopping',
      name: 'NoFrills Supermarché',
      details: 'Villes :\n\n'
          'Marseille\n'
          'Toulouse\n\n'
          'Détails :\n\n'
          'NoFrills Supermarché est une chaîne présente dans plusieurs grandes villes de France.\n'
          'Ils proposent une large gamme de produits alimentaires et ménagers à des prix abordables.\n'
          'Les magasins NoFrills se concentrent principalement sur les produits de base et les marques génériques pour offrir des économies significatives aux consommateurs.\n'
          'Ils offrent également des promotions régulières pour aider les clients à réaliser davantage d\'économies.',
           icon: Icons.shopping_cart,
    ),
    BudgetIdea(
      category: 'Shopping',
      name: 'Aldi Supermarché',
      details: 'Villes :\n\n'
          'Valenciennes\n'
          'Douai\n'
          'Anger\n'
          'Bourges\n'
          'Orléans\n'
          'Limoges\n'
          'Nantes\n\n'
          "ALDI se trouve dans plein d'autres villes"
          'Détails :\n\n'
          'Aldi Supermarché est une chaîne présente dans plusieurs grandes villes de France, y compris Paris, Marseille, Lyon, Toulouse, Bordeaux, Strasbourg et Nantes.\n'
          'Ils proposent une large gamme de produits alimentaires et ménagers à des prix abordables.\n'
          'Les magasins Aldi se concentrent principalement sur les produits de base et les marques génériques pour offrir des économies significatives aux consommateurs.\n'
          "Ils offrent également des promotions régulières pour aider les clients à réaliser davantage d'économies.",
          icon: Icons.shopping_cart,
    ),

    BudgetIdea(
      category: 'Shopping',
      name: 'Colruyt Supermarché',
      details: 'Villes :\n\n'
          'Paris\n'
          'Marseille\n'
          'Lyon\n'
          'Toulouse\n'
          'Bordeaux\n'
          'Nantes\n'
          'Rennes\n\n'
          "Colruyt se trouve dans plein d'autres villes"
          'Détails :\n\n'
          'Colruyt Supermarché est une chaîne présente dans plusieurs grandes villes de France, y compris Paris, Marseille, Lyon, Toulouse, Bordeaux, Nantes et Rennes.\n'
          'Ils proposent une large gamme de produits alimentaires, ainsi que des articles ménagers, des produits de soins personnels et des produits non alimentaires.\n'
          "Colruyt se distingue par sa politique de prix bas et son engagement envers la durabilité et l'économie circulaire.\n"
          'Ils offrent également un service de collecte en ligne appelé "Collect&Go" pour plus de commodité.',
          icon: Icons.shopping_cart,
    ),
  ];
}
