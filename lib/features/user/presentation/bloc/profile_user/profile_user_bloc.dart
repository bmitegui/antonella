import 'package:antonella/core/error/error.dart';
import 'package:antonella/features/user/domain/usecases/get_profile_user_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'profile_user_event.dart';
part 'profile_user_state.dart';

class ProfileUserBloc extends Bloc<ProfileUserEvent, ProfileUserState> {
  final GetProfileUserUseCase getProfileUserUseCase;

  ProfileUserBloc({required this.getProfileUserUseCase})
      : super(ProfileUserInitial()) {
        on<UpdateUserProfilePhotoEvent>(_onUpdateProfilePhoto);
  }

  Future<void> _onUpdateProfilePhoto(
      UpdateUserProfilePhotoEvent event, Emitter<ProfileUserState> emit) async {
    emit(ProfileUserLoading());
    final failureOrSuccess = await getProfileUserUseCase(AddProfileParams(
        id: event.userId,
        url: event.base64Photo,
    ));
    failureOrSuccess.fold(
      (failure) {
        emit(ProfileUserError(failure: failure));
      }, 
      (_) {
        emit(ProfileUserLoaded());
      });
  }
}
