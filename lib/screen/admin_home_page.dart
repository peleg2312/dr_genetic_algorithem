import 'dart:collection';
import 'dart:ffi';
import 'dart:isolate';
import 'package:dr_app/model/appointment.dart';
import 'package:dr_app/model/doctor.dart';
import 'package:dr_app/model/patient.dart';
import 'package:dr_app/provider/shedule.dart';
import 'package:dr_app/provider/appointment_provider.dart';
import 'package:dr_app/provider/patient_provider.dart';
import 'package:dr_app/provider/doctors_provider.dart';
import 'package:dr_app/styles/colors.dart';
import 'package:dr_app/screen/client_home_page.dart';
import 'package:dr_app/styles/data.dart';
import 'package:dr_app/styles/days.dart';
import 'package:dr_app/styles/widgetCards.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
  var fittest = null;
  bool running = false;
  double generationCount = 1.0;
  List<Days> days = Days.values;

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
    Data data = Data();
    patients = data.patinets;
    doctors = data.doctors;
    appointments = Provider.of<AppointmentProvider>(context).appointments;
    Schedule schedule = Schedule(doctors, patients);
    var size = MediaQuery.of(context).size;
    var height = size.height;
    
    
    var width = size.width;
    return Scaffold(
      floatingActionButton: patients.isNotEmpty
          ? Container(
            width: width * 0.2,
            child: FloatingActionButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: ((context) {
                        return AlertDialog(
                          title: const Text("Start?"),
                          actions: [
                            TextButton(
                                onPressed: () async {                    
                                  _runAlgorithm(schedule, context);
                                },
                                child: const Text("yes")),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("no"))
                          ],
                        );
                      }));
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                      Colors.lightBlue,
                      Colors.purple,
                    ]),
                    borderRadius: BorderRadius.circular(59.0),
                  ),
                  child: const Center(
                    child: Text(
                      "Start Algorithm",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
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
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 100),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                patients.isEmpty
                    ? const Center(
                        child: Text("there are no appointments request",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                      )
                    : Container(
                        height: 250,
                        width: 400,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[Text(doctors.length.toString()+ " Doctors", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),DoctorCard(context, doctors.values.toList()[0])],
                        ),
                      ),
                SizedBox(
                  height: height * 0.05,
                ),
                doctors.isEmpty
                    ? const Center(
                        child: Text("there is no doctors", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                      )
                    : Container(
                        height: 250,
                        width: 400,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[ Text(patients.length.toString()+ " Patients", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),PatientAppintmentCard(context, patients.values.toList()[0])],
                        ),
                      ),
                SizedBox(
                  height: height * 0.03,
                ),
                const DoctorAddButton()
              ]),
            ),
          ),SizedBox(width: width * 0.2,),
          //AlgorithmAppearance()
            
          
        ],
      ),
    );
  }

  Widget AlgorithmAppearance(){
    appointments = Provider.of<AppointmentProvider>(context,listen:false).getIndividualAppointments(fittest);
    return running?
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              
              Container(child: LoadingAnimationWidget.staggeredDotsWave(
                      color: const Color.fromARGB(255, 114, 20, 130),
                      size: 200,
                    ),),
                    Text((generationCount/10).toString()+"%")]):appointments.isEmpty?Container():Container(
                        height: 220,
                        width: 400,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[Text(appointments.length.toString()+ " Appointments", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),AppointmentCard(context, appointments[0])],
                        ),
                      );
            
  }



  void _runAlgorithm(Schedule schedule, BuildContext context) async{
    ReceivePort myReceivePort = ReceivePort();
    await Isolate.spawn(schedule.runGeneticAlgorithm, myReceivePort.sendPort);
    setState(() {running = true;});
    Navigator.of(context).pop();
    myReceivePort.listen((result){
      if(result != "finished"){
        setState(() {
        generationCount++;
      });
      }else{
        print("end");
        setState((){running = false;
        fittest = schedule.population.individuals[0];
        generationCount = 0;
        });
      }
    });
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
  }}

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
          decoration: BoxDecoration(
            gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
              Colors.lightBlue,
              Colors.purple,
            ]),
            borderRadius: BorderRadius.circular(59.0),
          ),
          child: const Center(
            child: Text(
              "Add Doctor",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
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
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                      labelText: "Doctor's name",
                      contentPadding: EdgeInsets.only(left: 16.0, top: 20.0, right: 16.0, bottom: 5.0)),
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
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                      labelText: "Doctor's ID",
                      contentPadding: EdgeInsets.only(left: 16.0, top: 20.0, right: 16.0, bottom: 5.0)),
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
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                      labelText: "Health concern",
                      contentPadding: EdgeInsets.only(left: 16.0, top: 10.0, right: 16.0, bottom: 5.0)),
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
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                      labelText: "Start Hour",
                      contentPadding: EdgeInsets.only(left: 16.0, top: 10.0, right: 16.0, bottom: 5.0)),
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
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                      labelText: "End Hour",
                      contentPadding: EdgeInsets.only(left: 16.0, top: 10.0, right: 16.0, bottom: 5.0)),
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
