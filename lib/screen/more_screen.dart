import 'dart:collection';

import 'package:dr_app/model/appointment.dart';
import 'package:dr_app/model/doctor.dart';
import 'package:dr_app/model/patient.dart';
import 'package:dr_app/styles/colors.dart';
import 'package:dr_app/styles/widgetCards.dart';
import 'package:flutter/material.dart';

class MoreData extends StatefulWidget {
  const MoreData({super.key,required this.list});

  final list;

  @override
  State<MoreData> createState() => _MoreDataState();
}

class _MoreDataState extends State<MoreData> {
  var searchResult;
      HashMap<int, Doctor> filteredDoctor = HashMap();

    HashMap<int, Patient> filteredPatient = HashMap();

  @override
  void initState() {
    searchResult = widget.list;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    

    return Scaffold(
      appBar: AppBar(title:  Text("See All",style: TextStyle(fontSize: 40),),),
      
      body: Column(
      children: [
        Container(
          width: width*0.2,
      padding: EdgeInsets.all(16),
      child: TextField(
        onChanged: onParameterChange,
        decoration: InputDecoration(
          labelText: 'Search',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
        ),
      ),
    ),
        SizedBox(height: height*0.05,),

        Center(
          child: Container(
            width: width * 0.5,
            height: height * 0.7,
            child: ListView.builder(itemCount: searchResult.length, itemBuilder: (context,index){
              return widget.list is HashMap<int,Doctor>? DoctorCard(context,searchResult.values.toList()[index],searchResult,true):widget.list is List<Appointment>?  AppointmentCard(context,searchResult[index],searchResult,true): PatientAppintmentCard(context,searchResult.values.toList()[index],searchResult,true);
            }),
          ),
        ),
      ],
    ),);
  }

  void onParameterChange(String newQuery){
    print("work");
    filteredDoctor.clear();

    filteredPatient.clear();
    
    setState(() {
      if(searchResult is List<Appointment>){
        searchResult = widget.list.where((element) => element.doctorName.contains(newQuery) ? true : false).toList();
      }else{
        if(widget.list is HashMap<int,Doctor>){
          widget.list.forEach((key, doctor) {
    if (doctor.name.contains(newQuery)) {
      filteredDoctor[key] = doctor;
    }
  });
  searchResult = filteredDoctor;
        }else{
          widget.list.forEach((key, patient) {
    if (patient.name.contains(newQuery)) {
      filteredPatient[key] = patient;
    }
  });
  searchResult = filteredPatient;
        }
        
      }
    });
  }
}