import 'package:test/test.dart';
import '../lib/service/lms_system.dart';

void main() {
  

  // student test
  //create student
  test('Create a student', () {
    final service = LmsSystem();
    //prepare data or codition need for the test
    service.addStudent(studentId: 'S1', studentName: 'nithh');//act

    // check whenever the outcome is correct
    expect(service.students.length, 1); 
    expect(service.students.first.id, 'S1');
    expect(service.students.first.name, 'nithh');
  });
  //cannot create a duplicate student
  test('Cannot create a duplicate student', () {
    final service = LmsSystem();
    service.addStudent(studentId: 'S1', studentName: 'nithh');

    expect(
      () => service.addStudent(studentId: 'S1', studentName: 'lili'),
      throwsException,
    );
  });
  //remove student
  test('Remove a student', () {
    final service = LmsSystem();
    service.addStudent(studentId: 'S1', studentName: 'nithh');

    service.removeStudent(studentId: 'S1');

    expect(service.students, isEmpty);
  });

  test('Cannot remove a student that does not exist', () {
    final service = LmsSystem();
    expect(
      () => service.removeStudent(studentId: 'S999'),
      throwsException,
    );
  });

  test('Remove a student enrolled in multiple courses', () { // cuz student can enroll many course
  final service = LmsSystem();
    service.addStudent(studentId: 'S1', studentName: 'nithh');
    service.addStudent(studentId: 'S2', studentName: 'lili');
    service.addCourse('C1', 'Programming');
    service.addCourse('C2', 'Mathematics');

    service.enrollStudent('S1', 'C1');
    service.enrollStudent('S1', 'C2');
    service.enrollStudent('S2', 'C1');

    service.addResult('S1', 'C1', 80.0);
    service.addResult('S1', 'C2', 90.0);
    service.addResult('S2', 'C1', 75.0);

    service.removeStudent(studentId: 'S1');

    expect(service.students.any((s) => s.id == 'S1'), isFalse);
    expect(service.courses.length, 2);

    // S1 is removed from every course, S2 stays in C1.
    for (final course in service.courses) {
      expect(course.students.any((s) => s.id == 'S1'), isFalse); // loop one course and expect at least one student has id S1
    }
    expect( // check that C1 is remain in course
      service.courses.firstWhere((c) => c.id == 'C1') //check when C1 still remain
          .students
          .map((s) => s.id),
      ['S2'],
    );

    // S1's results are removed, S2's result remains.
    expect(service.results.length, 1);
    expect(service.results.first.studentId, 'S2');
    expect(service.results.first.score, 75.0);
  });

  // course test
  test('Create a course', () {
    final service = LmsSystem();
    service.addCourse('C1', 'Programming');

    expect(service.courses.length, 1);
    expect(service.courses.first.id, 'C1');
    expect(service.courses.first.name, 'Programming');
  });

  test('Cannot create a duplicate course', () {
    final service = LmsSystem();
    service.addCourse('C1', 'Programming');

    expect(
      () => service.addCourse('C1', 'Mathematics'),
      throwsException,
    );
  });

  test('Remove a course and its results', () {
    final service = LmsSystem();
    service.addStudent(studentId: 'S1', studentName: 'ronan');
    service.addCourse('C1', 'Programming');
    service.enrollStudent('S1', 'C1');
    service.addResult('S1', 'C1', 85.0);

    service.removeCourse('C1');

    expect(service.courses, isEmpty);
    expect(service.results, isEmpty);
    expect(service.students.length, 1);
  });

  test('Cannot remove a course that does not exist', () {
    final service = LmsSystem();
    expect(
      () => service.removeCourse('C999'),
      throwsException,
    );
  });

  // enrollment test
  test('Enroll a student in a course', () {
    final service = LmsSystem();
    service.addStudent(studentId: 'S1', studentName: 'ronan');
    service.addCourse('C1', 'Programming');

    service.enrollStudent('S1', 'C1');

    expect(service.courses.first.students.length, 1);
    expect(service.courses.first.students.first.id, 'S1');
  });

  test('Cannot enroll a student that does not exist', () {
    final service = LmsSystem();
    service.addCourse('C1', 'Programming');

    expect(
      () => service.enrollStudent('S1', 'C1'),
      throwsException,
    );
    expect(service.courses.first.students, isEmpty);
  });

  test('Cannot enroll in a course that does not exist', () {
    final service = LmsSystem();
    service.addStudent(studentId: 'S1', studentName: 'ronan');

    expect(
      () => service.enrollStudent('S1', 'C1'),
      throwsException,
    );
  });

  test('Cannot enroll the same student twice', () {
    final service = LmsSystem();
    service.addStudent(studentId: 'S1', studentName: 'ronan');
    service.addCourse('C1', 'Programming');
    service.enrollStudent('S1', 'C1');

    expect(
      () => service.enrollStudent('S1', 'C1'),
      throwsException,
    );
    expect(service.courses.first.students.length, 1);
  });

  // enrollment remove 
  test('Remove an enrollment', () {
    final service = LmsSystem();
    service.addStudent(studentId: 'S1', studentName: 'ronan');
    service.addCourse('C1', 'Programming');
    service.enrollStudent('S1', 'C1');

    service.discardStudentFromCourse('S1', 'C1');

    expect(service.courses.first.students, isEmpty);

    // Student and course must still exist.
    expect(service.students.length, 1);
    expect(service.courses.length, 1);
  });

  test('Cannot remove an enrollment that does not exist', () {
    final service = LmsSystem();
    service.addStudent(studentId: 'S1', studentName: 'ronan');
    service.addCourse('C1', 'Programming');

    expect(
      () => service.discardStudentFromCourse('S1', 'C1'),
      throwsException,
    );
  });

  test('Removing an enrollment also removes its result', () {
    final service = LmsSystem();
    service.addStudent(studentId: 'S1', studentName: 'ronan');
    service.addCourse('C1', 'Programming');
    service.enrollStudent('S1', 'C1');
    service.addResult('S1', 'C1', 85.0);

    service.discardStudentFromCourse('S1', 'C1');

    expect(service.courses.first.students, isEmpty);
    expect(service.results, isEmpty);
  });

  test('Remove a student from one course without affecting other courses', () {
    final service = LmsSystem();
    service.addStudent(studentId: 'S1', studentName: 'ronan');
    service.addStudent(studentId: 'S2', studentName: 'alex');
    service.addCourse('C1', 'Programming');
    service.addCourse('C2', 'Mathematics');

    service.enrollStudent('S1', 'C1');
    service.enrollStudent('S1', 'C2');
    service.enrollStudent('S2', 'C1');

    service.addResult('S1', 'C1', 80.0);
    service.addResult('S1', 'C2', 90.0);
    service.addResult('S2', 'C1', 75.0);

    service.discardStudentFromCourse('S1', 'C1');

    expect(
      service.courses
          .firstWhere((c) => c.id == 'C1')
          .students
          .map((s) => s.id),
      ['S2'],
    );
    expect(
      service.courses
          .firstWhere((c) => c.id == 'C2')
          .students
          .map((s) => s.id),
      ['S1'],
    );

    // Only the result for S1 in C1 is deleted.
    expect(service.results.length, 2);
    expect(
      service.results.any((r) => r.studentId == 'S1' && r.courseId == 'C1'),
      isFalse,
    );
  });

  // result test
  test('Add a result', () {
    final service = LmsSystem();
    service.addStudent(studentId: 'S1', studentName: 'ronan');
    service.addCourse('C1', 'Programming');
    service.enrollStudent('S1', 'C1');

    service.addResult('S1', 'C1', 85.0);

    expect(service.results.length, 1);
    expect(service.results.first.studentId, 'S1');
    expect(service.results.first.courseId, 'C1');
    expect(service.results.first.score, 85.0);
  });

  test('Accept boundary scores of 0 and 100', () {
    final service = LmsSystem();
    service.addStudent(studentId: 'S1', studentName: 'ronan');
    service.addStudent(studentId: 'S2', studentName: 'alex');
    service.addCourse('C1', 'Programming');
    service.addCourse('C2', 'Mathematics');
    service.enrollStudent('S1', 'C1');
    service.enrollStudent('S2', 'C2');

    service.addResult('S1', 'C1', 0.0);
    service.addResult('S2', 'C2', 100.0);

    expect(service.results.length, 2);
    expect(service.results[0].score, 0.0);
    expect(service.results[1].score, 100.0);
  });

  test('Cannot add a result for a student that does not exist', () {
    final service = LmsSystem();
    service.addCourse('C1', 'Programming');

    expect(
      () => service.addResult('S1', 'C1', 85.0),
      throwsException,
    );
    expect(service.results, isEmpty);
  });

  test('Cannot add a result for a course that does not exist', () {
    final service = LmsSystem();
    service.addStudent(studentId: 'S1', studentName: 'ronan');

    expect(
      () => service.addResult('S1', 'C1', 85.0),
      throwsException,
    );
    expect(service.results, isEmpty);
  });

  test('Cannot add a result if the student is not enrolled', () {
    final service = LmsSystem();
    service.addStudent(studentId: 'S1', studentName: 'ronan');
    service.addCourse('C1', 'Programming');

    expect(
      () => service.addResult('S1', 'C1', 85.0),
      throwsException,
    );
    expect(service.results, isEmpty);
  });

  test('Cannot add a score below 0', () {
    final service = LmsSystem();
    service.addStudent(studentId: 'S1', studentName: 'ronan');
    service.addCourse('C1', 'Programming');
    service.enrollStudent('S1', 'C1');

    expect(
      () => service.addResult('S1', 'C1', -1.0),
      throwsArgumentError,
    );
    expect(service.results, isEmpty);
  });

  test('Cannot add a score above 100', () {
    final service = LmsSystem();
    service.addStudent(studentId: 'S1', studentName: 'ronan');
    service.addCourse('C1', 'Programming');
    service.enrollStudent('S1', 'C1');

    expect(
      () => service.addResult('S1', 'C1', 101.0),
      throwsArgumentError,
    );
    expect(service.results, isEmpty);
  });

  test('Cannot add a duplicate result for the same student and course', () {
    final service = LmsSystem();
    service.addStudent(studentId: 'S1', studentName: 'ronan');
    service.addCourse('C1', 'Programming');
    service.enrollStudent('S1', 'C1');
    service.addResult('S1', 'C1', 85.0);

    expect(
      () => service.addResult('S1', 'C1', 90.0),
      throwsException
    );
    expect(service.results.length, 1);
    expect(service.results.first.score, 85.0);
  });

  // remove result test
  test('Remove a result', () {
    final service = LmsSystem();
    service.addStudent(studentId: 'S1', studentName: 'ronan');
    service.addCourse('C1', 'Programming');
    service.enrollStudent('S1', 'C1');
    service.addResult('S1', 'C1', 85.0);

    service.removeResult('S1', 'C1');

    expect(service.results, isEmpty);
  });

  test('Cannot remove a result that does not exist', () {
    final service = LmsSystem();
    service.addStudent(studentId: 'S1', studentName: 'ronan');
    service.addCourse('C1', 'Programming');

    expect(
      () => service.removeResult('S1', 'C1'),
      throwsException,
    );
  });

  test('Remove only the selected result and keep other data', () {
    final service = LmsSystem();
    service.addStudent(studentId: 'S1', studentName: 'ronan');
    service.addStudent(studentId: 'S2', studentName: 'alex');
    service.addCourse('C1', 'Programming');
    service.addCourse('C2', 'Mathematics');

    service.enrollStudent('S1', 'C1');
    service.enrollStudent('S1', 'C2');
    service.enrollStudent('S2', 'C1');

    service.addResult('S1', 'C1', 85.0);
    service.addResult('S1', 'C2', 90.0);
    service.addResult('S2', 'C1', 75.0);

    service.removeResult('S1', 'C1');

    expect(service.results.length, 2);
    expect(
      service.results.any((r) => r.studentId == 'S1' && r.courseId == 'C1'),
      isFalse,
    );
    expect(
      service.results.any(
        (r) => r.studentId == 'S1' && r.courseId == 'C2' && r.score == 90.0,
      ),
      isTrue,
    );
    expect(
      service.results.any(
        (r) => r.studentId == 'S2' && r.courseId == 'C1' && r.score == 75.0,
      ),
      isTrue,
    );

    // Students, courses and enrollments are unchanged.
    expect(service.students.length, 2);
    expect(service.courses.length, 2);
  });
}