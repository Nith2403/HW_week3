void main() {
  const scores = [45, 78, 62, 49, 85, 33, 90, 50];

  final passes = scores.where((score) {
    return score >= 50;
  }).toList();

  print(passes);   
}