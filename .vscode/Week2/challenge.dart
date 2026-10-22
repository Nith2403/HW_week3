class Point {
  int x;
  int y;

  Point({required this.x, required this.y}) {}

  @override
  String toString() {
    return "Point x= $x, y=$y";
  }

  void translate({required int deltaX, required int deltaY}) {
    x += deltaX;
    y += deltaY;
  }
}

void main() {
  // test
  Point p1 = Point(x: 10, y: 20);
  print(p1);

  p1.translate( deltaX: 100, deltaY: 200);
  print(p1);
}
