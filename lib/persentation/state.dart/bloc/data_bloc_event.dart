part of 'data_bloc_bloc.dart';

@immutable
abstract class DataUserBlocEvent extends Equatable {
  const DataUserBlocEvent();
  @override
  List<Object> get props => [];
}

final class FetchDataUserEvent extends DataUserBlocEvent {
  final String? click;
  const FetchDataUserEvent({
    this.click,
  });
  @override
  List<Object> get props => [];
}

final class DataUserEvent extends DataUserBlocEvent {
  final String click;

  const DataUserEvent({
    required this.click,
  });
  @override
  List<Object> get props => [click];
}
