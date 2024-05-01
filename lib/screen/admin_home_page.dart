import 'dart:collection';

import 'package:dr_app/model/appointment.dart';
import 'package:dr_app/model/doctor.dart';
import 'package:dr_app/model/patient.dart';
import 'package:dr_app/model/shedule.dart';
import 'package:dr_app/provider/appointment_provider.dart';
import 'package:dr_app/provider/patient_provider.dart';
import 'package:dr_app/provider/doctors_provider.dart';
import 'package:dr_app/styles/colors.dart';
import 'package:dr_app/screen/client_home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({super.key});

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  HashMap<int, Patient> patients = HashMap<int, Patient>();
  List<Appointment> appointments = [];
  HashMap<int, Doctor> doctors = HashMap<int, Doctor>();

  //output: fetch data from Firebase
  @override
  void initState() {
    try {
      Provider.of<DoctorProvider>(context, listen: false).fetchDoctorData(context);
    } catch (e) {
      print(e);
    }
    try {
      Provider.of<PatientProvider>(context, listen: false).fetchPatientData(context);
    } catch (e) {
      print(e);
    }
    try {
      Provider.of<AppointmentProvider>(context, listen: false).fetchAppointmentData(context);
    } catch (e) {
      print(e);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    patients = Provider.of<PatientProvider>(context).patientMap;
    appointments = Provider.of<AppointmentProvider>(context).appointments;
    doctors = Provider.of<DoctorProvider>(context).doctorMap;
    Schedule schedule = new Schedule(doctors, patients, context);
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      floatingActionButton: patients.isNotEmpty
          ? FloatingActionButton(
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: ((context) {
                      return AlertDialog(
                        title: Text("Start?"),
                        actions: [
                          TextButton(
                              onPressed: () async {
                                showDialog(
                                    context: context,
                                    builder: ((context) {
                                      return AlertDialog(
                                        content: Text("The Algorithm runing pls wait for it to finish"),
                                      );
                                    }));
                                await schedule.runGeneticAlgorithm();
                                setState(() {});
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              child: Text("yes")),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("no"))
                        ],
                      );
                    }));
              },
              child: Container(
                width: width * 0.2,
                height: height * 0.05,
                child: const Center(
                  child: Text(
                    "Start Algorithm",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                    Colors.lightBlue,
                    Colors.purple,
                  ]),
                  borderRadius: BorderRadius.circular(59.0),
                ),
              ),
            )
          : null,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        elevation: 0,
        toolbarHeight: 80,
        title: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text("Admin Page: "),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 0.0, right: 30),
            child: IconButton(
                onPressed: LogOut,
                icon: const Icon(
                  Icons.exit_to_app,
                  size: 26,
                  color: Colors.red,
                )),
          )
        ],
      ),
      body: Column(children: [
        patients.isEmpty
            ? const Center(
                child: Text("there are no appointments request",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              )
            : Container(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[for (var doctor in doctors.values) DoctorCard(context, doctor)],
                ),
              ),
        SizedBox(
          height: height * 0.3,
        ),
        doctors.isEmpty
            ? const Center(
                child: Text("there is no doctors", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              )
            : Container(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[for (var patient in patients.values) PatientAppintmentCard(context, patient)],
                ),
              ),
        SizedBox(
          height: height * 0.03,
        ),
        const DoctorAddButton()
      ]),
    );
  }

  void LogOut() {
    showDialog(
        context: context,
        builder: ((ctx) => AlertDialog(
              title: const Text('Are you sure?'),
              content: const Text('Do you want to sign out?'),
              actions: [
                TextButton(
                  child: const Text('No'),
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                  },
                ),
                TextButton(
                  child: const Text('Yes'),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(ctx).pop();
                    setState(() {});
                  },
                )
              ],
            )));
  }

  Widget DoctorCard(BuildContext context, Doctor doctor) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(MyColors.primary),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(MyColors.bg01),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(doctor.name, style: const TextStyle(color: Colors.white)),
                            const SizedBox(
                              height: 2,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(MyColors.bg01),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.health_and_safety,
                            color: Colors.white,
                            size: 15,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            doctor.specialization,
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Icon(
                            Icons.access_alarm,
                            color: Colors.white,
                            size: 17,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            child: Text(
                              doctor.startTime.toString() + " ~ " + doctor.endTime.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: 10,
          decoration: BoxDecoration(
            color: Color(MyColors.bg02),
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          width: double.infinity,
          height: 10,
          decoration: BoxDecoration(
            color: Color(MyColors.bg03),
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  Widget PatientAppintmentCard(BuildContext context, Patient patient) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(MyColors.primary),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(MyColors.bg01),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(patient.name, style: const TextStyle(color: Colors.white)),
                            const SizedBox(
                              height: 2,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(MyColors.bg01),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.new_label,
                            color: Colors.white,
                            size: 15,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            patient.preferredDoctorName,
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Icon(
                            Icons.health_and_safety,
                            color: Colors.white,
                            size: 15,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            patient.healthCondition,
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Icon(
                            Icons.access_alarm,
                            color: Colors.white,
                            size: 17,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            child: Text(
                              patient.preferredDay.toString() + "/" + patient.preferredTime.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: 10,
          decoration: BoxDecoration(
            color: Color(MyColors.bg02),
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          width: double.infinity,
          height: 10,
          decoration: BoxDecoration(
            color: Color(MyColors.bg03),
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}

class DoctorAddButton extends StatelessWidget {
  const DoctorAddButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    TextEditingController doctorNameController = TextEditingController();
    TextEditingController healnaseController = TextEditingController();
    TextEditingController startWorkingHour = TextEditingController();
    TextEditingController endWorkingHour = TextEditingController();
    TextEditingController idController = TextEditingController();

    return Center(
      child: InkWell(
        onTap: () {
          _showDialog(
              context, idController, doctorNameController, healnaseController, startWorkingHour, endWorkingHour);
        },
        child: Container(
          width: width * 0.3,
          height: height * 0.05,
          child: const Center(
            child: Text(
              "Add Doctor",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          decoration: BoxDecoration(
            gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
              Colors.lightBlue,
              Colors.purple,
            ]),
            borderRadius: BorderRadius.circular(59.0),
          ),
        ),
      ),
    );
  }

  void _showDialog(
      BuildContext context,
      TextEditingController idController,
      TextEditingController doctorNameController,
      TextEditingController healnaseController,
      TextEditingController startWorkingHour,
      TextEditingController endWorkingHour) {
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 36, 40, 51),
            title: const Text(
              "Ask For Appointment",
              style: TextStyle(color: Colors.white54),
            ),
            content: Column(
              children: [
                TextFormField(
                  cursorColor: const Color.fromARGB(255, 54, 149, 244),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                      labelText: "Doctor's name",
                      contentPadding: const EdgeInsets.only(left: 16.0, top: 20.0, right: 16.0, bottom: 5.0)),
                  controller: doctorNameController,
                  autofocus: true,
                  style: const TextStyle(
                    fontSize: 22.0,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  maxLength: 15,
                ),
                TextFormField(
                  cursorColor: const Color.fromARGB(255, 54, 149, 244),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                      labelText: "Doctor's ID",
                      contentPadding: const EdgeInsets.only(left: 16.0, top: 20.0, right: 16.0, bottom: 5.0)),
                  controller: idController,
                  autofocus: true,
                  style: const TextStyle(
                    fontSize: 22.0,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  maxLength: 15,
                ),
                TextFormField(
                  cursorColor: const Color.fromARGB(255, 54, 149, 244),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                      labelText: "Health concern",
                      contentPadding: const EdgeInsets.only(left: 16.0, top: 10.0, right: 16.0, bottom: 5.0)),
                  controller: healnaseController,
                  autofocus: true,
                  style: const TextStyle(
                    fontSize: 22.0,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  maxLength: 15,
                ),
                TextFormField(
                  cursorColor: const Color.fromARGB(255, 54, 149, 244),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                      labelText: "Start Hour",
                      contentPadding: const EdgeInsets.only(left: 16.0, top: 10.0, right: 16.0, bottom: 5.0)),
                  controller: startWorkingHour,
                  autofocus: true,
                  style: const TextStyle(
                    fontSize: 22.0,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  maxLength: 15,
                ),
                TextFormField(
                  cursorColor: const Color.fromARGB(255, 54, 149, 244),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                      labelText: "End Hour",
                      contentPadding: const EdgeInsets.only(left: 16.0, top: 10.0, right: 16.0, bottom: 5.0)),
                  controller: endWorkingHour,
                  autofocus: true,
                  style: const TextStyle(
                    fontSize: 22.0,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  maxLength: 15,
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: (() {
                    if (doctorNameController.text == null ||
                        doctorNameController.text.isEmpty ||
                        doctorNameController.text == "" ||
                        healnaseController.text == null ||
                        healnaseController.text.isEmpty ||
                        healnaseController.text == "" ||
                        startWorkingHour.text == null ||
                        startWorkingHour.text.isEmpty ||
                        startWorkingHour.text == "" ||
                        endWorkingHour.text == null ||
                        endWorkingHour.text.isEmpty ||
                        endWorkingHour.text == "" ||
                        idController.text == null ||
                        idController.text.isEmpty ||
                        idController.text == "") {
                      showInSnackBar("Enter Valid values", context, Colors.red);
                      
                    } else {
                      
                    }
                    Provider.of<DoctorProvider>(context).addDoctorToFirebase(doctorNameController, idController,
                          healnaseController, startWorkingHour, endWorkingHour, context);

                    Navigator.of(context).pop();
                  }),
                  child: const Text(
                    "Add Doctor",
                    style: TextStyle(color: Colors.red),
                  ))
            ],
          );
        }));
  }

  //input: value, context, color
  //output: make visual SnackBar with error message
  void showInSnackBar(String value, BuildContext context, Color color) {
    ScaffoldMessenger.of(context)?.removeCurrentSnackBar();

    ScaffoldMessenger.of(context)?.showSnackBar(SnackBar(
      content: Text(value, textAlign: TextAlign.center),
      backgroundColor: color,
      duration: const Duration(seconds: 3),
    ));
  }
}
