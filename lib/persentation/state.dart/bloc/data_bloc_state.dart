part of 'data_bloc_bloc.dart';

@immutable
abstract class DataUserBlocState extends Equatable {
  const DataUserBlocState();
  @override
  List<Object> get props => [];
}

final class DataUserBlocInitial extends DataUserBlocState {}

final class DataUserBlocLoading extends DataUserBlocState {}

final class DepartmentBlocLoaded extends DataUserBlocState {
  final ProductListingResponse? response;

  const DepartmentBlocLoaded({
    this.response,
  });

  @override
  List<Object> get props => [];
}

final class ProductBlocLoaded extends DataUserBlocState {
  final ProductListingResponse? response;

  const ProductBlocLoaded({
    this.response,
  });

  @override
  List<Object> get props => [];
}

final class ProductBlocError extends DataUserBlocState {
  final bool? message;

  const ProductBlocError({this.message});

  @override
  List<Object> get props => [message!];
}
