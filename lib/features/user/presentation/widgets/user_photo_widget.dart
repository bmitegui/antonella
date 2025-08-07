import 'package:antonella/core/constant/environment.dart';
import 'package:antonella/core/theme/responsive_size.dart';
import 'package:antonella/features/user/presentation/bloc/profile_user/profile_user_bloc.dart';
import 'package:antonella/features/user/presentation/bloc/user/user_bloc.dart';
import 'package:antonella/features/user/presentation/widgets/upload_user_photo_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserPhotoWidget extends StatelessWidget {
  final bool canEdit;
  const UserPhotoWidget({super.key, this.canEdit = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileUserBloc, ProfileUserState>(
        builder: (context, stateProfile) {
      return Stack(children: [
        Container(
            clipBehavior: Clip.hardEdge,
            decoration:
                BoxDecoration(shape: BoxShape.circle, border: Border.all()),
            child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
              return CircleAvatar(
                  radius: 80.rh(context),
                  backgroundColor: Colors.white,
                  foregroundImage: (stateProfile is! ProfileUserLoading)
                      ? (state is UserAuthenticated &&
                              state.user.photoUrl != null)
                          ? CachedNetworkImageProvider(
                              Environment.apiUrl + state.user.photoUrl!)
                          : AssetImage('assets/img/placeholder_women.png')
                      : null,
                  child: (stateProfile is ProfileUserLoading)
                      ? CircularProgressIndicator()
                      : null);
            })),
        if (canEdit && stateProfile is! ProfileUserLoading)
          Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                  onTap: () async => await showModalBottomSheet<List>(
                      backgroundColor: Colors.white,
                      context: context,
                      builder: (BuildContext context) {
                        return UploadUserPhotoWidget();
                      }),
                  child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black54,
                                offset: const Offset(0, 4),
                                blurRadius: 6)
                          ]),
                      child: CircleAvatar(
                          radius: 24.rh(context),
                          backgroundColor: const Color(0XFFBD818E),
                          child: const Icon(Icons.add_a_photo_outlined,
                              color: Colors.white)))))
      ]);
    });
  }
}
