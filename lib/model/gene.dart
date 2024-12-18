import 'doctor.dart';
import 'patient.dart';

class Gene {
  Patient patient;
  Doctor doctor;
  int time;
  int day;

  Gene({
    required this.patient,
    required this.doctor,
    required this.time,
    required this.day,
  }) {}

  bool checkIfGeneIsValid() {
    bool result = true;
    if (time <= doctor.endTime &&
        time >= doctor.startTime &&
        doctor.checkAvelability(time - doctor.startTime, day) == true && doctor.specialization.contains(patient.healthCondition))  {
    } else {
      result = false;
    }

    return result;
  }
}
