import 'dart:collection';

import 'doctor.dart';
import 'individual.dart';
import 'patient.dart';

class Population {
  int popSize = 1000;
  int fittest = 0;
  late HashMap<int, Doctor> doctors;
  late HashMap<int, Patient> patients;
  late List<Individual> individuals;
  Population({required HashMap<int, Doctor> doctors, required HashMap<int, Patient> patients}) {
    this.doctors = doctors;
    this.patients = patients;
    individuals = List<Individual>.filled(popSize, Individual(HashMap<int,Doctor>.from(this.doctors), HashMap<int,Patient>.from(this.patients)));
    //initializePopulation();
    individuals.sort((a, b) => b.fitness.compareTo(a.fitness));
  }

  void initializePopulation() {
    for (int i = 0; i < individuals.length; i++) {
      individuals[i] = Individual(doctors, patients);
    }
  }

  Individual getFittest() {
    int maxFit = - -0x8000000000000000;
    int maxFitIndex = 0;
    for (int i = 0; i < individuals.length; i++) {
      if (maxFit >= individuals[i].fitness) {
        maxFit = individuals[i].fitness;
        maxFitIndex = i;
      }
    }
    fittest = individuals[maxFitIndex].fitness;
    return individuals[maxFitIndex];
  }

  void calculateFitness() {
    for (int i = 0; i < individuals.length; i++) {
      individuals[i].calcFitness();
    }
    getFittest();
  }
}
