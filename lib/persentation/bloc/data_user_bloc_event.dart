part of 'data_user_bloc_bloc.dart';

@immutable
abstract class DataUserBlocEvent extends Equatable {
  const DataUserBlocEvent();
  @override
  List<Object> get props => [];
}

final class FetchDataUserEvent extends DataUserBlocEvent {}
