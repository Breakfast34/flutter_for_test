// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_package_2/data_flutter_for_test.dart';
import 'package:meta/meta.dart';

part 'data_user_bloc_event.dart';
part 'data_user_bloc_state.dart';

class DataUserBloc extends Bloc<DataUserBlocEvent, DataUserBlocState> {
  DataUserBloc() : super(DataUserBlocInitial()) {
    on<DataUserBlocEvent>((event, emit) async {
      switch (event.runtimeType) {
        case FetchDataUserEvent:
          await _handleDataUserEvent(event as FetchDataUserEvent, emit);
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
      final value = await getIt<DataUserUsecase>().execute();
      value.fold(
        (error) {
          emit(DataUserBlocError(message: error.toString()));
        },
        (dataUser) {
          emit(DataUserBlocLoaded(listUsers: dataUser));
        },
      );
    } catch (e) {
      emit(DataUserBlocError(message: e.toString()));
    }
  }
}
