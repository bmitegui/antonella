import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/features/user/domain/usecases/update_profile_user_use_case.dart';
import 'package:antonella/features/user/presentation/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'profile_user_event.dart';
part 'profile_user_state.dart';

class ProfileUserBloc extends Bloc<ProfileUserEvent, ProfileUserState> {
  final GetProfileUserUseCase getProfileUserUseCase;

  ProfileUserBloc({required this.getProfileUserUseCase})
      : super(ProfileUserInitial()) {
    on<UpdateUserProfileEvent>(_onUpdateProfile);
  }

  Future<void> _onUpdateProfile(
      UpdateUserProfileEvent event, Emitter<ProfileUserState> emit) async {
    emit(ProfileUserLoading());
    final failureOrSuccess = await getProfileUserUseCase(UpdateProfileParams(
        userId: event.userId,
        base64Photo: event.base64Photo,
        name: event.name,
        phoneNumber: event.phoneNumber,
        gmail: event.gmail));
    failureOrSuccess.fold((failure) {
      emit(ProfileUserError(failure: failure));
    }, (user) {
      sl<UserBloc>().add(UpdateUserEvent(userEntity: user));
      emit(ProfileUserLoaded());
    });
  }
}
