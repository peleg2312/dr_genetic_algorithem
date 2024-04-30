import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_app/model/patient.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class PatientProvider extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  bool saving = false;
  HashMap<int, Patient> _patientMap = HashMap<int, Patient>();
  HashMap<int, Patient> get patientMap => HashMap<int,Patient>.from(_patientMap);



  //input: Patient Id
  //output: delete the Patient with the tId as his Id
  void deletePatient(String tId) {
    FirebaseFirestore.instance.collection("Patients").doc(tId).delete();
    _patientMap.remove(tId);
    notifyListeners();
  }

  //output: getting data from firebase and putting it inside Patients list
  Future<void> fetchPatientData(context) async {
    try {
      await FirebaseFirestore.instance.collection('Patients').get().then(
        (QuerySnapshot value) {
          value.docs.forEach(
            (result) {
              Patient newT = Patient(
                  name: result["name"],
                  healthCondition: result["healthCondition"],
                  preferredDoctorName: result["preferredDoctorName"],
                  preferredDay: result["preferredDay"],
                  Id: result["Id"],
                  preferredTime: result["preferredTime"]);
              _patientMap.addAll({result["Id"]: newT});            },
          );
        },
      );
    } catch (error) {
      throw error;
    }

    notifyListeners();
  }


  //input: listNameController, listPreferredDay, listPreferredTime, listHealthCondition, listPreferredDoctorName,context
  //output: add new Patient to Firebase and the local list
  Future<int> addPatientToFirebase(
      TextEditingController listNameController,TextEditingController listPreferredDay,TextEditingController listPreferredTime , TextEditingController listHealthCondition ,TextEditingController listPreferredDoctorName, BuildContext context) async {
    User? authResult = _auth.currentUser;
    saving = true;
    bool isExist = false;

    QuerySnapshot query = await FirebaseFirestore.instance.collection("Patients").get();

    query.docs.forEach((doc) {
      if (listNameController.text.toString() == doc.id) {
        isExist = true;
      }
    });

    int Id = 0;
    if (isExist == false && listNameController.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection("Patients").add({
        "id": _auth.currentUser!.uid.toString(),
        "name": FirebaseAuth.instance.currentUser?.displayName,
        "healthCondition": listHealthCondition.text.toString(),
        "preferredDoctorName":listPreferredDoctorName.text.toString(),
        "preferredDay": listPreferredDay.text.toString(),
        "preferredTime": listPreferredTime.text.toString()
      }).then((value) => Id = value.id as int );

      _patientMap.addAll({Id: Patient(
          name: listNameController.text.toString(),
          healthCondition: listHealthCondition.text.toString(),
          preferredDoctorName: listPreferredDoctorName.text.toString(),
          preferredDay: int.parse(listPreferredDay.text.toString()),
          Id: Id,
          preferredTime: int.parse(listPreferredTime.text.toString()) 
      )});
      
    }
    if (isExist == true) {
      showInSnackBar("This list already exists", context, Theme.of(context).scaffoldBackgroundColor);
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
