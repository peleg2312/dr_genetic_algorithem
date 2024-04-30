import 'dart:collection';


import 'doctor.dart';
import 'individual.dart';
import 'patient.dart';



class Population {
  int popSize = 3000;
  int fittest = 0;
  late HashMap<int,Doctor> doctors;
  late HashMap<int,Patient> patients;
  late List<Individual> individuals;
  Population({required HashMap<int,Doctor> doctors, required HashMap<int,Patient> patients}) {
    this.doctors = doctors;
    this.patients = patients;
    individuals = List<Individual>.filled(popSize, Individual(this.doctors,this.patients));
    initializePopulation();
    individuals.sort((a, b) => b.fitness.compareTo(a.fitness));
    // for(var indivIdual in individuals){
    //   indivIdual.printIndividual();
    //   print(indivIdual.fitness);
    // }
  }

  void initializePopulation() {
    for (int i = 0; i < individuals.length; i++) {
      individuals[i] = Individual(doctors,patients);
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

  Individual getSecondFittest() {
    int maxFit1 = 0;
    int maxFit2 = 0;
    for (int i = 0; i < individuals.length; i++) {
      if (individuals[i].fitness > individuals[maxFit1].fitness) {
        maxFit2 = maxFit1;
        maxFit1 = i;
      } else if (individuals[i].fitness > individuals[maxFit2].fitness) {
        maxFit2 = i;
      }
    }
    return individuals[maxFit2];
  }

  int getLeastFittestIndex() {
    int minFitVal = individuals[0].fitness;
    int minFitIndex = 0;
    for (int i = 1; i < individuals.length; i++) {
      if (minFitVal > individuals[i].fitness) {
        minFitVal = individuals[i].fitness;
        minFitIndex = i;
      }
    }
    return minFitIndex;
  }

  void calculateFitness() {
    for (int i = 0; i < individuals.length; i++) {
      individuals[i].calcFitness();
    }
    getFittest();
  }
}

