import 'dart:collection';

import 'package:dr_app/model/doctor.dart';
import 'package:dr_app/model/patient.dart';
import 'package:dr_app/styles/healthConditions.dart';

class Data{

  late HashMap<int,Patient> patinets;
  late HashMap<int,Doctor> doctors;
  Data()
 {
  this.doctors = HashMap<int,Doctor>.from({doctor1.Id: doctor1,doctor2.Id: doctor2,doctor3.Id: doctor3,doctor4.Id: doctor4,doctor5.Id: doctor5});
  this.patinets = HashMap<int, Patient>.from({patient1.Id: patient1, patient2.Id: patient2, patient3.Id:patient3, patient4.Id:patient4,patient5.Id: patient5,patient6.Id: patient6,patient7.Id: patient7,patient8.Id: patient8,patient9.Id: patient9,patient10.Id: patient10,patient11.Id: patient11,patient12.Id: patient12,patient13.Id: patient13,patient14.Id: patient14,patient15.Id: patient15});
    patinets.addAll({
    patient16.Id: patient16,
    patient17.Id: patient17,
    patient18.Id: patient18,
    patient19.Id: patient19,
    patient20.Id: patient20,
  });

  patinets.addAll({
    patient21.Id: patient21,
    patient22.Id: patient22,
    patient23.Id: patient23,
    patient24.Id: patient24,
    patient25.Id: patient25,
  });

  patinets.addAll({
    patient26.Id: patient26,
    patient27.Id: patient27,
    patient28.Id: patient28,
    patient29.Id: patient29,
    patient30.Id: patient30,
    patient31.Id: patient31,
    patient32.Id: patient32,
    patient33.Id: patient33,
    patient34.Id: patient34,
    patient35.Id: patient35,
    patient36.Id: patient36,
    patient37.Id: patient37,});
}
Doctor doctor1 = Doctor(
    name: "Dr. Smith",
    specialization: [Health.Ophthalmologist, Health.ENT,Health.Pediatrist], 
    startTime: 9, 
    endTime: 17, 
    Id: 0,
  );
  Doctor doctor2 = Doctor(
    name: "Dr. Johnson",
    specialization: [Health.Orthopedic,Health.Familydoctor,Health.Neurologist],
    startTime: 1, 
    endTime: 18, 
    Id: 1,
  );
  Doctor doctor3 = Doctor(
    name: "Dr. Williams",
    specialization: [Health.Pediatrist, Health.Orthopedic,Health.ENT],
    startTime: 8, 
    endTime: 16, 
    Id: 2,
  );
  Doctor doctor4 = Doctor(
    name: "Dr. Brown",
    specialization: [Health.Ophthalmologist, Health.ENT,Health.Orthopedic],
    startTime: 9, 
    endTime: 17, 
    Id: 3,
  );
  Doctor doctor5 = Doctor(
    name: "Dr. Lee",
    specialization: [Health.Neurologist, Health.Familydoctor,Health.Pediatrist],
    startTime: 8, 
    endTime: 16, 
    Id: 4,
  );

