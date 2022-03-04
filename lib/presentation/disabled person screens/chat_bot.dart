import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  ScrollController scrollController = ScrollController();
  List<Map> answers = const [
    {
      "widget": Text(
        "You can book an appointment, request a service , order food, chat with people and more !",
      ),
      "sender": "bot"
    },
    {
      "widget": Text(
          "We don't store your credit card information. We only send it to banks."),
      "sender": "bot"
    },
    {
      "widget": Text(
          "You can say order food to order food, start chatting to start chatting and help to access the chatbot"),
      "sender": "bot"
    }
  ];

  List<Map> questions = const [
    {"widget": Text("What services do you provide ? "), "sender": "person"},
    {
      "widget": Text("Does the app store any of my credit card infomration? "),
      "sender": "person"
    },
    {
      "widget": Text("How to use voice commands? "),
      "sender": "person"
    },
  ];
  List<Map> list = [
    {
      "widget": const Text(
        "Welcome I am your chat bot, go aheard and read the questions.",
      ),
      "sender": "bot"
    }
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("ChatBot"),
      ),
      body: DefaultTextStyle(
        style: TextStyle(
            overflow: TextOverflow.fade,
            color: Colors.white,
            fontSize: MediaQuery.of(context).textScaleFactor * 20),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.all(18),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context).primaryColor,
                              blurRadius: 20)
                        ]),
                    child: ListView.builder(
                        itemCount: list.length,
                        controller: scrollController,
                        itemBuilder: (conext, index) {
                          return list[index]["sender"] == "bot"
                              ? Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: SvgPicture.asset(
                                        "assets/bot.svg",
                                        height: 100,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        width: size.width * 0.75,
                                        margin: const EdgeInsets.all(18),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            gradient: LinearGradient(colors: [
                                              Colors.blue[800] as Color,
                                              Colors.blue[600] as Color
                                            ])),
                                        child: Center(
                                            child: list[index]["widget"]),
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        width: size.width * 0.75,
                                        margin: const EdgeInsets.all(18),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            gradient: LinearGradient(colors: [
                                              Colors.blue[800] as Color,
                                              Colors.blue[600] as Color
                                            ])),
                                        child: Center(
                                            child: list[index]["widget"]),
                                      ),
                                    ),
                                    Icon(
                                      Icons.person,
                                      color: Theme.of(context).primaryColor,
                                    )
                                  ],
                                );
                        }),
                  )),
              Expanded(
                flex: 1,
                child: ListView.builder(
                    itemCount: questions.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          list.add(questions[index]);
                          list.add(answers[index]);
                          
                          setState(() {});
                          scrollController.animateTo(
                            scrollController.position.maxScrollExtent,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.fastOutSlowIn,
                          );
                        },
                        child: Container(
                          width: size.width * 0.9,
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              gradient: LinearGradient(colors: [
                                Colors.purple[800] as Color,
                                Colors.purple[400] as Color
                              ])),
                          child: Center(child: questions[index]["widget"]),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
