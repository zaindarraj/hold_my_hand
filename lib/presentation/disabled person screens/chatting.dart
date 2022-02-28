import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hold_my_hand/logic/bloCs/chat/bloc/chat_bloc.dart';

class ChattingScreen extends StatefulWidget {
  const ChattingScreen({Key? key}) : super(key: key);

  @override
  _ChattingScreenState createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  ScrollController scrollController = ScrollController();
  TextEditingController userID = TextEditingController();
  TextEditingController message = TextEditingController();

  Timer? timer;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: userID.text.isNotEmpty
              ? Text("Chatting with " + userID.text)
              : Container(),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: WillPopScope(
          onWillPop: () async {
            if (timer != null) {
              timer!.cancel();
            }
            return true;
          },
          child: BlocConsumer<ChatBloc, ChatState>(
            listener: (context, state) {
              if (state is Error) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.errorMessage)));
              }
              if (state is Messages) {
                timer ??= Timer.periodic(
                    const Duration(seconds: 10),
                    (Timer t) => BlocProvider.of<ChatBloc>(context).add(
                        ReadMessages(
                            receiverID: userID.text,
                            senderID:
                                BlocProvider.of<ChatBloc>(context).userID)));
              }
            },
            builder: (context, state) {
              if (state is Messages) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            reverse: true,
                            scrollDirection: Axis.vertical,
                            itemCount: state.list.length,
                            itemBuilder: (context, index) {
                              final reversedIndex =
                                  state.list.length - 1 - index;
                              return SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: ListTile(
                                  leading: Text(
                                    state.list[reversedIndex]["userID"],
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  title: Text(
                                      state.list[reversedIndex]["message"]),
                                ),
                              );
                            }),
                      ),
                      Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: TextField(
                                controller: message,
                                decoration: const InputDecoration(
                                    hintText: "Enter your message here"),
                                maxLines: 3,
                              )),
                          IconButton(
                              onPressed: () {
                                if (message.text.isNotEmpty) {
                                  BlocProvider.of<ChatBloc>(context).add(
                                      SendMessage(
                                          message: message.text,
                                          receiverID: userID.text,
                                          senderID:
                                              BlocProvider.of<ChatBloc>(context)
                                                  .userID));

                                  message.clear();
                                }
                              },
                              icon: Icon(
                                Icons.send,
                                color: Theme.of(context).primaryColor,
                              ))
                        ],
                      )
                    ],
                  ),
                );
              }

              return Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Enter the user id to chat with : "),
                    TextField(
                      controller: userID,
                      decoration: const InputDecoration(label: Text("User ID")),
                    ),
                    TextButton(
                        onPressed: () {
                          if (userID.text.isNotEmpty) {
                            BlocProvider.of<ChatBloc>(context).add(ReadMessages(
                                receiverID: userID.text,
                                senderID:
                                    BlocProvider.of<ChatBloc>(context).userID));
                            setState(() {});
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("Please provide the user ID")));
                          }
                        },
                        child: const Text("Start Chatting"))
                  ],
                ),
              ));
            },
          ),
        ));
  }
}
