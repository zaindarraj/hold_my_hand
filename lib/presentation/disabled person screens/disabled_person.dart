import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hold_my_hand/logic/bloCs/chat/bloc/chat_bloc.dart';
import 'package:hold_my_hand/logic/bloCs/delivery%20bloc/bloc/delivery_service_bloc.dart';
import 'package:hold_my_hand/logic/bloCs/disabled%20person/bloc/disabled_person_bloc.dart';
import 'package:hold_my_hand/logic/bloCs/location/bloc/location_bloc.dart';
import 'package:hold_my_hand/logic/bloCs/order%20food/bloc/order_food_bloc.dart';
import 'package:hold_my_hand/logic/bloCs/registeration/bloc/registeration_bloc.dart';
import 'package:hold_my_hand/logic/bloCs/voice%20commands/bloc/voice_commands_bloc.dart'
    as voice_commands;
import 'package:hold_my_hand/presentation/disabled%20person%20screens/book_apointment.dart';
import 'package:hold_my_hand/presentation/disabled%20person%20screens/chat_bot.dart';
import 'package:hold_my_hand/presentation/disabled%20person%20screens/chatting.dart';
import 'package:hold_my_hand/presentation/disabled%20person%20screens/delivery_service.dart';
import 'package:hold_my_hand/presentation/disabled%20person%20screens/order_food.dart';
import 'package:hold_my_hand/presentation/registerScreen.dart';

class DisabledPersonScreen extends StatefulWidget {
  const DisabledPersonScreen({Key? key}) : super(key: key);

  @override
  _DisabledPersonScreenState createState() => _DisabledPersonScreenState();
}

