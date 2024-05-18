import 'package:dr_app/styles/healthConditions.dart';

class Doctor {
  String name;
  List<Health> specialization;
  int startTime;
  int endTime;
  late List<List<bool>> avelability = List<List<bool>>.filled(5, List<bool>.filled((endTime-startTime)*2, false));
  int Id;
  late int sId;

    bool checkAvelability(int time,int day){
    if(time < 0 || time*2 >= (endTime-startTime)*2 ){
      return false;
    }
    
    if( avelability[day][time*2] == true){
      return false;
    }
    return true;
  }

  Doctor({required this.name, required this.specialization, required this.startTime, required this.endTime,required this.Id});
}