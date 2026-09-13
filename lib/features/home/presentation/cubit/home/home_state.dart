part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final List<NoteModel>? notes;
  HomeSuccess({this.notes});
}

final class HomeError extends HomeState {
  final String erorrMassage;

  HomeError({required this.erorrMassage});
}
