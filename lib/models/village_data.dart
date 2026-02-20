class VillageData {
  static const Map<String, dynamic> villageInfo = {
    'name': 'Kaprai Pally',
    'totalPopulation': 3065,
    'maleVoters': 1060, // Estimated based on total voters
    'femaleVoters': 1040, // Estimated based on total voters
    'transgender': 0,
    'children': 720,
    'numberOfHouses': 799,
    'area': '1487 Hectares',
    'history': 'Kaprai Pally is a village located in Atmakur (M) Mandal of Yadadri Bhuvanagiri District in Telangana, India. It is governed by Khaprai Palle Gram Panchayat.',
  };

  static const Map<String, dynamic> gramPanchayatInfo = {
    'officeName': 'Khaprai Palle Gram Panchayat Office',
    'sarpanch': 'Current Sarpanch',
    'phone': '+91 XXXXXXXXXX',
    'email': 'khapraipalle.gp@example.com',
    'timing': '10:00 AM - 5:00 PM',
    'streets': [
      {'name': 'Main Street', 'houses': 120, 'families': 130},
      {'name': 'School Road', 'houses': 85, 'families': 90},
      {'name': 'Temple Lane', 'houses': 45, 'families': 50},
      {'name': 'Market Area', 'houses': 110, 'families': 115},
    ],
  };

  static const List<Map<String, dynamic>> schoolInfo = [
    {
      'name': 'Government Primary School 1',
      'location': 'Near Panchayat Office',
      'students': 120,
      'teachers': 5,
    },
    {
      'name': 'Government Secondary School',
      'location': 'Main Road',
      'students': 250,
      'teachers': 12,
    },
  ];

  static const List<Map<String, dynamic>> hospitalInfo = [
    {
      'name': 'Primary Health Sub-Centre',
      'location': 'Kaprai Pally',
      'staff': 3,
      'type': 'Government',
    },
    {
      'name': 'Veterinary Hospital',
      'location': 'Kaprai Pally',
      'staff': 3,
      'type': 'Veterinary',
    },
  ];

  static const List<Map<String, dynamic>> landInfo = [
    {'type': 'Agricultural', 'area': '1200 Hectares', 'owners': 450},
    {'type': 'Residential', 'area': '150 Hectares', 'owners': 799},
    {'type': 'Common Land', 'area': '137 Hectares', 'owners': 1},
  ];

  static const List<Map<String, dynamic>> cropInfo = [
    {'name': 'Paddy', 'season': 'Kharif/Rabi', 'area': '800 Hectares'},
    {'name': 'Cotton', 'season': 'Kharif', 'area': '300 Hectares'},
    {'name': 'Maize', 'season': 'Rabi', 'area': '100 Hectares'},
  ];
}
