import '../model/student.dart';
import '../model/course.dart';
import '../model/course_result.dart';

class LmsSystem {
  final List<Student> students = [];

  void addStudent({required String studentId,required String studentName,}) {
    // Student shall not exist already.
    Student? student = _findStudentOrNull(studentId);

    if (student != null) {
      throw Exception('Student $studentId already exists');
    }

    students.add(Student(id: studentId, name: studentName));
  }

  Student? _findStudentOrNull(String studentId) {
    for (Student s in students) {
      if (s.id == studentId) {
        return s;
      }
    }

    return null; // not found
  }

  final List<Course> courses = [];
  final List<CourseResult> results = [];

  // TASK 1: Add a course
  void addCourse(String courseId, String courseName) {
    Course? course = _findCourseOrNull(courseId);

    if (course != null) {
      throw Exception('Course $courseId already exists.');
    }

    courses.add(
      Course(id: courseId, name: courseName),
    );
  }

  // Remove a course and all its results.
  void removeCourse(String courseId) {
    Course? course = _findCourseOrNull(courseId);

    if (course == null) {
      throw Exception('Course $courseId does not exist.');
    }

    courses.removeWhere((c) => c.id == courseId); 

    // Remove results belonging to this course. when course delete result delete too
    results.removeWhere((result) => result.courseId == courseId);
  }

  // TASK 2: Enrol a student in a course
  void enrollStudent(String studentId, String courseId) {
    Student? student = _findStudentOrNull(studentId);
    Course? course = _findCourseOrNull(courseId);

    if (student == null) {
      throw Exception('Student $studentId does not exist.');
    }

    if (course == null) {
      throw Exception('Course $courseId does not exist.');
    }
  //check whenever at least one student's id macthc the given id(student already enroll)
    if (course.students.any((s) => s.id == studentId)) {
      throw Exception('Student $studentId is already enrolled.');
    }

    course.students.add(student);
  }

  // TASK 3: Remove a student from a course
  void discardStudentFromCourse(String studentId, String courseId) {
    Student? student = _findStudentOrNull(studentId);
    Course? course = _findCourseOrNull(courseId);

    if (student == null) {
      throw Exception('Student $studentId does not exist.');
    }

    if (course == null) {
      throw Exception('Course $courseId does not exist.');
    }

    if (!course.students.any((s) => s.id == studentId)) {
      throw Exception('Student $studentId is not enrolled.');
    }

    // Remove the enrolment.
    course.students.removeWhere((s) => s.id == studentId);

    // Remove this student's result for this course, if present.
    results.removeWhere(
      (result) =>
          result.studentId == studentId &&
          result.courseId == courseId,
    );
  }

  // TASK 4: Add a result
  // score must be 0-100, with one result ,per student per course.
  void addResult(String studentId, String courseId, double score) {
    Student? student = _findStudentOrNull(studentId);
    Course? course = _findCourseOrNull(courseId);

    if (student == null) {
      throw Exception('Student $studentId does not exist.');
    }

    if (course == null) {
      throw Exception('Course $courseId does not exist.');
    }

    if (!course.students.any((s) => s.id == studentId)) {
      throw Exception('Student $studentId is not enrolled.');
    }

    if (score < 0 || score > 100) {
      throw ArgumentError('Score must be between 0 and 100.');
    }

    final existingResult = _findResultOrNull(studentId, courseId);

    if (existingResult != null) {
      throw Exception(
        'A result already exists for this student and course.',
      );
    }

    results.add(
      CourseResult(
        studentId: studentId,
        courseId: courseId,
        score: score,
      ),
    );
  }

  // TASK 5: Remove a result
  // studentId + courseId identifies the result.
  void removeResult(String studentId, String courseId) {
    CourseResult? result = _findResultOrNull(studentId, courseId);

    if (result == null) {
      throw Exception('Result does not exist.');
    }

    results.remove(result);
  }

  // Remove a student completely from the LMS.
  void removeStudent({required String studentId}) {
    Student? student = _findStudentOrNull(studentId);

    if (student == null) {
      throw Exception('Student $studentId does not exist.');
    }

    // 1. Remove the student from the global list.
    students.removeWhere((s) => s.id == studentId);

    // 2. Remove the student from every course.
    for (final course in courses) {
      course.students.removeWhere((s) => s.id == studentId);
    }

    // 3. Remove all results belonging to this student.
    results.removeWhere(
      (result) => result.studentId == studentId,
    );
  }

  // Find a course by ID.
  Course? _findCourseOrNull(String courseId) {
    for (Course course in courses) {
      if (course.id == courseId) {
        return course;
      }
    }

    return null;
  }

  // Find a result by student ID and course ID.
  CourseResult? _findResultOrNull(
    String studentId,
    String courseId,
  ) {
    for (CourseResult result in results) {
      if (result.studentId == studentId &&
          result.courseId == courseId) {
        return result;
      }
    }

    return null;
  }
}