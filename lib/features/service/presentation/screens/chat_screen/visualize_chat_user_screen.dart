import 'package:antonella/core/widgets/arrow_back.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/features/user/presentation/bloc/message/message_bloc.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VisualizeChatUserScreen extends StatelessWidget {
  const VisualizeChatUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      leading: ArrowBack(),
      title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://randomuser.me/api/portraits/women/44.jpg'),
            ),
            const SizedBox(width: 10),
            const Text('Valentina Gómez', style: TextStyle(color: Colors.white)),
          ],
        ),
      body: BlocBuilder<MessagesBloc, MessageState>(
        builder: (context, state) {
          if (state is MessagesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MessagesLoaded) {
            final messages = state.listMessages;
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      // BubbleNormalImage(
                      //     id: 'id001',
                      //     image: _image(),
                      //     color: Colors.purpleAccent,
                      //     tail: true,
                      //     delivered: true,
                      // ),
                      // BubbleNormalAudio(
                      //   color: Color(0xFFE8E8EE),
                      //   duration: duration.inSeconds.toDouble(),
                      //   position: position.inSeconds.toDouble(),
                      //   isPlaying: isPlaying,
                      //   isLoading: isLoading,
                      //   isPause: isPause,
                      //   onSeekChanged: _changeSeek,
                      //   onPlayPauseButtonClick: _playAudio,
                      //   sent: true,
                      // ),
                      BubbleNormal(
                        text: 'bubble normal with tail',
                        isSender: false,
                        color: Color(0xFF1B97F3),
                        //tail: true,
                        textStyle: TextStyle(
                          //fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      BubbleNormal(
                        text: 'bubble normal without tail',
                        color: Color(0xFFE8E8EE),
                        tail: false,
                        sent: true,
                        seen: true,
                        delivered: true,
                      ),
                      SizedBox(
                        height: 100,
                      )
                    ],
                  ),
                ),
                MessageBar(
                  onSend: (_) => print(_),
                  actions: [
                    InkWell(
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 24,
                      ),
                      onTap: () {},
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8, right: 8),
                      child: InkWell(
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.green,
                          size: 24,
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return SizedBox.shrink();
          }
        }
      )
    );
  }
}