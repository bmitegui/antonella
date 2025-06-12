import 'package:antonella/features/service/presentation/bloc/comment/comment_bloc.dart';
import 'package:antonella/features/service/presentation/widgets/detail_service_screen/comment_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceCommentsList extends StatelessWidget {
  const ServiceCommentsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(builder: (context, state) {
      return (state is CommentsLoaded)
          ? Column(
              children: state.serviceComments
                  .map((comment) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: CommentContainer(commentEntity: comment),
                      ))
                  .toList())
          : (state is CommentsError)
              ? Text(state.message)
              : Center(child: CircularProgressIndicator());
    });
  }
}
