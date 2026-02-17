import '../models/village_model.dart';

final Village sampleVillage = Village(
  name: "Green Valley Village",
  history: "Green Valley was founded in the early 19th century by a group of farmers who were drawn to the fertile land and the clean water of the nearby river. Over the decades, it has grown from a small settlement into a thriving community while maintaining its cultural heritage and natural beauty. It is known for its annual harvest festival and the historic banyan tree in the village square.",
  area: "12.5 sq. km",
  numberOfSubVillages: 5,
  demographics: Demographics(
    totalPopulation: 1250,
    numberOfHouses: 310,
    numberOfVoters: 850,
    ageDistribution: {
      "Children (0-14)": 250,
      "Youth (15-24)": 200,
      "Adults (25-59)": 600,
      "Elders (60+)": 200,
    },
  ),
  offices: [
    Facility(
      name: "Village Panchayat Office",
      type: "Government Office",
      location: "Main Square, Near the Clock Tower",
      contact: "012-3456789",
      description: "The primary administrative hub for the village.",
    ),
    Facility(
      name: "Post Office",
      type: "Government Office",
      location: "Post Office Road",
      contact: "012-3456790",
    ),
  ],
  schools: [
    Facility(
      name: "Green Valley Primary School",
      type: "Education",
      location: "School Street, North Sector",
      contact: "012-3456791",
      description: "Providing quality primary education for children aged 5-11.",
    ),
    Facility(
      name: "Village High School",
      type: "Education",
      location: "East Hill Road",
      contact: "012-3456792",
      description: "Secondary education center for the village youth.",
    ),
  ],
  hospitals: [
    Facility(
      name: "Community Health Center",
      type: "Healthcare",
      location: "Hospital Road",
      contact: "012-3456793",
      description: "24/7 basic medical services and emergency care.",
    ),
    Facility(
      name: "Maternity Clinic",
      type: "Healthcare",
      location: "South Wing, Near Market",
      contact: "012-3456794",
    ),
  ],
);
