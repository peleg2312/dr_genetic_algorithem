import 'dart:collection';
import 'dart:isolate';
import 'dart:math';

import '../model/doctor.dart';
import '../model/gene.dart';
import '../model/individual.dart';
import '../model/patient.dart';
import '../model/population.dart';

class Schedule {
  late Population population;
  late Individual fittest;
  late Individual secondFittest;
  bool isRuning = false;
  int generationCount = 0;
  int generationSize = 2000;
  double tournamentPrecentage = 0.2;
  double crossoverPrecentage = 0.7;
  double mutatePrecentage = 0.1;
  late HashMap<int, Patient> patients;
  late HashMap<int, Doctor> doctors;
  var rng = Random();

  Schedule(HashMap<int, Doctor> doctors, HashMap<int, Patient> patients) {
    this.doctors = doctors;
    this.patients = patients;
    population = Population(patients:HashMap<int,Patient>.from(this.patients), doctors: HashMap<int,Doctor>.from(this.doctors));
  }

  void runGeneticAlgorithm(SendPort sendPort)  async{
    isRuning = true;
    population.individuals.sort((a, b) => b.fitness.compareTo(a.fitness));

    for (int i = 0; i < generationSize; i++) {
      print(i);
      int populationLength = population.individuals.length;
      population.individuals = population.individuals.sublist(0, (populationLength * tournamentPrecentage).toInt());

      for (int i = 0; i < (populationLength * crossoverPrecentage)/2; i++) {
        crossover(population.individuals[rng.nextInt(population.individuals.length)],
            population.individuals[rng.nextInt(population.individuals.length)]);
      }

      for (int i = 0; i < populationLength * mutatePrecentage; i++) {
        mutate(population.individuals[rng.nextInt((populationLength*tournamentPrecentage).toInt())]);
      }

      population.calculateFitness();
      population.individuals.sort((a, b) => b.fitness.compareTo(a.fitness));
      fittest = population.individuals[0];
      print(fittest.fitness);
      generationCount++;
      
        sendPort.send("update");
      
      
      if(generationCount%100 == 0){
        crossoverPrecentage -= 0.02;
        mutatePrecentage += 0.02;
      }
    }
    sendPort.send(population.individuals[0]);
    
    
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
    int geneLength = rng.nextInt(patients.length);

    Individual child1 = createChild(parent1, parent2, geneLength);
    Individual child2 = createChild(parent1, parent2, geneLength);
    child1.calcFitness();
    population.individuals.add(child1);
    child2.calcFitness();
    population.individuals.add(child2);
  }

  Individual createChild(Individual parent1, Individual parent2, int geneLength){
    Individual child = Individual.WithAddingGenes(doctors, patients);
    int i = 0;
    int j = 0;
    for (var gene in parent1.genes) {
      for (var g in gene) {
        if (i < geneLength) {
          child.genes[j].add(g);
          child.doctors[g.doctor.Id]?.avelability[g.day][(g.time - g.doctor.startTime) * 2] = true;
          i++;
        }
      }
      j++;
    }
    Doctor altDoctor;
    int altTime;
    int altDay;

    i = 0;
    j = 0;
    for (var gene in parent2.genes) {
      for (var g in gene) {
        altDoctor = g.doctor;
        altTime = g.time;
        altDay = g.day;
        if (!_geneExists(child.genes, g) &&
            child.doctors[g.doctor.Id]!.checkAvelability((g.time - g.doctor.startTime), g.day)) {
              child.genes[j].add(g);
          child.doctors[altDoctor.Id]?.avelability[altDay][(altTime - altDoctor.startTime) * 2] = true;
        } else if (!_geneExists(child.genes, g) &&
            !child.doctors[g.doctor.Id]!.checkAvelability((g.time - g.doctor.startTime), g.day)) {
          Gene newG = parent2.findPatient(g.patient.Id);
          if (child.doctors[newG.doctor.Id]!.checkAvelability((newG.time - newG.doctor.startTime), newG.day) &&
              !_geneExists(child.genes, newG)) {
            altTime = newG.time;
            altDay = newG.day;
            altDoctor = newG.doctor;
          } else {
            i=0;
            altTime = rng.nextInt(g.doctor.endTime - g.doctor.startTime) + g.doctor.startTime;
            altDay = rng.nextInt(5);
            while (!child.doctors[altDoctor.Id]!.checkAvelability((altTime - altDoctor.startTime), altDay)) {
              while(!altDoctor.specialization.contains(g.patient.healthCondition) || i>=5){
                altDoctor = doctors.values.elementAt(rng.nextInt(doctors.length));
                i=0;
              }
              altTime = rng.nextInt(altDoctor.endTime - altDoctor.startTime) + altDoctor.startTime;
              altDay = rng.nextInt(5);
              
              i++;
            }
          }
          child.genes[j].add(new Gene(patient: g.patient, doctor: altDoctor, time: altTime, day: altDay));
          child.doctors[altDoctor.Id]?.avelability[altDay][(altTime - altDoctor.startTime) * 2] = true;
        }
        i++;
      }
      j++;
    }
    return child;
  }


  void mutate(Individual individual) {
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

              while (!altDoctor.specialization.contains(gene.patient.healthCondition) && altTime < altDoctor.startTime && altTime > altDoctor.endTime ) {
                altDoctor = doctors.values.elementAt(rng.nextInt(doctors.length));
                altTime = rng.nextInt(altDoctor.endTime - altDoctor.startTime) + altDoctor.startTime;
              }
            } else if (rChange < 0.6) {
              altTime = rng.nextInt(altDoctor.endTime - altDoctor.startTime) + altDoctor.startTime;
            } else {
              altDay = rng.nextInt(5);
            }
          }
          while (!mutate.doctors[altDoctor.Id]!.checkAvelability(altTime - altDoctor.startTime, altDay));
          Gene newG = Gene(patient: gene.patient, doctor: altDoctor, time: altTime, day: altDay);
          mutate.genes[altDay].add(newG);
          mutate.doctors[altDoctor.Id]?.avelability[altDay][(altTime - altDoctor.startTime) * 2] = true;
        } else {
          while (!(altDoctor.specialization.contains(gene.patient.healthCondition) && mutate.doctors[altDoctor.Id]!.checkAvelability(altTime - altDoctor.startTime, altDay))) {
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
