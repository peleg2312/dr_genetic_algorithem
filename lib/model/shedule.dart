import 'dart:collection';
import 'dart:math';

import 'package:dr_app/provider/appointment_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'doctor.dart';
import 'gene.dart';
import 'individual.dart';
import 'patient.dart';
import 'population.dart';

class Schedule {
  late Population population;
  late Individual fittest;
  late Individual secondFittest;
  int generationCount = 1000;
  late HashMap<int, Patient> patients;
  late HashMap<int, Doctor> doctors;
  late BuildContext context;
  var rng = Random();

  Schedule(HashMap<int, Doctor> doctors, HashMap<int, Patient> patients, BuildContext context) {
    this.doctors = doctors;
    this.patients = patients;
    this.context = context;
    population = Population(patients: this.patients, doctors: this.doctors);
  }

  Future<void> runGeneticAlgorithm() async {
    population.individuals.sort((a, b) => b.fitness.compareTo(a.fitness));
    for (int i = 0; i < generationCount; i++) {
      if (population.individuals[0].fitness == 0) {
        break;
      }
      int populationLength = population.individuals.length;
      population.individuals = population.individuals.sublist(0, populationLength ~/ 5);

      for (int i = 0; i < populationLength / 5; i++) {
        crossover(population.individuals[rng.nextInt(populationLength ~/ 5)],
            population.individuals[rng.nextInt(populationLength ~/ 5)]);
      }

      for (int i = 0; i < populationLength / 5; i++) {
        mutate(population.individuals[rng.nextInt(populationLength ~/ 5)]);
      }

      for (int i = 0; i < populationLength / 5; i++) {
        population.individuals.add(new Individual(doctors, patients));
      }

      population.calculateFitness();
      population.individuals.sort((a, b) => b.fitness.compareTo(a.fitness));
    }
    Provider.of<AppointmentProvider>(context, listen: false).addAppoitnmentsToFirebase(population.individuals[0]);
  }

  bool _geneExists(List<List<Gene>> genes, Gene gene) {
    for (var days in genes) {
      for (var g in days) {
        if (g.patient.Id == gene.patient.Id) {
          return true;
        }
      }
    }
    return false;
  }

  int countGenes(List<List<Gene>> genesList) {
    int count = 0;
    for (var sublist in genesList) {
      count += sublist.length;
    }
    return count;
  }

