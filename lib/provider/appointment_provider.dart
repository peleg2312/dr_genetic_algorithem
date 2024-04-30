import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_app/model/appointment.dart';
import 'package:dr_app/model/doctor.dart';
import 'package:dr_app/model/gene.dart';
import 'package:dr_app/model/individual.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AppointmentProvider extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  bool saving = false;
  List<Appointment> _appointments = [];
  List<Appointment> get appointments => [..._appointments];

  //output: getting data from firebase and putting it inside appointment list
  Future<void> fetchAppointmentData(context) async {
    try {
      await FirebaseFirestore.instance.collection('Appointment').get().then(
        (QuerySnapshot value) {
          value.docs.forEach(
            (result) {
              Appointment newA = Appointment(
                  doctorName: result["doctorName"],
                  time: result["time"],
                  day: result["day"],
                  patientName: result["patientName"],
                  patientId: result["patientId"],);
              _appointments.add(newA);
            },
          );
        },
      );
    } catch (error) {
      throw error;
    }

    notifyListeners();
  }

  //input: patientId
  //output: get the patient appointment
  Appointment getPatientAppointment() {
    return _appointments.firstWhere((element) => element.patientId == _auth.currentUser!.uid);
  }


  //input: individual
  //output: add new Appointment to Firebase and the local list
  Future<void> addAppoitnmentsToFirebase(Individual individual) async {
    saving = true;

    for (var genes in individual.genes) {
      for (var gene in genes) {
        await FirebaseFirestore.instance.collection("Appointment").add({
        "doctorName": gene.doctor.name,
        "time": gene.time,
        "day": gene.day,
        "patientName": gene.patient.name,
        "patientId": gene.patient.Id,
      });

      _appointments.add(new Appointment(doctorName: gene.doctor.name, patientName:  gene.patient.name, day:   gene.day, time: gene.time, patientId: gene.patient.Id));
      }
    }
     
    notifyListeners();
  }


  
  //intput: value, context, color
  //output: make visual SnackBar with error message
  void showInSnackBar(String value, BuildContext context, Color color) {
    ScaffoldMessenger.of(context)?.removeCurrentSnackBar();

    ScaffoldMessenger.of(context)?.showSnackBar(new SnackBar(
      content: new Text(value, textAlign: TextAlign.center),
      backgroundColor: color,
      duration: Duration(seconds: 3),
    ));
  }
}
