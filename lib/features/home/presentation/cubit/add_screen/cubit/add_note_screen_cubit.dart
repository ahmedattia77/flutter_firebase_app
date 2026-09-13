import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_app/core/helper/fire_base_helper.dart';
import 'package:meta/meta.dart';

part 'add_note_screen_state.dart';

class AddNoteScreenCubit extends Cubit<AddNoteScreenState> {
  AddNoteScreenCubit() : super(AddNoteScreenInitial());

  Future<void> addNote({
    required String title,
    required String subTitle,
    required String details,
    required int color,
  }) async {
    emit(HomeAddNoteLoading());
    print('addnotecubit >>>>>>>>111111111111111');

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
      print('addnotecubit >>>>>>>>');
      emit(HomeAddNoteSuccess());
    } on FirebaseException catch (e) {
      emit(HomeAddNoteError(erorrMassage: e.message ?? 'Failed to add note'));
    } catch (e) {
      emit(HomeAddNoteError(erorrMassage: 'Unexpected error occurred: $e'));
    }
  }
}
