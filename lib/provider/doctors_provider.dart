import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_app/model/doctor.dart';
import 'package:dr_app/styles/healthConditions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DoctorProvider extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  bool saving = false;
  HashMap<int, Doctor> _doctorMap = HashMap<int, Doctor>();
  HashMap<int, Doctor> get doctorMap => HashMap<int, Doctor>.from(_doctorMap);

  //input: Doctor Id
  //output: delete the Doctor with the tId as his Id
  void deleteDoctor(String tId) {
    FirebaseFirestore.instance.collection("Doctors").doc(tId).delete();
    _doctorMap.remove(tId);
    notifyListeners();
  }

  //output: getting data from firebase and putting it inside Doctors list
  Future<void> fetchDoctorData(context) async {
    try {
      await FirebaseFirestore.instance.collection('Doctors').get().then(
        (QuerySnapshot value) {
          value.docs.forEach(
            (result) {
              Doctor newT = Doctor(
                name: result["name"],
                specialization: stringtoHealth(result["specialization"]),
                startTime: result["startTime"],
                endTime: result["endTime"],
                Id: result["id"],
              );
              _doctorMap.addAll({result["id"]: newT});
            },
          );
        },
      );
    } catch (error) {
      throw error;
    }

    notifyListeners();
  }

  //input: listNameController,listSpecialization, listStartWorkHour, listEndWorkHour, context
  //output: add new Doctor to Firebase and the local list
  Future<int> addDoctorToFirebase(
      TextEditingController listNameController,
      TextEditingController idController,
      TextEditingController listSpecialization,
      TextEditingController listStartWorkHour,
      TextEditingController listEndWorkHour,
      BuildContext context) async {
    User? authResult = _auth.currentUser;
    saving = true;
    bool isExist = false;

    QuerySnapshot query = await FirebaseFirestore.instance.collection("Doctors").get();

    query.docs.forEach((doc) {
      if (idController.text.toString() == doc.id) {
        isExist = true;
      }
    });

    int Id = 0;
    if (isExist == false && listNameController.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection("Doctors").add({
        "id": idController.text.toString(),
        "name": FirebaseAuth.instance.currentUser?.displayName,
        "specialization": listSpecialization.text.toString(),
        "startTime": listStartWorkHour.text.toString(),
        "endTime": listEndWorkHour.text.toString(),
      }).then((value) => Id = value.id as int);

      _doctorMap.addAll({
        Id: Doctor(
          name: listNameController.text.toString(),
          specialization: listSpecialization.text.split(",") as List<Health>,
          startTime: int.parse(listStartWorkHour.text.toString()),
          endTime: int.parse(listEndWorkHour.text.toString()),
          Id: Id,
        )
      });
    }
    if (isExist == true) {
      showInSnackBar("This doctor already exists", context, Theme.of(context).scaffoldBackgroundColor);
      saving = false;
    }
    if (listNameController.text.isEmpty) {
      showInSnackBar("Please enter a name", context, Theme.of(context).scaffoldBackgroundColor);
      saving = false;
    }
    listNameController.clear();
    notifyListeners();
    return Id;
  }

  Future<int> addDoctorsToFirebase(HashMap<int,Doctor> doctors,
      BuildContext context) async {
    User? authResult = _auth.currentUser;
    saving = true;
    bool isExist = false;

   for (var element in doctors.values) {
     await FirebaseFirestore.instance.collection("Doctors").add({
        "id": element.Id,
        "name": element.name,
        "specialization": element.specialization.map((e) => e.name).toList().join(","),
        "startTime": element.startTime,
        "endTime": element.endTime,});
   
   }
   return 1; 
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
