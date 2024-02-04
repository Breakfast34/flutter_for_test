part of 'data_bloc_bloc.dart';

@immutable
abstract class DataBlocEvent extends Equatable {
  const DataBlocEvent();
  @override
  List<Object> get props => [];
}

final class DepartmentEvent extends DataBlocEvent {
  const DepartmentEvent();
  @override
  List<Object> get props => [];
}

final class ProductEvent extends DataBlocEvent {
  final String click;

  const ProductEvent({
    required this.click,
  });
  @override
  List<Object> get props => [click];
}