  // Create patients
  Patient patient1 = Patient(
    name: "John Doe",
    healthCondition: Health.ENT,
    preferredDoctorName: "Dr. Smith",
    Id: 0,
    preferredDay: 2,
    preferredTime: 13, 
  );
  Patient patient2 = Patient(
    name: "Jane Doe",
    healthCondition: Health.ENT,
    preferredDoctorName: "Dr. Johnson",
    Id: 1,
    preferredDay: 2,
    preferredTime: 11, 
  );
  Patient patient3 = Patient(
    name: "Alice Smith",
    healthCondition: Health.ENT,
    preferredDoctorName: "Dr. Williams",
    Id: 2,
    preferredDay: 1,
    preferredTime: 9, 
  );
  Patient patient4 = Patient(
    name: "Michael Johnson",
    healthCondition: Health.ENT,
    preferredDoctorName: "Dr. Brown",
    Id: 3,
    preferredDay: 1,
    preferredTime: 14, 
  );
  Patient patient5 = Patient(
    name: "Emily Williams",
    healthCondition: Health.ENT,
    preferredDoctorName: "Dr. Lee",
    Id: 4,
    preferredDay: 3,
    preferredTime: 11, 
  );
  Patient patient6 = Patient(
    name: "DavId Brown",
    healthCondition: Health.ENT,
    preferredDoctorName: "Dr. Brown",
    Id: 5,
    preferredDay: 2,
    preferredTime: 11, 
  );
  Patient patient7 = Patient(
    name: "Sophia Martinez",
    healthCondition: Health.Familydoctor,
    preferredDoctorName: "Dr. Smith",
    Id: 6,
    preferredDay: 3,
    preferredTime: 15, 
  );
  Patient patient8 = Patient(
    name: "James Wilson",
    healthCondition: Health.Familydoctor,
    preferredDoctorName: "Dr. Johnson",
    Id: 7,
    preferredDay: 1,
    preferredTime: 12, 
  );
  Patient patient9 = Patient(
    name: "Olivia Taylor",
    healthCondition: Health.Familydoctor,
    preferredDoctorName: "Dr. Brown",
    Id: 8,
    preferredDay: 5,
    preferredTime:  1 
  );
  Patient patient10 = Patient(
    name: "William Garcia",
    healthCondition: Health.Familydoctor,
    preferredDoctorName: "Dr. Lee",
    Id: 9,
    preferredDay: 4,
    preferredTime: 12, 
  );
  Patient patient11 = Patient(
    name: "Isabella Rodriguez",
    healthCondition: Health.Familydoctor,
    preferredDoctorName: "Dr. Smith",
    Id: 10,
    preferredDay: 5,
    preferredTime: 10, 
  );
  Patient patient12 = Patient(
    name: "Daniel Martinez",
    healthCondition: Health.Familydoctor,
    preferredDoctorName: "Dr. Johnson",
    Id: 11,
    preferredDay: 3,
    preferredTime: 10, 
  );
  Patient patient13 = Patient(
    name: "Mia Wilson",
    healthCondition: Health.Neurologist,
    preferredDoctorName: "Dr. Brown",
    Id: 12,
    preferredDay: 2,
    preferredTime: 16, 
  );
  Patient patient14 = Patient(
    name: "Logan Garcia",
    healthCondition: Health.Neurologist,
    preferredDoctorName: "Dr. Lee",
    Id: 13,
    preferredDay: 2,
    preferredTime: 13, 
  );
  Patient patient15 = Patient(
    name: "Sophia Anderson",
    healthCondition: Health.Neurologist,
    preferredDoctorName: "Dr. Johnson",
    Id: 14,
    preferredDay: 3,
    preferredTime: 13, 
  );



    Patient patient16 = Patient(
    name: "Aiden Martinez",
    healthCondition: Health.Neurologist,
    preferredDoctorName: "Dr. Smith",
    Id: 15,
    preferredDay: 5,
    preferredTime: 14, 
  );
  Patient patient17 = Patient(
    name: "Ella Wilson",
    healthCondition: Health.Neurologist,
    preferredDoctorName: "Dr. Lee",
    Id: 16,
    preferredDay: 5,
    preferredTime: 15, 
  );
  Patient patient18 = Patient(
    name: "Jackson Taylor",
    healthCondition: Health.Neurologist,
    preferredDoctorName: "Dr. Brown",
    Id: 17,
    preferredDay: 4,
    preferredTime: 10, 
  );
  Patient patient19 = Patient(
    name: "Madison Garcia",
    healthCondition: Health.Ophthalmologist,
    preferredDoctorName: "Dr. Smith",
    Id: 18,
    preferredDay: 4,
    preferredTime: 12, 
  );
  Patient patient20 = Patient(
    name: "Lucas Anderson",
    healthCondition:  Health.Ophthalmologist,
    preferredDoctorName: "Dr. Lee",
    Id: 19,
    preferredDay: 3,
    preferredTime: 14, 
  );



  // Add the new patients to the patients HashMap





