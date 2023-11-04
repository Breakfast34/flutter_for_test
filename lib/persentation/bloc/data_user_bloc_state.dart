part of 'data_user_bloc_bloc.dart';

@immutable
abstract class DataUserBlocState extends Equatable {
  const DataUserBlocState();
  @override
  List<Object> get props => [];
}

final class DataUserBlocInitial extends DataUserBlocState {}

final class DataUserBlocLoading extends DataUserBlocState {}

final class DataUserBlocLoaded extends DataUserBlocState {
  final RemoteDataUsers listUsers;

  const DataUserBlocLoaded({required this.listUsers});

  @override
  List<Object> get props => [listUsers];
}

final class DataUserBlocError extends DataUserBlocState {
  final String? message;

  const DataUserBlocError({this.message});

  @override
  List<Object> get props => [message!];
}
