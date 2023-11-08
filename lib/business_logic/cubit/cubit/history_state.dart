part of 'history_cubit.dart';

@immutable
sealed class HistoryState {}

final class HistoryInitial extends HistoryState {}

final class BoxInitialize extends HistoryState {}

final class AddToHistory extends HistoryState {}

final class TeamALarger extends HistoryState {}

final class TeamBLarger extends HistoryState {}

final class Reset extends HistoryState {}

final class GetHistory extends HistoryState {}

final class DeleteItem extends HistoryState {}

final class ChangeScreen extends HistoryState {}

final class ActivateAddButton extends HistoryState {}

final class Error extends HistoryState {
  final String error;
  Error({required this.error});
}