  void crossover(Individual parent1, Individual parent2) {
    Individual child1 = Individual.WithAddingGenes(doctors, patients);
    int length = rng.nextInt(patients.length);
    int i = 0;
    int j = 0;
    for (var gene in parent1.genes) {
      for (var g in gene) {
        if (i == length) {
          break;
        }
        child1.genes[j].add(g);
        child1.doctors[g.doctor.Id]?.avelability[g.day][(g.time - g.doctor.startTime) * 2] = true;
        i++;
      }
      j++;
    }

    i = 0;
    j = 0;
    for (var gene in parent2.genes) {
      for (var g in gene) {
        if (!_geneExists(child1.genes, g) &&
            child1.doctors[g.doctor.Id]!.checkAvelability((g.time - g.doctor.startTime), g.day)) {
          child1.genes[j].add(g);
          child1.doctors[g.doctor.Id]?.avelability[g.day][(g.time - g.doctor.startTime) * 2] = true;
        } else if (!_geneExists(child1.genes, g) &&
            !child1.doctors[g.doctor.Id]!.checkAvelability((g.time - g.doctor.startTime), g.day)) {
          Doctor altDoctor = g.doctor;
          Gene newG = parent1.findPatient(g.patient.Id);
          if (child1.doctors[newG.doctor.Id]!.checkAvelability((newG.time - newG.doctor.startTime), newG.day) &&
              !_geneExists(child1.genes, newG)) {
            child1.genes[j].add(newG);
            child1.doctors[newG.doctor.Id]?.avelability[newG.day][(newG.time - newG.doctor.startTime) * 2] = true;
          } else {
            int altTime = rng.nextInt(g.doctor.endTime - g.doctor.startTime) + g.doctor.startTime;
            int altDay = rng.nextInt(5);

            int i = 0;
            while (!child1.doctors[altDoctor.Id]!.checkAvelability((altTime - altDoctor.startTime), altDay)) {
              altTime = rng.nextInt(altDoctor.endTime - altDoctor.startTime) + altDoctor.startTime;
              altDay = rng.nextInt(5);
              i++;
              if (i >= 5) {
                altDoctor = doctors.values.elementAt(rng.nextInt(doctors.length));
              }
            }
            child1.genes[j].add(new Gene(patient: g.patient, doctor: altDoctor, time: altTime, day: altDay));
            child1.doctors[altDoctor.Id]?.avelability[altDay][(altTime - altDoctor.startTime) * 2] = true;
          }
        }
        i++;
      }
      j++;
    }
    child1.calcFitness();
    population.individuals.add(child1);

    Individual child2 = Individual.WithAddingGenes(doctors, patients);
    i = 0;
    j = 0;
    for (var gene in parent2.genes) {
      for (var g in gene) {
        if (i == length) {
          break;
        }
        child2.genes[j].add(g);
        child2.doctors[g.doctor.Id]?.avelability[g.day][(g.time - g.doctor.startTime) * 2] = true;
        i++;
      }
      j++;
    }

    i = 0;
    j = 0;
    for (var gene in parent1.genes) {
      for (var g in gene) {
        if (!_geneExists(child2.genes, g) &&
            child2.doctors[g.doctor.Id]!.checkAvelability((g.time - g.doctor.startTime), g.day)) {
          child2.genes[j].add(g);
          child2.doctors[g.doctor.Id]?.avelability[g.day][(g.time - g.doctor.startTime) * 2] = true;
        } else if (!_geneExists(child2.genes, g) &&
            !child2.doctors[g.doctor.Id]!.checkAvelability((g.time - g.doctor.startTime), g.day)) {
          Doctor altDoctor = g.doctor;
          Gene newG = parent2.findPatient(g.patient.Id);
          if (child2.doctors[newG.doctor.Id]!.checkAvelability((newG.time - newG.doctor.startTime), newG.day) &&
              !_geneExists(child2.genes, newG)) {
            child2.genes[j].add(newG);
            child2.doctors[newG.doctor.Id]?.avelability[newG.day][(newG.time - newG.doctor.startTime) * 2] = true;
          } else {
            int altTime = rng.nextInt(g.doctor.endTime - g.doctor.startTime) + g.doctor.startTime;
            int altDay = rng.nextInt(5);
            int i = 0;
            while (!child2.doctors[altDoctor.Id]!.checkAvelability((altTime - altDoctor.startTime), altDay)) {
              altTime = rng.nextInt(altDoctor.endTime - altDoctor.startTime) + altDoctor.startTime;
              altDay = rng.nextInt(5);
              i++;
              if (i >= 5) {
                altDoctor = doctors.values.elementAt(rng.nextInt(doctors.length));
              }
            }
            child2.genes[j].add(new Gene(patient: g.patient, doctor: altDoctor, time: altTime, day: altDay));
            child2.doctors[altDoctor.Id]?.avelability[altDay][(altTime - altDoctor.startTime) * 2] = true;
          }
        }
        i++;
      }
      j++;
    }

    child2.calcFitness();
    population.individuals.add(child2);
  }

