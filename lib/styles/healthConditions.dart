enum Health{
    Ophthalmologist, ENT, Neurologist, Orthopedic, Familydoctor, Pediatrist
}
List<Health> stringtoHealth(String arr){
      List<Health> list = [];
      for (var element in arr.split(",")) {
        list.add(Health.values.byName(element));
      }
      return list;
    }

List<String> healthToString(List<Health> arr){
  List<String> list = [];
  for (var element in arr) {
    list.add(element.name);
  }
  return list;
}