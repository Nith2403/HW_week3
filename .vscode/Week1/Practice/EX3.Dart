void main() {
  List<int> scores = [45,78,62,49,85,33,90,50];
  List<int> passing = [];
  
for (int score in scores){
  if(score >= 50){
    passing.add(score);
  }
    
  }
  print(passing);
 
}


