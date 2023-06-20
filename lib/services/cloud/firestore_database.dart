import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:notella/services/cloud/constants.dart';

import 'exceptions.dart';

class FirestoreDatabase {
  static final FirestoreDatabase _shared = FirestoreDatabase._sharedInstance();
  FirestoreDatabase._sharedInstance();
  factory FirestoreDatabase() {
    return _shared;
  }

  final notes = FirebaseFirestore.instance.collection('notes');
  final todos = FirebaseFirestore.instance.collection('todos');

  Future<CloudNote> createNote(
      {required String ownerId, required String content}) async {
    try {
      final note = await notes.add({
        'documentUserId': ownerId,
        'documentText': content,
      });

      return CloudNote(noteId: note.id, userId: ownerId, text: content);
    } catch (e) {
      throw CouldNotCreateNoteException();
    }
  }

  Stream<Iterable<CloudNote>> allNotes({required String ownerId}) {
    try {
      return notes
          .where('documentUserId', isEqualTo: ownerId)
          .snapshots()
          .map((event) => event.docs.map((doc) => CloudNote.fromSnapshot(doc)));
    } catch (e) {
      throw CouldNotGetAllNotesException();
    }
  }

  Future<void> updateNote(
      {required String noteId, required String text}) async {
    try {
      await notes.doc(noteId).update({
        'documentText': text,
      });
    } catch (e) {
      throw CouldNotUpdateNoteException();
    }
  }

  Future<void> deleteNote({
    required String noteId,
  }) async {
    try {
      await notes.doc(noteId).delete();
    } catch (e) {
      throw CouldNoteDeleteNoteException();
    }
  }

  Future<CloudTodo> createTodo(
      {required String noteId, required String text}) async {
    try {
      final todo = await todos.add({'note_id': noteId, 'text': text,'done':false});
      return CloudTodo(todo.id, noteId, text);
    } catch (e) {
      throw Exception();
    }
  }
}

@immutable
class CloudNote {
  final String noteId;
  final String userId;
  final String text;
  const CloudNote({
    required this.noteId,
    required this.userId,
    required this.text,
  });

  CloudNote.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : noteId = snapshot.id,
        userId = snapshot.data()['documentUserId'] as String,
        text = snapshot.data()['documentText'] as String;
}

class CloudTodo {
  final String todoId;
  final String noteId;
  final String text;
  bool? done;

  CloudTodo(this.todoId, this.noteId, this.text);
  CloudTodo.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : todoId = snapshot.id,
        noteId = snapshot.data()['note_id'],
        text = snapshot.data()['text'],
        done = snapshot.data()['done'];
}
