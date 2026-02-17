class Village {
  final String name;
  final String history;
  final String area;
  final int numberOfSubVillages;
  final Demographics demographics;
  final List<Facility> offices;
  final List<Facility> schools;
  final List<Facility> hospitals;

  Village({
    required this.name,
    required this.history,
    required this.area,
    required this.numberOfSubVillages,
    required this.demographics,
    required this.offices,
    required this.schools,
    required this.hospitals,
  });
}

class Demographics {
  final int totalPopulation;
  final int numberOfHouses;
  final int numberOfVoters;
  final Map<String, int> ageDistribution; // e.g., {"Elders (60+)": 150, "Adults (18-59)": 450, ...}

  Demographics({
    required this.totalPopulation,
    required this.numberOfHouses,
    required this.numberOfVoters,
    required this.ageDistribution,
  });
}

class Facility {
  final String name;
  final String type;
  final String location;
  final String? contact;
  final String? description;

  Facility({
    required this.name,
    required this.type,
    required this.location,
    this.contact,
    this.description,
  });
}
