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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                        receiverID: int.parse(userID.text),
                        senderID: BlocProvider.of<ChatBloc>(context).userID)));
          }
        },
        builder: (context, state) {
          if (state is Messages) {
            print(state.list.isEmpty);
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: state.list.isEmpty
                            ? Image.asset(
                                "assets/start.png",
                                fit: BoxFit.contain,
                              )
                            : ListView.builder(
                                reverse: true,
                                scrollDirection: Axis.vertical,
                                itemCount: state.list.length,
                                itemBuilder: (context, index) {
                                  final reversedIndex =
                                      state.list.length - 1 - index;
                                  return Container(
                                    margin: EdgeInsets.all(18),
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: ListTile(
                                      leading: Text(
                                        state.list[reversedIndex]["data"]
                                                ["sender_id"]
                                            .toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      title: Text(state.list[reversedIndex]
                                          ["data"]["message"]),
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
                                print(
                                    BlocProvider.of<ChatBloc>(context).userID);
                                if (message.text.isNotEmpty) {
                                  print(BlocProvider.of<ChatBloc>(context)
                                      .userID);
                                  BlocProvider.of<ChatBloc>(context).add(
                                      SendMessage(
                                          message: message.text,
                                          receiverID: int.parse(userID.text),
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
                  Positioned(
                      top: 0,
                      child: SafeArea(
                        child: Container(
                          color: Colors.grey.withOpacity(0.5),
                          width: size.width,
                          height: size.height * 0.1,
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                  
                                  timer!.cancel();

                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.arrow_back)),
                              Text(
                                userID.text,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 23),
                              )
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            );
          }

          return Center(
              child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              SizedBox(
                  width: size.width,
                  height: size.height,
                  child: Image.asset("assets/chat.png")),
              Positioned(
                  top: 0,
                  left: 0,
                  child: SafeArea(
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.blueGrey,
                        )),
                  )),
              Container(
                padding: const EdgeInsets.all(18),
                width: size.width * 0.6,
                height: size.height * 0.3,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Enter the user id to chat with : ",
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5),
                    ),
                    TextField(
                      controller: userID,
                      decoration: const InputDecoration(label: Text("User ID")),
                    ),
                    TextButton(
                        onPressed: () {
                          if (userID.text.isNotEmpty) {
                            BlocProvider.of<ChatBloc>(context).add(ReadMessages(
                                receiverID: int.parse(userID.text),
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
                        child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blueGrey),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Start Chatting",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Icon(
                                  Icons.start_rounded,
                                  color: Colors.white,
                                )
                              ],
                            )))
                  ],
                ),
              ),
            ],
          ));
        },
      ),
    ));
  }
}
