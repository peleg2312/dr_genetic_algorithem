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
