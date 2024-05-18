// ignore_for_file: unused_import
import 'package:dr_app/model/appointment.dart';
import 'package:dr_app/provider/appointment_provider.dart';
import 'package:dr_app/provider/auth_provider.dart';
import 'package:dr_app/provider/patient_provider.dart';
import 'package:dr_app/styles/colors.dart';
import 'package:dr_app/styles/days.dart';
import 'package:dr_app/styles/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../styles/widgetCards.dart';

class ClientMainPage extends StatefulWidget {
  const ClientMainPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ClientMainPage> createState() => _ClientMainPageState();
}

class _ClientMainPageState extends State<ClientMainPage> {
  Appointment? myAppointment = null;

  //output: fetch data from Firebase
  @override
  void initState() {
    try {
      Provider.of<AppointmentProvider>(context, listen: false).fetchAppointmentData(context);
    } catch (e) {
      print(e);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    myAppointment = Provider.of<AppointmentProvider>(context).getPatientAppointment();
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          color: Colors.white70,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              UserIntro(context),
              SizedBox(
                height: height * 0.1,
              ),
              myAppointment!.doctorName == ""
                  ? const Center(
                      child: Text("there are no appointment yet"),
                    )
                  : AppointmentCard(context, myAppointment!),
                  
              SizedBox(
                height: height * 0.3,
              ),
              const AppointmentButton()
            ],
          ),
        ),
      ),
    );
  }
}

class AppointmentButton extends StatelessWidget {
  const AppointmentButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController doctorNameController = TextEditingController();
    TextEditingController healnaseController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    TextEditingController timeController = TextEditingController();

    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Center(
      child: InkWell(
        onTap: () {
          _showDialog(context, doctorNameController, healnaseController, dateController, timeController);
        },
        child: Container(
          width: width * 0.6,
          height: height * 0.1,
          child: const Center(
            child: Text(
              "Order Appointment",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
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
      TextEditingController doctorNameController,
      TextEditingController healnaseController,
      TextEditingController dateController,
      TextEditingController timeController) {
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
                      labelText: "Preferred Date",
                      contentPadding: const EdgeInsets.only(left: 16.0, top: 10.0, right: 16.0, bottom: 5.0)),
                  controller: dateController,
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
                      labelText: "Preferred Time",
                      contentPadding: const EdgeInsets.only(left: 16.0, top: 10.0, right: 16.0, bottom: 5.0)),
                  controller: timeController,
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
                        dateController.text == null ||
                        dateController.text.isEmpty ||
                        dateController.text == "" ||
                        timeController.text == null ||
                        timeController.text.isEmpty ||
                        timeController.text == "") {
                      showInSnackBar("Enter Valid Name", context, Colors.red);
                      return;
                    }else{
                        Provider.of<PatientProvider>(context, listen: false).addPatientToFirebase(
                      dateController,
                      timeController,
                      healnaseController,
                      doctorNameController,
                      context
                    );
                    }
                    

                    Navigator.of(context).pop();
                  }),
                  child: const Text(
                    "Add Appointment",
                    style: TextStyle(color: Colors.red),
                  ))
            ],
          );
        }));
  }

  //input: value, context, color
  //output: make visual SnackBar with error message
  void showInSnackBar(String value, BuildContext context, Color color) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(value, textAlign: TextAlign.center),
      backgroundColor: color,
      duration: const Duration(seconds: 3),
    ));
  }
}


Widget UserIntro(BuildContext context) {
  var userName = Provider.of<AuthProviderApp>(context).userName!;
  var hour = DateTime.now().hour;

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hour < 12)
            const Text(
              "Good Morning, ",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
            )
          else if (hour < 17)
            const Text(
              "Good Afternoon, ",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
            )
          else
            const Text(
              "Good Evening, ",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
            ),
          Text(
            userName == ""? "" :userName[0].toUpperCase() + userName.substring(1),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          Text(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).toString().substring(0, 10))
        ],
      ),
      InkWell(
        child: Provider.of<AuthProviderApp>(context, listen: false).imageProfileUrl == ""
            ? CircleAvatar(
                backgroundColor: Color(MyColors.bg02),
                radius: 30,
              )
            : CircleAvatar(
                backgroundImage: AssetImage(Provider.of<AuthProviderApp>(context, listen: false).imageProfileUrl!)
                    
              ),
        onTap: () {
          Navigator.pushNamed(context, '/profile');
        },
      )
    ],
  );
}
