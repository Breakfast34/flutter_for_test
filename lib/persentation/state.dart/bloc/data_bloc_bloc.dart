// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_package_2/data_flutter_for_test.dart';
import 'package:meta/meta.dart';

part 'data_bloc_event.dart';
part 'data_bloc_state.dart';

class DataUserBloc extends Bloc<DataUserBlocEvent, DataUserBlocState> {
  late ProductListingResponse response1;
  late ProductListingResponse response2;
  late String cilck;
  DataUserBloc() : super(DataUserBlocInitial()) {
    on<DataUserBlocEvent>((event, emit) async {
      switch (event.runtimeType) {
        case FetchDataUserEvent:
          await _handleDataUserEvent(event as FetchDataUserEvent, emit);
          break;
        case DataUserEvent:
          await _hendleProduct(event as DataUserEvent, emit);
          break;
        default:
      }
    });
  }

  Future<void> _handleDataUserEvent(
    FetchDataUserEvent event,
    Emitter<DataUserBlocState> emit,
  ) async {
    emit(DataUserBlocLoading());

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
    DataUserEvent event,
    Emitter<DataUserBlocState> emit,
  ) async {
    emit(DataUserBlocLoading());
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
