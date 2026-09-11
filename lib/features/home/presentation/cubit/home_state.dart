part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final List<NoteModel> notes;
  HomeSuccess({required this.notes});
}

final class HomeError extends HomeState {
  final String erorrMassage;

  HomeError({required this.erorrMassage});
}

final class HomeAddNoteLoading extends HomeState {}

final class HomeAddNoteSuccess extends HomeState {
  HomeAddNoteSuccess();
}

final class HomeAddNoteError extends HomeState {
  final String erorrMassage;
  HomeAddNoteError({required this.erorrMassage});
}
