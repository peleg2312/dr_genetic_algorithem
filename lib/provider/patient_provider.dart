import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_app/model/patient.dart';
import 'package:dr_app/provider/auth_provider.dart';
import 'package:dr_app/styles/days.dart';
import 'package:dr_app/styles/healthConditions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientProvider extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  bool saving = false;
  HashMap<int, Patient> _patientMap = HashMap<int, Patient>();
  HashMap<int, Patient> get patientMap => HashMap<int, Patient>.from(_patientMap);

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
                  healthCondition: Health.values.byName(result["healthCondition"]),
                  preferredDoctorName: result["preferredDoctorName"],
                  preferredDay: result["preferredDay"],
                  Id: result["id"],
                  preferredTime: result["preferredTime"]);
              _patientMap.addAll({result["id"]: newT});
            },
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
      TextEditingController listPreferredDay,
      TextEditingController listPreferredTime,
      TextEditingController listHealthCondition,
      TextEditingController listPreferredDoctorName,
      int Id) async {
    User? authResult = _auth.currentUser;
    saving = true;
    bool isExist = false;
    print(Id);

    QuerySnapshot query = await FirebaseFirestore.instance.collection("Patients").get();

    query.docs.forEach((doc) {
      if (listPreferredDoctorName.text.toString() == doc.id) {
        isExist = true;
      }
    });

    if (isExist == false && listPreferredDoctorName.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection("Patients").add({
        "id": Id,
        "name": FirebaseAuth.instance.currentUser?.displayName,
        "healthCondition": Health.values.byName(listHealthCondition.text).name,
        "preferredDoctorName": listPreferredDoctorName.text.toString(),
        "preferredDay": Days.values.byName(listPreferredDay.text).index +1,
        "preferredTime": int.parse(listPreferredTime.text)
      });

      _patientMap.addAll({
        Id: Patient(
            name: FirebaseAuth.instance.currentUser!.displayName.toString(),
            healthCondition: Health.values.byName( listHealthCondition.text.toString()) ,
            preferredDoctorName: listPreferredDoctorName.text.toString(),
            preferredDay: Days.values.byName(listPreferredDay.text).index +1,
            Id: Id,
            preferredTime: int.parse(listPreferredTime.text.toString()))
      });
    }
    // if (isExist == true) {
    //   showInSnackBar("This list already exists", context, Theme.of(context).scaffoldBackgroundColor);
    //   saving = false;
    // }
    // if (listPreferredDoctorName.text.isEmpty) {
    //   showInSnackBar("Please enter a name", context, Theme.of(context).scaffoldBackgroundColor);
    //   saving = false;
    // }
    listPreferredDoctorName.clear();
    listHealthCondition.clear();
    listPreferredDay.clear();
    listPreferredTime.clear();
    notifyListeners();
    return Id;
  }
  Future<int> addPatientsToFirebase(HashMap<int,Patient> patients,
      BuildContext context) async {
    User? authResult = _auth.currentUser;
    saving = true;
    bool isExist = false;

   for (var element in patients.values) {
     await FirebaseFirestore.instance.collection("Patients").add({
        "id": element.Id,
        "name": element.name,
        "healthCondition": element.healthCondition.name,
        "preferredDoctorName": element.preferredDoctorName,
        "preferredDay": element.preferredDay,
        "preferredTime": element.preferredTime});
   
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
