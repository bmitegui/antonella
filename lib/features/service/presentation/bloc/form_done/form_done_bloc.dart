import 'package:antonella/core/error/error.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/domain/usecases/get_form_done_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'form_done_event.dart';
part 'form_done_state.dart';

class FormDoneBloc extends Bloc<FormDoneEvent, FormDoneState> {
  final GetFormDoneUseCase getFormDoneUseCase;

  FormDoneBloc({required this.getFormDoneUseCase}) : super(FormDoneInitial()) {
    on<GetFormDoneEvent>(_onGetFormDoneEventRequest);
  }

  Future<void> _onGetFormDoneEventRequest(
      GetFormDoneEvent event, Emitter<FormDoneState> emit) async {
    emit(FormDoneLoading());
    final failureOrSuccess = await getFormDoneUseCase(GetFormDoneParams(
        clientId: event.clientId, serviceItemId: event.serviceItemId));
    failureOrSuccess.fold((failure) async {
      emit(FormDoneError(failure: failure));
    }, (questions) async {
      emit(FormDoneLoaded(questions: questions));
    });
  }
}
