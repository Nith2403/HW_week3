class Point {
  int x;
  int y;

  Point({required this.x, required this.y}) {} // named parameteres

  void translate(int deltaX, int deltaY) {
    this.x += deltaX;
    this.y += deltaY;
  }

  @override
  String toString() {
    return "my point is : x=$x - y=$y";
  }
}

void main() {
  Point p1 = Point(x: 10, y: 10);

  p1.translate(50, 100);
  print(p1);
}