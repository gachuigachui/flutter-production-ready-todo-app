import 'package:super_do/data/models/todo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final FirebaseFirestore firestore;

  Database({required this.firestore});

  Stream<List<Todo>> streamTodos(String uid) {
    try {
      return firestore
          .collection('todos')
          .doc(uid)
          .collection('todos')
          .where('isDone', isEqualTo: false)
          .snapshots()
          .map((query) {
        List<Todo> todos = [];
        for (var doc in query.docs) {
          todos.add(Todo.fromDocumentSnapshot(snapshot: doc));
        }
        return todos;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addTodo(String content, String uid) async {
    try {
      firestore
          .collection('todos')
          .doc(uid)
          .collection('todos')
          .add({"content": content, "isDone": false});
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateTodo(String uid, String todoId, bool status) async {
    try {
      firestore
          .collection('todos')
          .doc(uid)
          .collection('todos')
          .doc(todoId)
          .update({"isDone": status});
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTodo({required String uid, required String todoId}) async {
    try {
      firestore
          .collection('todos')
          .doc(uid)
          .collection('todos')
          .doc(todoId)
          .delete();
    } catch (e) {}
  }
}
