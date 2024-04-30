import 'package:dr_app/model/doctor.dart';
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

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    List<String> appointments = [];
    List<String> doctors = [];
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        elevation: 0,
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text("Admin Page: "),
        ),
        actions: [ Padding(
                padding: EdgeInsets.only(left: 15.0, top: 0.0,right: 30),
                child: IconButton(
                  onPressed: LogOut,
                  icon: Icon(
                    Icons.exit_to_app,
                    size: 26,
                    color: Colors.red,
                  )),
            )],
      ),
      body: Column(children: [appointments.isEmpty?Center(child: Text("there are no appointments",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600)),):Text(""),SizedBox(height: height*0.3,),doctors.isEmpty?Center(child: Text("there is no doctors",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600)),):Text(""),SizedBox(height: height*0.03,),DoctorAddButton()]),
     
    );
  }
  void LogOut() {
    showDialog(
        context: context,
        builder: ((ctx) => AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Do you want to sign out?'),
              actions: [
                TextButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                  },
                ),
                TextButton(
                  child: Text('Yes'),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(ctx).pop();
                    setState(() {});
                  },
                )
              ],
            )));
  }
  
}

class DoctorAddButton extends StatelessWidget{
  const DoctorAddButton({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    TextEditingController doctorNameController = new TextEditingController();
    TextEditingController healnaseController = new TextEditingController();
    TextEditingController startWorkingHour = new TextEditingController();
    TextEditingController endWorkingHour= new TextEditingController();
    TextEditingController idController= new TextEditingController();

    return Center(
      child: InkWell(
         onTap: (){_showDialog(context,idController,doctorNameController,healnaseController,startWorkingHour,endWorkingHour);},
        child: Container(
            width: width * 0.3,
            height: height * 0.05,
            child: Center(
              child: Text("Add Doctor",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.lightBlue,
                    Colors.purple,
                  ]),
              borderRadius: BorderRadius.circular(59.0),
            ),),
      ),
    );
  }


  
  void _showDialog(BuildContext context, TextEditingController idController,TextEditingController doctorNameController,TextEditingController healnaseController,TextEditingController startWorkingHour,TextEditingController endWorkingHour) {
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 36, 40, 51),
            title: Text(
              "Ask For Appointment",
              style: TextStyle(color: Colors.white54),
            ),
            content: Column(
              children: [
                new TextFormField(
                  cursorColor: const Color.fromARGB(255, 54, 149, 244),
                  decoration: InputDecoration(
                      border: new OutlineInputBorder(borderSide: new BorderSide(color: Colors.red)),
                      labelText: "Doctor's name",
                      contentPadding: EdgeInsets.only(left: 16.0, top: 20.0, right: 16.0, bottom: 5.0)),
                  controller: doctorNameController,
                  autofocus: true,
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  maxLength: 15,
                ),
                new TextFormField(
                  cursorColor: const Color.fromARGB(255, 54, 149, 244),
                  decoration: InputDecoration(
                      border: new OutlineInputBorder(borderSide: new BorderSide(color: Colors.red)),
                      labelText: "Doctor's ID",
                      contentPadding: EdgeInsets.only(left: 16.0, top: 20.0, right: 16.0, bottom: 5.0)),
                  controller: idController,
                  autofocus: true,
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  maxLength: 15,
                ),
                new TextFormField(
              cursorColor: const Color.fromARGB(255, 54, 149, 244),
              decoration: InputDecoration(
                  border: new OutlineInputBorder(borderSide: new BorderSide(color: Colors.red)),
                  labelText: "Health concern",
                  contentPadding: EdgeInsets.only(left: 16.0, top: 10.0, right: 16.0, bottom: 5.0)),
              controller: healnaseController,
              autofocus: true,
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.white70,
                fontWeight: FontWeight.w500,
              ),
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              maxLength: 15,
            ),
            new TextFormField(
              cursorColor: const Color.fromARGB(255, 54, 149, 244),
              decoration: InputDecoration(
                  border: new OutlineInputBorder(borderSide: new BorderSide(color: Colors.red)),
                  labelText: "Start Hour",
                  contentPadding: EdgeInsets.only(left: 16.0, top: 10.0, right: 16.0, bottom: 5.0)),
              controller: startWorkingHour,
              autofocus: true,
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.white70,
                fontWeight: FontWeight.w500,
              ),
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              maxLength: 15,
            ),
            new TextFormField(
              cursorColor: const Color.fromARGB(255, 54, 149, 244),
              decoration: InputDecoration(
                  border: new OutlineInputBorder(borderSide: new BorderSide(color: Colors.red)),
                  labelText: "End Hour",
                  contentPadding: EdgeInsets.only(left: 16.0, top: 10.0, right: 16.0, bottom: 5.0)),
              controller: endWorkingHour,
              autofocus: true,
              style: TextStyle(
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
                        doctorNameController.text == "" || healnaseController.text == null ||
                        healnaseController.text.isEmpty ||
                        healnaseController.text == "" || startWorkingHour.text == null ||
                        startWorkingHour.text.isEmpty ||
                        startWorkingHour.text == "" || endWorkingHour.text == null ||
                        endWorkingHour.text.isEmpty ||
                        endWorkingHour.text == "" ||idController.text == null ||
                        idController.text.isEmpty ||
                        idController.text == "") {
                      showInSnackBar("Enter Valid values", context, Colors.red);
                      return;
                    }else{
                      Provider.of<DoctorProvider>(context).addDoctorToFirebase(doctorNameController,idController, healnaseController, startWorkingHour, endWorkingHour,context);
                    }

                    Navigator.of(context).pop();

                    
                  }),
                  child: Text(
                    "Add Team",
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

    ScaffoldMessenger.of(context)?.showSnackBar(new SnackBar(
      content: new Text(value, textAlign: TextAlign.center),
      backgroundColor: color,
      duration: Duration(seconds: 3),
    ));
  }

}