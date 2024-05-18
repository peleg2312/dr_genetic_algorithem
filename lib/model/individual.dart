import 'dart:collection';
import 'dart:io';
import 'dart:math';

import 'doctor.dart';
import 'gene.dart';
import 'patient.dart';

class Individual {
  int fitness = 0;
  List<List<Gene>> genes = List.generate(5, (_) => []);
  //List<List<List<bool>>> avelability = List.generate(5, (_) => []);
  late HashMap<int,Doctor> doctors;
  late HashMap<int,Patient> patients;
  var rng = Random();


  //To make it generate time too and for all the Genes
  Individual(HashMap<int,Doctor> doctors,HashMap<int,Patient> patients) {
    fitness =0;
    this.patients = new HashMap.from(patients); 
    this.doctors= new HashMap.from(doctors);
    for(MapEntry<int, Doctor> doctor in this.doctors.entries){
      doctor.value.avelability = List<List<bool>>.filled(5, List<bool>.filled((doctor.value.endTime-doctor.value.startTime)*2, false));;
    }
    for (MapEntry<int, Patient> element in this.patients.entries) {
      Doctor doctor = doctors[rng.nextInt(doctors.length)]!;
      Patient patient = element.value;
      int time = rng.nextInt(doctor.endTime - doctor.startTime) + doctor.startTime;
      int day = rng.nextInt(5);
      Gene cGene = new Gene(patient: patient, doctor: doctor, time: time, day: day);
      while( !doctor.specialization.contains(patient.healthCondition) && cGene.checkIfGeneIsValid() == false){
        doctor = doctors[rng.nextInt(doctors.length)]!;
        time = rng.nextInt(doctor.endTime - doctor.startTime) + doctor.startTime;
        day = rng.nextInt(5);
        cGene = new Gene(patient: patient, doctor: doctor, time: time, day: day);
      }    
      doctor.avelability[day][(time-doctor.startTime)*2] = true;
      genes[day].add(cGene);
      
    }
    calcFitness();
  }
    Individual.WithGenes(HashMap<int,Doctor> doctors,HashMap<int,Patient> patients, List<List<Gene>> genes) {
      fitness =0;
      this.genes = genes;
      this.patients =new HashMap.from(patients); 
      this.doctors= new HashMap.from(doctors);
      for(MapEntry<int, Doctor> doctor in this.doctors.entries){
      doctor.value.avelability = List<List<bool>>.filled(5, List<bool>.filled((doctor.value.endTime-doctor.value.startTime)*2, false));;
    }

      for (var elements in this.genes) {
        for (var gene in elements) {
          this.doctors[gene.doctor.Id]?.avelability[gene.day][(gene.time-doctors[gene.doctor.Id]!.startTime)*2] = true;
        }
      }
      calcFitness();
    }
    Individual.WithAddingGenes(HashMap<int,Doctor> doctors,HashMap<int,Patient> patients) {
      fitness =0;
      this.genes = List.generate(5, (_) => []);
      this.patients =new HashMap.from(patients); 
      this.doctors= new HashMap.from(doctors);
      for(MapEntry<int, Doctor> doctor in this.doctors.entries){
      doctor.value.avelability = List<List<bool>>.filled(5, List<bool>.filled((doctor.value.endTime-doctor.value.startTime)*2, false));;
    }

      
    }

  void printIndividual() {
    for (var gene in genes) {
      for (var g in gene) {
        print(g.patient.name + " " + g.doctor.name + " " + g.time.toString() + " " + (g.day+1).toString());
      }
    }
  }

  void updateDoctorAvalability(int day,int time,int id){
    doctors[id]?.avelability[day][(time-doctors[id]!.startTime)*2] = true;
  }


   Gene findPatient(int Id){
    for (var gene in genes) {
      for (var g in gene) {
        if(g.patient.Id == Id){
          return g;
        }
      }
    }
    return genes[0][0];
  }

  void calcFitness() {
    fitness = 0;
    for (var gene in genes) {
      for (var g in gene) {
        if(g.doctor.name != g.patient.preferredDoctorName){
          fitness -= 5;
      }
      fitness -= (g.patient.preferredTime - g.time).abs()*10;
      if(g.day != g.patient.preferredDay-1){
        fitness -= 30;
      }
      }
    }
  }

}

