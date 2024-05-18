//input: context, Appointment
//output: return widget that display appointment card
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_app/model/appointment.dart';
import 'package:dr_app/model/doctor.dart';
import 'package:dr_app/styles/colors.dart';
import 'package:dr_app/styles/days.dart';
import 'package:flutter/material.dart';

import '../model/patient.dart';

  List<Days> days = Days.values;

Widget AppointmentCard(BuildContext context, Appointment myAppointment) {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Doctor: " + myAppointment.doctorName[0].toUpperCase()+myAppointment.doctorName.substring(1) , style: const TextStyle(color: Colors.white,fontSize: 15)),
                          const SizedBox(
                            height: 2,
                          ),
                        ],
                      ),
                  Text("Patient: " + myAppointment.patientName[0].toUpperCase()+myAppointment.patientName.substring(1) , style: const TextStyle(color: Colors.white,fontSize: 15)),
                    
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
                          Icons.calendar_today,
                          color: Colors.white,
                          size: 15,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          days[myAppointment.day].name,
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
                            myAppointment.time.toString() + " ~ " + (myAppointment.time + 1).toString(),
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
                           Column(children: doctor.specialization.map((e) => Text(e.name,style: TextStyle(color: Colors.white),)).toList(),)
                          ,
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
                            patient.healthCondition.name,
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
                              days[patient.preferredDay].name.substring(0,3) + "/" + patient.preferredTime.toString(),
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



