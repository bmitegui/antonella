import 'package:antonella/core/error/error.dart';
import 'package:antonella/features/user/domain/entities/entities.dart';
import 'package:antonella/features/user/domain/usecases/get_profile_user_use_case.dart';
import 'package:antonella/features/user/domain/usecases/usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'profile_user_event.dart';
part 'profile_user_state.dart';

class ProfileUserBloc extends Bloc<ProfileUserEvent, ProfileUserState> {
  final GetProfileUserUseCase getProfileUserUseCase;

  ProfileUserBloc({required this.getProfileUserUseCase})
      : super(ProfileUserInitial()) {
    
  }

  
}
