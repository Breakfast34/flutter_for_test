// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_package_2/data_flutter_for_test.dart';
import 'package:meta/meta.dart';

part 'data_bloc_event.dart';
part 'data_bloc_state.dart';

class DataBloc extends Bloc<DataBlocEvent, DataBlocState> {
  late ProductListingResponse response1;
  late ProductListingResponse response2;
  late String cilck;
  DataBloc() : super(DataBlocInitial()) {
    on<DataBlocEvent>((event, emit) async {
      switch (event.runtimeType) {
        case DepartmentEvent:
          await _handleDataUserEvent(event as DepartmentEvent, emit);
          break;
        case ProductEvent:
          await _hendleProduct(event as ProductEvent, emit);
          break;
        default:
      }
    });
  }

  Future<void> _handleDataUserEvent(
    DepartmentEvent event,
    Emitter<DataBlocState> emit,
  ) async {
    emit(DataBlocLoading());

    try {
      final departmentResult = await getIt<DepartmentUsecase>().execute();

      departmentResult.fold(
        (error) => emit(const ProductBlocError(message: true)),
        (department) async {
          response1 = ProductListingResponse(
            departments: department,
            products: [],
          );
          emit(DepartmentBlocLoaded(response: response1));
        },
      );
    } catch (e) {
      emit(const ProductBlocError(message: true));
    }
  }

  Future<void> _hendleProduct(
    ProductEvent event,
    Emitter<DataBlocState> emit,
  ) async {
    emit(DataBlocLoading());
    try {
      cilck = event.click;
      if (cilck != '') {
        await getIt<ProductUsecase>().execute(cilck).then((value) {
          value.fold(
            (error) => emit(const ProductBlocError(message: true)),
            (listProducts) async {
              response2 = ProductListingResponse(
                departments: response1.departments,
                products: listProducts,
              );
              emit(ProductBlocLoaded(response: response2));
            },
          );
        });
      }
    } catch (e) {
      emit(const ProductBlocError(message: true));
    }
  }
}
