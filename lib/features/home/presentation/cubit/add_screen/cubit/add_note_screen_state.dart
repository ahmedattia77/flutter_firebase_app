part of 'add_note_screen_cubit.dart';

@immutable
sealed class AddNoteScreenState {}

final class AddNoteScreenInitial extends AddNoteScreenState {}

final class HomeAddNoteLoading extends AddNoteScreenState {}

final class HomeAddNoteSuccess extends AddNoteScreenState {
  HomeAddNoteSuccess();
}

final class HomeAddNoteError extends AddNoteScreenState {
  final String erorrMassage;
  HomeAddNoteError({required this.erorrMassage});
}
