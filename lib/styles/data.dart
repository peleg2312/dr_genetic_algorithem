import 'dart:collection';
import 'dart:math';

import 'package:dr_app/model/doctor.dart';
import 'package:dr_app/model/patient.dart';
import 'package:dr_app/styles/healthConditions.dart';
var rng = Random();
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
    patinets.addAll({
    patient38.Id: patient38,
    patient39.Id: patient39,
    patient40.Id: patient40,
    patient41.Id: patient41,
    patient42.Id: patient42,
    patient43.Id: patient43,
    patient44.Id: patient44,
    patient45.Id: patient45,
    patient46.Id: patient46,
    patient47.Id: patient47,
    patient48.Id: patient48,
    patient49.Id: patient49,
    patient50.Id: patient50,
    patient51.Id: patient51,
    patient52.Id: patient52,
    patient53.Id: patient53,
    patient54.Id: patient54,
    patient55.Id: patient55,
    patient56.Id: patient56,
    patient57.Id: patient57,
    patient58.Id: patient58,
    patient59.Id: patient59,
    patient60.Id: patient60,
    patient61.Id: patient61,
    patient62.Id: patient62,
    patient63.Id: patient63,
    // patient64.Id: patient64,
    patient65.Id: patient65,
    patient66.Id: patient66,
    patient67.Id: patient67,
    patient68.Id: patient68,
    patient69.Id: patient69,
    patient70.Id: patient70,
    patient71.Id: patient71,
    patient72.Id: patient72,
    patient73.Id: patient73,
    patient74.Id: patient74,
    patient75.Id: patient75,
    patient76.Id: patient76,
    patient77.Id: patient77,
    patient78.Id: patient78,
    patient79.Id: patient79,
    patient80.Id: patient80,
    patient81.Id: patient81,
    patient82.Id: patient82,
    patient83.Id: patient83,
    patient84.Id: patient84,
    patient85.Id: patient85,
    patient86.Id: patient86,
    patient87.Id: patient87,
    patient88.Id: patient88,
    patient89.Id: patient89,
    patient90.Id: patient90,
    // patient91.Id: patient91,
    patient92.Id: patient92,
    patient93.Id: patient93,
    patient94.Id: patient94,
    patient95.Id: patient95,
    patient96.Id: patient96,
    patient97.Id: patient97,
    patient98.Id: patient98,
    patient99.Id: patient99,
    patient100.Id: patient100,
  });
}

}
Doctor doctor1 = Doctor(
    name: "Dr. Smith",
    specialization: [Health.Ophthalmologist, Health.ENT], 
    startTime: 9, 
    endTime: 17, 
    Id: 0,
  );
  Doctor doctor2 = Doctor(
    name: "Dr. Johnson",
    specialization: [Health.Orthopedic,Health.Familydoctor],
    startTime: 8, 
    endTime: 18, 
    Id: 1,
  );
  Doctor doctor3 = Doctor(
    name: "Dr. Williams",
    specialization: [Health.Pediatrist, Health.Orthopedic],
    startTime: 8, 
    endTime: 16, 
    Id: 2,
  );
  Doctor doctor4 = Doctor(
    name: "Dr. Brown",
    specialization: [Health.Ophthalmologist, Health.ENT],
    startTime: 9, 
    endTime: 17, 
    Id: 3,
  );
  Doctor doctor5 = Doctor(
    name: "Dr. Lee",
    specialization: [Health.Neurologist, Health.Familydoctor],
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
    preferredTime: 11, 
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
    preferredTime:  15
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


  Patient patient38 = Patient(
  name: "Henry Clark",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Smith",
  Id: 37,
  preferredDay: 1,
  preferredTime: rng.nextInt(8) + 8,
);

Patient patient39 = Patient(
  name: "Olivia Martinez",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Johnson",
  Id: 38,
  preferredDay: 2,
  preferredTime: rng.nextInt(8) + 8,
);

Patient patient40 = Patient(
  name: "Liam Wilson",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Lee",
  Id: 39,
  preferredDay: 3,
  preferredTime: rng.nextInt(8) + 8,
);

Patient patient41 = Patient(
  name: "Emma Brown",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Brown",
  Id: 40,
  preferredDay: 4,
  preferredTime: rng.nextInt(8) + 8,
);

Patient patient42 = Patient(
  name: "James Davis",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Lee",
  Id: 41,
  preferredDay: 5,
  preferredTime: rng.nextInt(8) + 8,
);

Patient patient43 = Patient(
  name: "Sophia Garcia",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Johnson",
  Id: 42,
  preferredDay:1,
  preferredTime: 12,
);

Patient patient44 = Patient(
  name: "Benjamin Jones",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Smith",
  Id: 43,
  preferredDay: 2,
  preferredTime: 11,
);

Patient patient45 = Patient(
  name: "Mia Lee",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Lee",
  Id: 44,
  preferredDay: 3,
  preferredTime: 10,
);

Patient patient46 = Patient(
  name: "Logan White",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Brown",
  Id: 45,
  preferredDay: 4,
  preferredTime: 9,
);

Patient patient47 = Patient(
  name: "Isabella Harris",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Smith",
  Id: 46,
  preferredDay: 5,
  preferredTime: 16,
);

Patient patient48 = Patient(
  name: "Ethan Young",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Johnson",
  Id: 47,
  preferredDay:2,
  preferredTime: 15,
);

Patient patient49 = Patient(
  name: "Amelia King",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Lee",
  Id: 48,
  preferredDay: 1,
  preferredTime: 14,
);

Patient patient50 = Patient(
  name: "Oliver Martinez",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Brown",
  Id: 49,
  preferredDay: 2,
  preferredTime: 13,
);

Patient patient51 = Patient(
  name: "Ava Scott",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Smith",
  Id: 50,
  preferredDay: 3,
  preferredTime: 12,
);

Patient patient52 = Patient(
  name: "Noah Adams",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Johnson",
  Id: 51,
  preferredDay: 4,
  preferredTime: 11,
);

Patient patient53 = Patient(
  name: "Charlotte Rodriguez",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Lee",
  Id: 52,
  preferredDay: 5,
  preferredTime: 10,
);

Patient patient54 = Patient(
  name: "Lucas Brown",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Brown",
  Id: 53,
  preferredDay: 1,
  preferredTime: 9,
);

Patient patient55 = Patient(
  name: "Emma Garcia",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Smith",
  Id: 54,
  preferredDay: 2,
  preferredTime: 8,
);

Patient patient56 = Patient(
  name: "Aiden Lee",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
 preferredDoctorName: "Dr. Johnson",
  Id: 55,
  preferredDay: 3,
  preferredTime: 16,
);

Patient patient57 = Patient(
  name: "Sophia Hernandez",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Lee",
  Id: 56,
  preferredDay: 4,
  preferredTime: 15,
);

Patient patient58 = Patient(
  name: "Mason Thompson",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Brown",
  Id: 57,
  preferredDay: 5,
  preferredTime: 14,
);

Patient patient59 = Patient(
  name: "Ella Martinez",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Smith",
  Id: 58,
  preferredDay: 1,
  preferredTime: 13,
);

Patient patient60 = Patient(
  name: "Carter Brown",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Johnson",
  Id: 59,
  preferredDay: 2,
  preferredTime: 12,
);

Patient patient61 = Patient(
  name: "Grace Clark",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Lee",
  Id: 60,
  preferredDay: 3,
  preferredTime: 11,
);

Patient patient62 = Patient(
  name: "Isaac Lewis",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Brown",
  Id: 61,
  preferredDay: 4,
  preferredTime: 10,
);

Patient patient63 = Patient(
  name: "Lily Walker",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Smith",
  Id: 62,
  preferredDay: 5,
  preferredTime:9,
);
Patient patient65 = Patient(
  name: "Jackson Hall",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Smith",
  Id: 64,
  preferredDay: rng.nextInt(5),
  preferredTime: rng.nextInt(8) + 8,
);

Patient patient66 = Patient(
  name: "Ava Allen",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Johnson",
  Id: 65,
  preferredDay: rng.nextInt(5),
  preferredTime: rng.nextInt(8) + 8,
);

Patient patient67 = Patient(
  name: "Sophia Wright",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Lee",
  Id: 66,
  preferredDay: rng.nextInt(5),
  preferredTime: rng.nextInt(8) + 8,
);

Patient patient68 = Patient(
  name: "Liam Harris",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Brown",
  Id: 67,
  preferredDay: rng.nextInt(5),
  preferredTime: rng.nextInt(8) + 8,
);

Patient patient69 = Patient(
  name: "Isabella Clark",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Smith",
  Id: 68,
  preferredDay: rng.nextInt(5),
  preferredTime: rng.nextInt(8) + 8,
);

Patient patient70 = Patient(
  name: "Lucas Rodriguez",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Johnson",
  Id: 69,
  preferredDay: rng.nextInt(5),
  preferredTime: rng.nextInt(8) + 8,
);

Patient patient71 = Patient(
  name: "Emma Lewis",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Lee",
  Id: 70,
  preferredDay: rng.nextInt(5),
  preferredTime: rng.nextInt(8) + 8,
);

Patient patient72 = Patient(
  name: "Mason Walker",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Brown",
  Id: 71,
  preferredDay: rng.nextInt(5),
  preferredTime: rng.nextInt(8) + 8,
);

Patient patient73 = Patient(
  name: "Sophia King",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Smith",
  Id: 72,
  preferredDay: rng.nextInt(5),
  preferredTime: rng.nextInt(8) + 8,
);

Patient patient74 = Patient(
  name: "Liam Allen",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Johnson",
  Id: 73,
  preferredDay: rng.nextInt(5),
  preferredTime: rng.nextInt(8) + 8,
);

Patient patient75 = Patient(
  name: "Olivia Hernandez",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Lee",
  Id: 74,
  preferredDay: rng.nextInt(5),
  preferredTime: rng.nextInt(8) + 8,
);

Patient patient76 = Patient(
  name: "Mason Young",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Brown",
  Id: 75,
  preferredDay: rng.nextInt(5),
  preferredTime: rng.nextInt(8) + 8,
);

Patient patient77 = Patient(
  name: "Amelia Martinez",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Smith",
  Id: 76,
  preferredDay: rng.nextInt(5),
  preferredTime: rng.nextInt(8) + 8,
);

Patient patient78 = Patient(
  name: "Elijah Garcia",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Johnson",
  Id: 77,
  preferredDay: rng.nextInt(5),
  preferredTime: rng.nextInt(8) + 8,
);

Patient patient79 = Patient(
  name: "Ava Anderson",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Lee",
  Id: 78,
  preferredDay: rng.nextInt(5),
  preferredTime: rng.nextInt(8) + 8,
);

Patient patient80 = Patient(
  name: "James White",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Brown",
  Id: 79,
  preferredDay: rng.nextInt(5),
  preferredTime: rng.nextInt(8) + 8,
);

Patient patient81 = Patient(
  name: "Charlotte Harris",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Smith",
  Id: 80,
  preferredDay: rng.nextInt(5),
  preferredTime: rng.nextInt(8) + 8,
);

Patient patient82 = Patient(
  name: "Henry Thompson",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Johnson",
  Id: 81,
  preferredDay: rng.nextInt(5),
  preferredTime: rng.nextInt(8) + 8,
);

Patient patient83 = Patient(
  name: "Sophia Martinez",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Lee",
  Id: 82,
  preferredDay: rng.nextInt(5),
  preferredTime: rng.nextInt(8) + 8,
);

Patient patient84 = Patient(
  name: "Benjamin Clark",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Brown",
  Id: 83,
  preferredDay: rng.nextInt(5),
  preferredTime: rng.nextInt(8) + 8,
);

Patient patient85 = Patient(
  name: "Grace Lewis",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Smith",
  Id: 84,
  preferredDay: rng.nextInt(5),
  preferredTime: rng.nextInt(8) + 8,
);

Patient patient86 = Patient(
  name: "Isaac Walker",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Johnson",
  Id: 85,
  preferredDay: rng.nextInt(5),
  preferredTime: rng.nextInt(8) + 8,
);

Patient patient87 = Patient(
  name: "Lily Young",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Lee",
  Id: 86,
  preferredDay: rng.nextInt(5),
  preferredTime: rng.nextInt(8) + 8,
);

Patient patient88 = Patient(
  name: "Matthew King",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Brown",
  Id: 87,
  preferredDay: rng.nextInt(5),
  preferredTime: rng.nextInt(8) + 8,
);

Patient patient89 = Patient(
  name: "Elizabeth Allen",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Smith",
  Id: 88,
  preferredDay: rng.nextInt(5),
  preferredTime: rng.nextInt(8) + 8,
);

Patient patient90 = Patient(
  name: "Joshua Wright",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Johnson",
  Id: 89,
  preferredDay: rng.nextInt(5),
  preferredTime: rng.nextInt(8) + 8,
);

Patient patient92 = Patient(
  name: "Ella Clark",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Lee",
  Id: 91,
  preferredDay: rng.nextInt(5),
  preferredTime: rng.nextInt(8) + 8,
);

Patient patient93 = Patient(
  name: "Aiden Lewis",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Smith",
  Id: 92,
  preferredDay: rng.nextInt(5),
  preferredTime: rng.nextInt(8) + 8,
);

Patient patient94 = Patient(
  name: "Mia Rodriguez",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Johnson",
  Id: 93,
  preferredDay: rng.nextInt(5),
  preferredTime: rng.nextInt(8) + 8,
);

Patient patient95 = Patient(
  name: "Logan Walker",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Lee",
  Id: 94,
  preferredDay: rng.nextInt(5),
  preferredTime: rng.nextInt(8) + 8,
);

Patient patient96 = Patient(
  name: "Avery Harris",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Brown",
  Id: 95,
  preferredDay: rng.nextInt(5),
  preferredTime: rng.nextInt(8) + 8,
);

Patient patient97 = Patient(
  name: "Luke Clark",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Smith",
  Id: 96,
  preferredDay: rng.nextInt(5),
  preferredTime: rng.nextInt(8) + 8,
);

Patient patient98 = Patient(
  name: "Scarlett Young",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Johnson",
  Id: 97,
  preferredDay: rng.nextInt(5),
  preferredTime: rng.nextInt(8) + 8,
);

Patient patient99 = Patient(
  name: "Jack Allen",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Lee",
  Id: 98,
  preferredDay: rng.nextInt(5),
  preferredTime: rng.nextInt(8) + 8,
);

Patient patient100 = Patient(
  name: "Grace Wright",
  healthCondition: Health.values[rng.nextInt(Health.values.length)],
  preferredDoctorName: "Dr. Brown",
  Id: 99,
  preferredDay: rng.nextInt(5)+1,
  preferredTime: rng.nextInt(8) + 8,
);