    Patient patient21 = Patient(
    name: "Oliver Brown",
    healthCondition:  Health.Ophthalmologist,
    preferredDoctorName: "Dr. Brown",
    Id: 20,
    preferredDay: 4,
    preferredTime: 13, 
  );
  Patient patient22 = Patient(
    name: "Amelia Lee",
    healthCondition:  Health.Ophthalmologist,
    preferredDoctorName: "Dr. Lee",
    Id: 21,
    preferredDay: 5,
    preferredTime: 10, 
  );
  Patient patient23 = Patient(
    name: "Henry Smith",
    healthCondition:  Health.Ophthalmologist,
    preferredDoctorName: "Dr. Smith",
    Id: 22,
    preferredDay: 4,
    preferredTime: 15, 
  );
  Patient patient24 = Patient(
    name: "Charlotte Johnson",
    healthCondition: Health.Ophthalmologist,
    preferredDoctorName: "Dr. Johnson",
    Id: 23,
    preferredDay: 5,
    preferredTime: 12, 
  );
  Patient patient25 = Patient(
    name: "Thomas Martinez",
    healthCondition:  Health.Orthopedic,
    preferredDoctorName: "Dr. Smith",
    Id: 24,
    preferredDay: 3,
    preferredTime: 9, 
  );

  // Add the new patients to the patients HashMap
  

    Patient patient26 = Patient(
    name: "Evelyn Wilson",
    healthCondition: Health.Orthopedic,
    preferredDoctorName: "Dr. Johnson",
    Id: 25,
    preferredDay: 4,
    preferredTime: 16, 
  );
  Patient patient27 = Patient(
    name: "Mason Taylor",
    healthCondition: Health.Orthopedic,
    preferredDoctorName: "Dr. Lee",
    Id: 26,
    preferredDay: 5,
    preferredTime: 14, 
  );
  Patient patient28 = Patient(
    name: "Scarlett Garcia",
    healthCondition: Health.Orthopedic,
    preferredDoctorName: "Dr. Brown",
    Id: 27,
    preferredDay: 4,
    preferredTime: 11, 
  );
  Patient patient29 = Patient(
    name: "Jack Anderson",
    healthCondition: Health.Orthopedic,
    preferredDoctorName: "Dr. Smith",
    Id: 28,
    preferredDay: 5,
    preferredTime: 15, 
  );
  Patient patient30 = Patient(
    name: "Avery Wilson",
    healthCondition: Health.Orthopedic,
    preferredDoctorName: "Dr. Lee",
    Id: 29,
    preferredDay: 4,
    preferredTime: 10, 
  );
  Patient patient31 = Patient(
    name: "Liam Brown",
    healthCondition: Health.Pediatrist,
    preferredDoctorName: "Dr. Brown",
    Id: 30,
    preferredDay: 3,
    preferredTime: 13, 
  );
  Patient patient32 = Patient(
    name: "Luna Lee",
    healthCondition:Health.Pediatrist,
    preferredDoctorName: "Dr. Lee",
    Id: 31,
    preferredDay: 3,
    preferredTime: 16, 
  );
  Patient patient33 = Patient(
    name: "Noah Smith",
    healthCondition:Health.Pediatrist,
    preferredDoctorName: "Dr. Johnson",
    Id: 32,
    preferredDay: 5,
    preferredTime: 9, 
  );
  Patient patient34 = Patient(
    name: "Mia Johnson",
    healthCondition: Health.Pediatrist,
    preferredDoctorName: "Dr. Smith",
    Id: 33,
    preferredDay: 3,
    preferredTime: 14, 
  );
  Patient patient35 = Patient(
    name: "James Martinez",
    healthCondition: Health.Pediatrist,
    preferredDoctorName: "Dr. Brown",
    Id: 34,
    preferredDay: 4,
    preferredTime: 16, 
  );
  Patient patient36 = Patient(
    name: "Emily Anderson",
    healthCondition: Health.Pediatrist,
    preferredDoctorName: "Dr. Lee",
    Id: 35,
    preferredDay: 5,
    preferredTime: 12, 
  );
  Patient patient37 = Patient(
    name: "William Brown",
    healthCondition: Health.Pediatrist,
    preferredDoctorName: "Dr. Brown",
    Id: 36,
    preferredDay: 3,
    preferredTime:  15);  


  
}