class VillageData {
  static const Map<String, dynamic> villageInfo = {
    'name': 'Kaprai Pally',
    'totalPopulation': 3065,
    'maleVoters': 1060,
    'femaleVoters': 1040,
    'transgender': 0,
    'children': 720,
    'numberOfHouses': 799,
    'area': '1487 Hectares',
    'literacyRate': '72%',
    'mainOccupation': 'Agriculture',
    'history': 'Kaprai Pally is a village located in Atmakur (M) Mandal of Yadadri Bhuvanagiri District in Telangana, India. It is governed by Khaprai Palle Gram Panchayat. The village has a rich agricultural heritage and a close-knit community.',
  };

  static const Map<String, dynamic> gramPanchayatInfo = {
    'officeName': 'Khaprai Palle Gram Panchayat Office',
    'sarpanch': 'Current Sarpanch',
    'phone': '+91 9876543210',
    'email': 'khapraipalle.gp@telangana.gov.in',
    'timing': '10:00 AM - 5:00 PM',
    'streets': [
      {'name': 'Main Street', 'houses': 120, 'families': 130},
      {'name': 'School Road', 'houses': 85, 'families': 90},
      {'name': 'Temple Lane', 'houses': 45, 'families': 50},
      {'name': 'Market Area', 'houses': 110, 'families': 115},
      {'name': 'Water Tank Street', 'houses': 60, 'families': 65},
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
    {
      'name': 'Anganwadi Centre',
      'location': 'Street 3',
      'students': 45,
      'teachers': 2,
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

  static const List<Map<String, dynamic>> servicesInfo = [
    {
      'title': 'Drinking Water',
      'status': 'Available',
      'description': 'Provided via Mission Bhagiratha project. Daily supply to every household.',
      'icon': 'water_drop',
    },
    {
      'title': 'Electricity',
      'status': '24/7 Supply',
      'description': 'Uninterrupted power supply for both domestic and agricultural needs.',
      'icon': 'bolt',
    },
    {
      'title': 'Waste Management',
      'status': 'Active',
      'description': 'Daily door-to-door garbage collection by Panchayat vehicles.',
      'icon': 'delete_sweep',
    },
    {
      'title': 'Street Lighting',
      'status': '95% Coverage',
      'description': 'LED street lights installed across all main roads and inner streets.',
      'icon': 'lightbulb',
    },
  ];

  static const List<Map<String, dynamic>> directoryInfo = [
    {'name': 'Emergency (Ambulance)', 'contact': '108', 'type': 'Emergency'},
    {'name': 'Police Station', 'contact': '100', 'type': 'Safety'},
    {'name': 'Fire Station', 'contact': '101', 'type': 'Safety'},
    {'name': 'Electricity Board', 'contact': '1912', 'type': 'Utility'},
    {'name': 'Local Health Worker', 'contact': '+91 9988776655', 'type': 'Healthcare'},
    {'name': 'Veterinary Doctor', 'contact': '+91 9900112233', 'type': 'Healthcare'},
  ];
}
