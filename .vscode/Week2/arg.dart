
void main() {
  printStudent(name: "Ronan", score: [15, 20, 45]);
  printStudent(name: "mina", score: [15, 20, 45], age: 12);
}

void printStudent({
  required String name,
  int age = 20,
  String? address,
  required List<int> score,
}) {
  print("Student : $name");
  print("Age : $age");

  String addValue;

  if (address != null) {
    addValue = address;
  } else {
    addValue = "No address";
  }

  print("Address : $addValue");

  String scoresLabel = "";

  for (int scoreItem in score) {
    scoresLabel += scoreItem.toString() + " ";
  }

  print("Score : $scoresLabel");
}
