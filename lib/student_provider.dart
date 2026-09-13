import 'package:flutter/material.dart';

class StudentProvider extends ChangeNotifier {
  // Temporary in-memory JSON-like data
  final List<Map<String, dynamic>> _students = [
    {
      'id': 1,
      'name': 'Rahul',
      'email': 'rahul@gmail.com',
      'course': 'MSc IT',
    },
    {
      'id': 2,
      'name': 'Priya',
      'email': 'priya@gmail.com',
      'course': 'BCA',
    },
  ];
  List<Map<String, dynamic>> get students => _students;

  void addStudent({required String name, required String email, required String course}) {
    _students.add({"id": DateTime.now().microsecondsSinceEpoch, "name": name, "email": email, "course": course});
  }

  void updateStudent({required int id, String? name, String? course, String? email}) {
    final index = _students.indexWhere((student) => student["id"] == id);
    if (index != -1) {
      _students[index] = {
        'id': id,
        'name': name ?? _students[index]["name"],
        'email': email ?? _students[index]["email"],
        'course': course ?? _students[index]["course"]
      };
      notifyListeners();
    }
  }

  void deleteStudent(int id) {
    _students.removeWhere(
      (student) => student['id'] == id,
    );

    notifyListeners();
  }
}
