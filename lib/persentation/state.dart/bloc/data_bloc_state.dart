part of 'data_bloc_bloc.dart';

@immutable
abstract class DataBlocState extends Equatable {
  const DataBlocState();
  @override
  List<Object> get props => [];
}

final class DataBlocInitial extends DataBlocState {}

final class DataBlocLoading extends DataBlocState {}

final class DepartmentBlocLoaded extends DataBlocState {
  final ProductListingResponse? response;

  const DepartmentBlocLoaded({
    this.response,
  });

  @override
  List<Object> get props => [];
}

final class ProductBlocLoaded extends DataBlocState {
  final ProductListingResponse? response;

  const ProductBlocLoaded({
    this.response,
  });

  @override
  List<Object> get props => [];
}

final class ProductBlocError extends DataBlocState {
  final bool? message;

  const ProductBlocError({this.message});

  @override
  List<Object> get props => [message!];
}
