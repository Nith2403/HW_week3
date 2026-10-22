void main(){
Rectangle r1 = Rectangle(width: 10, height: 30); // create obj1
r1.resize(2, 1);
print(r1); // r1 is print when we override
}

class Rectangle {
  int width;
  int height; // att of class, information that class contain

  Rectangle({required this.width, required this.height});//store pass value

  void resize(int deltaW, int deltaH){ // method to resize class
    width += deltaW; // width = width + increase size
    height += deltaH;
  }

  @override // print the current value
  String toString(){
    return "My rectangle is : width = $width - height = $height";
  }
}