  void mutate(Individual individual) {
    var rng = Random();
    Individual mutate = new Individual.WithAddingGenes(doctors, patients);

    for (int i = 0; i < individual.genes.length; i++) {
      for (var gene in individual.genes[i]) {
        int altTime = gene.time;
        int altDay = gene.day;
        Doctor altDoctor = gene.doctor;
        if (rng.nextDouble() < 0.1) {
          do {
            double rChange = rng.nextDouble();
            if (rChange < 0.2) {
              altDoctor = doctors.values.elementAt(rng.nextInt(doctors.length));

              while (altTime < altDoctor.startTime && altTime > altDoctor.endTime) {
                altTime = rng.nextInt(altDoctor.endTime - altDoctor.startTime) + altDoctor.startTime;
              }
            } else if (rChange < 0.6) {
              altTime = rng.nextInt(altDoctor.endTime - altDoctor.startTime) + altDoctor.startTime;
            } else {
              altDay = rng.nextInt(5);
            }
          } while (!mutate.doctors[altDoctor.Id]!.checkAvelability(altTime - altDoctor.startTime, altDay));
          Gene newG = Gene(patient: gene.patient, doctor: altDoctor, time: altTime, day: altDay);
          mutate.genes[altDay].add(newG);
          mutate.doctors[altDoctor.Id]?.avelability[altDay][(altTime - altDoctor.startTime) * 2] = true;
        } else {
          while (!mutate.doctors[altDoctor.Id]!.checkAvelability(altTime - altDoctor.startTime, altDay)) {
            altDoctor = doctors.values.elementAt(rng.nextInt(doctors.length));
            altTime = rng.nextInt(altDoctor.endTime - altDoctor.startTime) + altDoctor.startTime;
            altDay = rng.nextInt(5);
          }
          Gene newG = Gene(patient: gene.patient, doctor: altDoctor, time: altTime, day: altDay);
          mutate.genes[altDay].add(newG);
          mutate.doctors[altDoctor.Id]?.avelability[altDay][(altTime - altDoctor.startTime) * 2] = true;
        }
      }
    }
    mutate.calcFitness();

    population.individuals.add(mutate);
  }
}