class _DisabledPersonScreenState extends State<DisabledPersonScreen> {
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DisabledPersonBloc disabledPersonBloc =
        BlocProvider.of<DisabledPersonBloc>(context);
    return BlocListener<RegisterationBloc, RegisterationState>(
      listener: (context, state) {
        if (state is RegisterationInitial) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => const RegisterScreen()));
        }
      },
      child: Scaffold(
          key: globalKey,
          drawer: Drawer(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(18),
                  height: size.height * 0.3,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.blue[800] as Color,
                    Colors.blue[600] as Color
                  ])),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Name : ",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(disabledPersonBloc.data["name"])
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "User ID : ",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(disabledPersonBloc.data["id"].toString())
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "Email : ",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(disabledPersonBloc.data["email"])
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(18),
                  child: BlocProvider(
                    create: (context) => LocationBloc(),
                    child: BlocConsumer<LocationBloc, LocationState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return CheckboxListTile(
                            title: const Text("Share your location"),
                            value: state is Enabled ? true : false,
                            onChanged: (value) {
                              if (value == true) {
                                BlocProvider.of<LocationBloc>(context).add(
                                    EnableLocation(
                                        userID: disabledPersonBloc.data["id"]
                                            .toString()));
                              } else {
                                BlocProvider.of<LocationBloc>(context).add(
                                    DisableLocation(
                                        userID: disabledPersonBloc.data["id"]
                                            .toString()));
                              }
                            });
                      },
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  alignment: Alignment.bottomLeft,
                  child: TextButton(
                    child: const Text("Sign Out"),
                    onPressed: () {
                      BlocProvider.of<RegisterationBloc>(context)
                          .add(SignOut());
                    },
                  ),
                ))
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: BlocListener<voice_commands.VoiceCommandsBloc,
              voice_commands.VoiceCommandsState>(
            listener: (context, state) {
              if (state is voice_commands.OrderFood) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => MultiBlocProvider(
                              providers: [
                                BlocProvider(create: (_) => OrderFoodBloc()),
                                BlocProvider.value(value: disabledPersonBloc)
                              ],
                              child: const OrderFoodScreen(),
                            )));
              }
              if (state is voice_commands.StartChatting) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => BlocProvider(
                              create: (context) => ChatBloc(
                                  userID: disabledPersonBloc.data["userID"]),
                              child: const ChattingScreen(),
                            )));
              }
              if (state is voice_commands.ChatBot) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const ChatBot()));
              } else if (state is voice_commands.Started) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Listening...")));
              } else if (state is voice_commands.UnknownCommand) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                        "Unkown Command..Try again or say help to access the chatbot for more info")));
              } else if (state is voice_commands.Error) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.error)));
              }else if (state is voice_commands.Appointment) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const BookApointment()));
              }else if (state is voice_commands.Delivery) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const DeliveryService()));
              }
            },
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(Icons.mic),
              onPressed: () {
                //BlocProvider.of<RegisterationBloc>(context).add(SignOut());
                BlocProvider.of<voice_commands.VoiceCommandsBloc>(context)
                    .add(voice_commands.Listen());
              },
            ),
          ),
          body: BlocConsumer<DisabledPersonBloc, DisabledPersonState>(
              builder: (context, state) {
                return functions(size);
              },
              listener: (context, state) {})),
    );
  }

  Widget functions(Size size) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: size.width,
              height: size.height * 0.5,
              child: SvgPicture.asset(
                "assets/top.svg",
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              width: size.width,
              height: size.height * 0.5,
              child: SvgPicture.asset(
                "assets/bottom.svg",
                fit: BoxFit.fill,
              ),
            )
          ],
        ),
        Positioned(
            top: size.height * 0.02,
            left: size.width * 0.05,
            child: SafeArea(
              child: Column(
                children: const [
                  Text("All You Need",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 40)),
                  Text("In One Place",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                ],
              ),
            )),
        Positioned(
            top: size.height * 0.02,
            right: size.width * 0.03,
            child: SafeArea(
                child: IconButton(
                    onPressed: () {
                      globalKey.currentState!.openDrawer();
                    },
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.blue,
                      size: 40,
                    )))),
        Positioned(
          top: size.height * 0.2,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                color: Colors.white),
            height: size.height * 0.8,
            width: size.width * 0.9,
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 10),
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MultiBlocProvider(
                                  providers: [
                                    BlocProvider.value(
                                        value:
                                            BlocProvider.of<DisabledPersonBloc>(
                                                context)),
                                    BlocProvider(
                                        create: (_) => DeliveryServiceBloc())
                                  ],
                                  child: const DeliveryService(),
                                )));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: LinearGradient(colors: [
                            Colors.blue[800] as Color,
                            Colors.blue[600] as Color
                          ])),
                      child: const Center(
                          child: Text(
                        "Delivery Service",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ))),
                ),
                TextButton(
                  onPressed: () {
                    try {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => BlocProvider(
                                    create: (_) => ChatBloc(
                                        userID:
                                            BlocProvider.of<DisabledPersonBloc>(
                                                    context)
                                                .data["id"]),
                                    child: const ChattingScreen(),
                                  )));
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: LinearGradient(colors: [
                            Colors.blue[800] as Color,
                            Colors.blue[600] as Color
                          ])),
                      child: const Center(
                          child: Text(
                        "Start Chatting",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ))),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const ChatBot()));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: LinearGradient(colors: [
                            Colors.blue[800] as Color,
                            Colors.blue[600] as Color
                          ])),
                      child: const Center(
                          child: Text(
                        "Ask the chat bot",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ))),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MultiBlocProvider(
                                  providers: [
                                    BlocProvider.value(
                                        value:
                                            BlocProvider.of<DisabledPersonBloc>(
                                                context)),
                                    BlocProvider(create: (_) => OrderFoodBloc())
                                  ],
                                  child: const OrderFoodScreen(),
                                )));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: LinearGradient(colors: [
                            Colors.blue[800] as Color,
                            Colors.blue[600] as Color
                          ])),
                      child: const Center(
                          child: Text(
                        "Order Foor",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ))),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context)=>BookApointment()));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: LinearGradient(colors: [
                            Colors.blue[800] as Color,
                            Colors.blue[600] as Color
                          ])),
                      child: const Center(
                          child: Text(
                        "Book Appointment",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ))),
                ),
                SizedBox(height: size.height * 0.0001)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
