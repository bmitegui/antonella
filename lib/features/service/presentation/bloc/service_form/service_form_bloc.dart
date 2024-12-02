import 'package:antonella/core/constant/error_messages.dart';
import 'package:antonella/core/error/error.dart';
import 'package:antonella/features/service/data/models/models.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/domain/usecases/usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'service_form_event.dart';
part 'service_form_state.dart';

class ServiceFormBloc extends Bloc<ServiceFormEvent, ServiceFormState> {
  final GetListServiceFormUseCase getListServiceFormUseCase;

  ServiceFormBloc({required this.getListServiceFormUseCase})
      : super(ServiceFormInitial()) {
    on<GetListServiceFormEvent>(_onGetListServiceFormEventRequest);
    on<UpdateAnswerEvent>(_onUpdateAnswerEventRequest);
  }

  Future<void> _onUpdateAnswerEventRequest(
      UpdateAnswerEvent event, Emitter<ServiceFormState> emit) async {
    List<ServiceFormEntity> listServiceForms = event.listServiceForms;
    final int index =
        listServiceForms.indexWhere((form) => form.id == event.id);
    if (index != -1) {
      ServiceFormEntity updatedForm =
          (listServiceForms[index] as ServiceFormModel)
              .copyWith(answer: event.answer);
      listServiceForms[index] = updatedForm;
      emit(ServiceFormLoaded(listServiceForms: listServiceForms));
    } else {
      emit(ServiceFormError(message: 'Formulario no encontrado.'));
      emit(ServiceFormLoaded(listServiceForms: event.listServiceForms));
    }
  }

  Future<void> _onGetListServiceFormEventRequest(
      GetListServiceFormEvent event, Emitter<ServiceFormState> emit) async {
    emit(ServiceFormLoading());

    if (event.serviceEntity.listServiceFormsEntity != null) {
      emit(ServiceFormLoaded(
          listServiceForms: event.serviceEntity.listServiceFormsEntity!));
    } else {
      final failureOrSuccess = await getListServiceFormUseCase(
          GetListServiceFormParams(category: event.serviceEntity.category));
      failureOrSuccess.fold((failure) async {
        emit(ServiceFormError(message: _mapFailureToMessage(failure)));
      }, (listServiceForms) async {
        emit(ServiceFormLoaded(listServiceForms: listServiceForms));
      });
    }
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    } else if (failure is CacheFailure) {
      return failure.message;
    } else {
      return unexpectedError;
    }
  }
}
