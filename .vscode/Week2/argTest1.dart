void printTeacher({
  required String name,
  int age = 20,
  String? subject,
}){
  // name
  print("Teacher : $name");
  print("Age : $age");

  String sub;
  if(subject != null){
    Sub = subject;
  }else{
    subject = "no subject";
  }
  print ("Subject = $Sub");

}
void main(){
 ++ printTeacher(name: "nina", subject: "dart");
}