import 'student.dart';

class Course {
  final String id;
  final String name;
  final List<Student> students = [];

  Course({
    required this.id,
    required this.name,
  });
}