void main(List<String> args) {
  Doctor doctor1 = Doctor(
    name: "Dr. Smith",
    specialization: "Cardiologist",
    startTime: 9, // Example start time
    endTime: 17, // Example end time
    Id: 0,
  );
  Doctor doctor2 = Doctor(
    name: "Dr. Johnson",
    specialization: "Dermatologist",
    startTime: 10, // Example start time
    endTime: 18, // Example end time
    Id: 1,
  );
  Doctor doctor3 = Doctor(
    name: "Dr. Williams",
    specialization: "Neurologist",
    startTime: 8, // Example start time
    endTime: 16, // Example end time
    Id: 2,
  );
  Doctor doctor4 = Doctor(
    name: "Dr. Brown",
    specialization: "Orthopedic Surgeon",
    startTime: 9, // Example start time
    endTime: 17, // Example end time
    Id: 3,
  );
  Doctor doctor5 = Doctor(
    name: "Dr. Lee",
    specialization: "Pediatrician",
    startTime: 8, // Example start time
    endTime: 16, // Example end time
    Id: 4,
  );

  // Create patients
  Patient patient1 = Patient(
    name: "John Doe",
    healthCondition: "Heart Disease",
    preferredDoctorName: "Dr. Smith",
    Id: 0,
    preferredDay: 2, // Example preferred date
    preferredTime: 13, // Example preferred time
  );
  Patient patient2 = Patient(
    name: "Jane Doe",
    healthCondition: "Skin Condition",
    preferredDoctorName: "Dr. Johnson",
    Id: 1,
    preferredDay: 2, // Example preferred date
    preferredTime: 11, // Example preferred time
  );
  Patient patient3 = Patient(
    name: "Alice Smith",
    healthCondition: "Migraine",
    preferredDoctorName: "Dr. Williams",
    Id: 2,
    preferredDay: 1, // Example preferred date
    preferredTime: 9, // Example preferred time
  );
  Patient patient4 = Patient(
    name: "Michael Johnson",
    healthCondition: "Allergy",
    preferredDoctorName: "Dr. Brown",
    Id: 3,
    preferredDay: 1, // Example preferred date
    preferredTime: 14, // Example preferred time
  );
  Patient patient5 = Patient(
    name: "Emily Williams",
    healthCondition: "Chronic Pain",
    preferredDoctorName: "Dr. Lee",
    Id: 4,
    preferredDay: 3, // Example preferred date
    preferredTime: 11, // Example preferred time
  );
  Patient patient6 = Patient(
    name: "DavId Brown",
    healthCondition: "Asthma",
    preferredDoctorName: "Dr. Brown",
    Id: 5,
    preferredDay: 2, // Example preferred date
    preferredTime: 11, // Example preferred time
  );
  Patient patient7 = Patient(
    name: "Sophia Martinez",
    healthCondition: "Diabetes",
    preferredDoctorName: "Dr. Smith",
    Id: 6,
    preferredDay: 3, // Example preferred date
    preferredTime: 15, // Example preferred time
  );
  Patient patient8 = Patient(
    name: "James Wilson",
    healthCondition: "High Blood Pressure",
    preferredDoctorName: "Dr. Johnson",
    Id: 7,
    preferredDay: 1, // Example preferred date
    preferredTime: 12, // Example preferred time
  );
  Patient patient9 = Patient(
    name: "Olivia Taylor",
    healthCondition: "Anxiety",
    preferredDoctorName: "Dr. Brown",
    Id: 8,
    preferredDay: 5, // Example preferred date
    preferredTime: 1, // Example preferred time
  );
  Patient patient10 = Patient(
    name: "William Garcia",
    healthCondition: "Depression",
    preferredDoctorName: "Dr. Lee",
    Id: 9,
    preferredDay: 4, // Example preferred date
    preferredTime: 12, // Example preferred time
  );
  Patient patient11 = Patient(
    name: "Isabella Rodriguez",
    healthCondition: "Arthritis",
    preferredDoctorName: "Dr. Smith",
    Id: 10,
    preferredDay: 5, // Example preferred date
    preferredTime: 10, // Example preferred time
  );
  Patient patient12 = Patient(
    name: "Daniel Martinez",
    healthCondition: "Insomnia",
    preferredDoctorName: "Dr. Johnson",
    Id: 11,
    preferredDay: 3, // Example preferred date
    preferredTime: 10, // Example preferred time
  );
  Patient patient13 = Patient(
    name: "Mia Wilson",
    healthCondition: "Allergy",
    preferredDoctorName: "Dr. Brown",
    Id: 12,
    preferredDay: 2, // Example preferred date
    preferredTime: 16, // Example preferred time
  );
  Patient patient14 = Patient(
    name: "Logan Garcia",
    healthCondition: "Stress",
    preferredDoctorName: "Dr. Lee",
    Id: 13,
    preferredDay: 2, // Example preferred date
    preferredTime: 13, // Example preferred time
  );
  Patient patient15 = Patient(
    name: "Sophia Anderson",
    healthCondition: "Asthma",
    preferredDoctorName: "Dr. Johnson",
    Id: 14,
    preferredDay: 3, // Example preferred date
    preferredTime: 13, // Example preferred time
  );

  HashMap<int, Doctor> doctors = HashMap<int, Doctor>.from(
      {doctor1.Id: doctor1, doctor2.Id: doctor2, doctor3.Id: doctor3, doctor4.Id: doctor4, doctor5.Id: doctor5});
  HashMap<int, Patient> patients = HashMap<int, Patient>.from({
    patient1.Id: patient1,
    patient2.Id: patient2,
    patient3.Id: patient3,
    patient4.Id: patient4,
    patient5.Id: patient5,
    patient6.Id: patient6,
    patient7.Id: patient7,
    patient8.Id: patient8,
    patient9.Id: patient9,
    patient10.Id: patient10,
    patient11.Id: patient11,
    patient12.Id: patient12,
    patient13.Id: patient13,
    patient14.Id: patient14,
    patient15.Id: patient15
  });

  Patient patient16 = Patient(
    name: "Aiden Martinez",
    healthCondition: "High Blood Pressure",
    preferredDoctorName: "Dr. Smith",
    Id: 15,
    preferredDay: 5, // Example preferred date
    preferredTime: 14, // Example preferred time
  );
  Patient patient17 = Patient(
    name: "Ella Wilson",
    healthCondition: "Chronic Pain",
    preferredDoctorName: "Dr. Lee",
    Id: 16,
    preferredDay: 5, // Example preferred date
    preferredTime: 15, // Example preferred time
  );
  Patient patient18 = Patient(
    name: "Jackson Taylor",
    healthCondition: "Asthma",
    preferredDoctorName: "Dr. Brown",
    Id: 17,
    preferredDay: 4, // Example preferred date
    preferredTime: 10, // Example preferred time
  );
  Patient patient19 = Patient(
    name: "Madison Garcia",
    healthCondition: "Diabetes",
    preferredDoctorName: "Dr. Smith",
    Id: 18,
    preferredDay: 4, // Example preferred date
    preferredTime: 12, // Example preferred time
  );
  Patient patient20 = Patient(
    name: "Lucas Anderson",
    healthCondition: "Migraine",
    preferredDoctorName: "Dr. Lee",
    Id: 19,
    preferredDay: 3, // Example preferred date
    preferredTime: 14, // Example preferred time
  );

  // Add the new patients to the patients HashMap
  patients.addAll({
    patient16.Id: patient16,
    patient17.Id: patient17,
    patient18.Id: patient18,
    patient19.Id: patient19,
    patient20.Id: patient20,
  });

  Patient patient21 = Patient(
    name: "Oliver Brown",
    healthCondition: "Asthma",
    preferredDoctorName: "Dr. Brown",
    Id: 20,
    preferredDay: 4, // Example preferred date
    preferredTime: 13, // Example preferred time
  );
  Patient patient22 = Patient(
    name: "Amelia Lee",
    healthCondition: "Depression",
    preferredDoctorName: "Dr. Lee",
    Id: 21,
    preferredDay: 5, // Example preferred date
    preferredTime: 10, // Example preferred time
  );
  Patient patient23 = Patient(
    name: "Henry Smith",
    healthCondition: "Diabetes",
    preferredDoctorName: "Dr. Smith",
    Id: 22,
    preferredDay: 4, // Example preferred date
    preferredTime: 15, // Example preferred time
  );
  Patient patient24 = Patient(
    name: "Charlotte Johnson",
    healthCondition: "Migraine",
    preferredDoctorName: "Dr. Johnson",
    Id: 23,
    preferredDay: 5, // Example preferred date
    preferredTime: 12, // Example preferred time
  );
  Patient patient25 = Patient(
    name: "Thomas Martinez",
    healthCondition: "Arthritis",
    preferredDoctorName: "Dr. Smith",
    Id: 24,
    preferredDay: 3, // Example preferred date
    preferredTime: 9, // Example preferred time
  );

  // Add the new patients to the patients HashMap
  patients.addAll({
    patient21.Id: patient21,
    patient22.Id: patient22,
    patient23.Id: patient23,
    patient24.Id: patient24,
    patient25.Id: patient25,
  });

  Patient patient26 = Patient(
    name: "Evelyn Wilson",
    healthCondition: "High Blood Pressure",
    preferredDoctorName: "Dr. Johnson",
    Id: 25,
    preferredDay: 4, // Example preferred date
    preferredTime: 16, // Example preferred time
  );
  Patient patient27 = Patient(
    name: "Mason Taylor",
    healthCondition: "Stress",
    preferredDoctorName: "Dr. Lee",
    Id: 26,
    preferredDay: 5, // Example preferred date
    preferredTime: 14, // Example preferred time
  );
  Patient patient28 = Patient(
    name: "Scarlett Garcia",
    healthCondition: "Asthma",
    preferredDoctorName: "Dr. Brown",
    Id: 27,
    preferredDay: 4, // Example preferred date
    preferredTime: 11, // Example preferred time
  );
  Patient patient29 = Patient(
    name: "Jack Anderson",
    healthCondition: "Diabetes",
    preferredDoctorName: "Dr. Smith",
    Id: 28,
    preferredDay: 5, // Example preferred date
    preferredTime: 15, // Example preferred time
  );
  Patient patient30 = Patient(
    name: "Avery Wilson",
    healthCondition: "Migraine",
    preferredDoctorName: "Dr. Lee",
    Id: 29,
    preferredDay: 4, // Example preferred date
    preferredTime: 10, // Example preferred time
  );
  Patient patient31 = Patient(
    name: "Liam Brown",
    healthCondition: "Asthma",
    preferredDoctorName: "Dr. Brown",
    Id: 30,
    preferredDay: 3, // Example preferred date
    preferredTime: 13, // Example preferred time
  );
  Patient patient32 = Patient(
    name: "Luna Lee",
    healthCondition: "Depression",
    preferredDoctorName: "Dr. Lee",
    Id: 31,
    preferredDay: 3, // Example preferred date
    preferredTime: 16, // Example preferred time
  );
  Patient patient33 = Patient(
    name: "Noah Smith",
    healthCondition: "Chronic Pain",
    preferredDoctorName: "Dr. Johnson",
    Id: 32,
    preferredDay: 5, // Example preferred date
    preferredTime: 9, // Example preferred time
  );
  Patient patient34 = Patient(
    name: "Mia Johnson",
    healthCondition: "Arthritis",
    preferredDoctorName: "Dr. Smith",
    Id: 33,
    preferredDay: 3, // Example preferred date
    preferredTime: 14, // Example preferred time
  );
  Patient patient35 = Patient(
    name: "James Martinez",
    healthCondition: "Insomnia",
    preferredDoctorName: "Dr. Brown",
    Id: 34,
    preferredDay: 4, // Example preferred date
    preferredTime: 16, // Example preferred time
  );
  Patient patient36 = Patient(
    name: "Emily Anderson",
    healthCondition: "Allergy",
    preferredDoctorName: "Dr. Lee",
    Id: 35,
    preferredDay: 5, // Example preferred date
    preferredTime: 12, // Example preferred time
  );
  Patient patient37 = Patient(
    name: "William Brown",
    healthCondition: "Stress",
    preferredDoctorName: "Dr. Brown",
    Id: 36,
    preferredDay: 3, // Example preferred date
    preferredTime: 11,
  ); // Example preferred time

  patients.addAll({
    patient26.Id: patient26,
    patient27.Id: patient27,
    patient28.Id: patient28,
    patient29.Id: patient29,
    patient30.Id: patient30,
    patient31.Id: patient31,
    patient32.Id: patient32,
    patient33.Id: patient33,
    patient34.Id: patient34,
    patient35.Id: patient35,
    patient36.Id: patient36,
    patient37.Id: patient37,
  });

  // Create HashMaps
  // HashMap<int, Doctor> doctorsMap = HashMap<int, Doctor>.from({
  //   doctor1.Id: doctor1,
  //   doctor2.Id: doctor2,
  //   doctor3.Id: doctor3,
  //   doctor4.Id: doctor4,
  //   doctor5.Id: doctor5,
  // });

  // HashMap<int, Patient> patientsMap = HashMap<int, Patient>.from({
  //   patient1.Id: patient1,
  //   patient2.Id: patient2,
  //   patient3.Id: patient3,
  //   patient4.Id: patient4,
  //   patient5.Id: patient5,
  //   patient6.Id: patient6,
  //   patient7.Id: patient7,
  //   patient8.Id: patient8,
  //   patient9.Id: patient9,
  //   patient10.Id: patient10,
  //   patient11.Id: patient11,
  //   patient12.Id: patient12,
  //   patient13.Id: patient13,
  //   patient14.Id: patient14,
  //   patient15.Id: patient15,
  // });

  // // Accessing elements from the HashMaps
  // print(doctorsMap[1]!.name); // Output: Dr. Smith
  // print(patientsMap[1]!.healthCondition); // Output: Migraine
//   Schedule s = new Schedule(doctors , patients);
//   s.runGeneticAlgorithm();
}
