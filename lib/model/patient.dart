import 'package:dr_app/styles/healthConditions.dart';

class Patient {
  String name;
  Health healthCondition;
  String preferredDoctorName;
  int Id;
  int preferredDay;
  int preferredTime;

  Patient({required this.name, required this.healthCondition, required this.preferredDoctorName,required this.Id, required this.preferredDay, required this.preferredTime});

}