import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_crud_provider/student_provider.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<StudentProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: provider.students.length,
                    itemBuilder: (context, index) {
                      final student = provider.students[index];
                      return Card(
                        margin: EdgeInsets.all(16),
                        child: ListTile(
                          title: Text(student['name']),
                          subtitle: Text(
                            '${student['email']}\n${student['course']}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  _showStudentDialog(
                                    context,
                                    provider,
                                    student,
                                  );
                                },
                              ),

                              // DELETE
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  provider.deleteStudent(
                                    student['id'],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              )
            ],
          );
        },
      ),
      // ADD
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showStudentDialog(
            context,
            Provider.of<StudentProvider>(
              context,
              listen: false,
            ),
            null,
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

void _showStudentDialog(
  BuildContext context,
  StudentProvider provider,
  Map<String, dynamic>? student,
) {
  final nameController = TextEditingController(
    text: student?['name'] ?? '',
  );

  final emailController = TextEditingController(
    text: student?['email'] ?? '',
  );

  final courseController = TextEditingController(
    text: student?['course'] ?? '',
  );

  final isEdit = student != null;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          isEdit ? 'Update Student' : 'Add Student',
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: courseController,
              decoration: const InputDecoration(
                labelText: 'Course',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (isEdit) {
                // UPDATE
                provider.updateStudent(
                  id: student['id'],
                  name: nameController.text,
                  email: emailController.text,
                  course: courseController.text,
                );
              } else {
                // ADD
                provider.addStudent(
                  name: nameController.text,
                  email: emailController.text,
                  course: courseController.text,
                );
              }

              Navigator.pop(context);
            },
            child: Text(
              isEdit ? 'Update' : 'Add',
            ),
          ),
        ],
      );
    },
  );
}
