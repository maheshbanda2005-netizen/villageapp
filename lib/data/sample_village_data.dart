import '../models/village_model.dart';

final Village sampleVillage = Village(
  name: "Kaprai Pally",
  history: "Kaprai Pally is a village located in Atmakur (M) Mandal of Yadadri Bhuvanagiri District in Telangana, India. It is governed by Khaprai Palle Gram Panchayat and comes under the Atmakur (m) Community Development Block. The village has a rich social structure with a population density of 206.12 persons per square kilometer. It is situated about 48 kilometers away from the nearest town, Bhongir.",
  area: "1487 Hectares (14.87 sq. km)",
  numberOfSubVillages: 1,
  demographics: Demographics(
    totalPopulation: 3065,
    numberOfHouses: 799,
    numberOfVoters: 2100,
    ageDistribution: {
      "Males": 1539,
      "Females": 1526,
      "Scheduled Castes": 631,
      "Scheduled Tribes": 11,
    },
  ),
  offices: [
    Facility(
      name: "Khaprai Palle Gram Panchayat Office",
      type: "Government Office",
      location: "Kaprai Pally Village",
      description: "Local self-government body for the village.",
    ),
    Facility(
      name: "Post Office",
      type: "Government Office",
      location: "Kaprai Pally (PIN: 508111)",
    ),
  ],
  schools: [
    Facility(
      name: "Government Primary Schools (4)",
      type: "Education",
      location: "Various locations in Kaprai Pally",
      description: "Four government-run primary education centers.",
    ),
    Facility(
      name: "Government Middle School",
      type: "Education",
      location: "Kaprai Pally",
    ),
    Facility(
      name: "Government Secondary School",
      type: "Education",
      location: "Kaprai Pally",
    ),
  ],
  hospitals: [
    Facility(
      name: "Primary Health Sub-Centre",
      type: "Healthcare",
      location: "Kaprai Pally",
      description: "Staffed with 3 paramedical personnel.",
    ),
    Facility(
      name: "Veterinary Hospital",
      type: "Healthcare",
      location: "Kaprai Pally",
      description: "Staffed with 1 doctor and 2 paramedical personnel.",
    ),
    Facility(
      name: "Mobile Health Centre",
      type: "Healthcare",
      location: "Kaprai Pally",
      description: "Providing mobile medical services with 3 paramedical staff.",
    ),
  ],
);
