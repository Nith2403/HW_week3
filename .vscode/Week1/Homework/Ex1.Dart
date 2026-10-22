void main (){
  var scores = {
  "Dara": 78,
  "Sokha": 45,
  "Lina": 62,
  "Vanna": 39,
  "Mony": 85 
};
print(getPassedStudents(scores));
}


List<String> getPassedStudents(Map<String,int> scores){
  final List<String> passed = [];

  scores.forEach((name,score){
    if(score>=50){
      passed.add(name);
    }
  });
  return passed;
    
}


