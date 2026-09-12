import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/core/helper/fire_base_helper.dart';
import 'package:flutter_firebase_app/features/home/data/model/note_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> addNote({
    required String title,
    required String subTitle,
    required String details,
    required int color,
  }) async {
    emit(HomeAddNoteLoading());
    try {
      await FireBaseHelper.firestore
          .collection('users')
          .doc(FireBaseHelper.user!.uid)
          .collection('notes')
          .add({
            'title': title,
            'subTitle': subTitle,
            'details': details,
            'color': color,
            'createdAt': FieldValue.serverTimestamp(),
          });
      emit(HomeAddNoteSuccess());
    } on FirebaseException catch (e) {
      emit(HomeAddNoteError(erorrMassage: e.message ?? 'Failed to add note'));
    } catch (e) {
      emit(HomeAddNoteError(erorrMassage: 'Unexpected error occurred: $e'));
    }
  }

  Future<void> fetchNotes() async {
    emit(HomeLoading());

    try {
      final querySnapshot = await FireBaseHelper.firestore
          .collection('users')
          .doc(FireBaseHelper.user!.uid)
          .collection('notes')
          .orderBy('createdAt', descending: true)
          .get();

      final List<NoteModel> notes = querySnapshot.docs
          .map((doc) => NoteModel.fromFirestore(doc))
          .toList();

      emit(HomeSuccess(notes: notes));
    } on FirebaseException catch (e) {
      emit(HomeError(erorrMassage: e.message ?? 'Failed to fetch notes'));
    } catch (e) {
      emit(HomeError(erorrMassage: 'Unexpected error occurred: $e'));
    }
  }

  Future<void> deleteNote({required String noteId}) async {
    try {
      await FireBaseHelper.firestore
          .collection('users')
          .doc(FireBaseHelper.user!.uid)
          .collection('notes')
          .doc(noteId)
          .delete();

      await fetchNotes();
    } on FirebaseException catch (e) {
      emit(HomeError(erorrMassage: e.message ?? 'Failed to delete note'));
    } catch (e) {
      emit(HomeError(erorrMassage: 'Unexpected error occurred: $e'));
    }
  }
}
