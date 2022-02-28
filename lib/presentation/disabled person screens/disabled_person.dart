import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hold_my_hand/logic/bloCs/chat/bloc/chat_bloc.dart';
import 'package:hold_my_hand/logic/bloCs/disabled%20person/bloc/disabled_person_bloc.dart';
import 'package:hold_my_hand/logic/bloCs/location/bloc/location_bloc.dart';
import 'package:hold_my_hand/logic/bloCs/order%20food/bloc/order_food_bloc.dart';
import 'package:hold_my_hand/logic/bloCs/registeration/bloc/registeration_bloc.dart';
import 'package:hold_my_hand/presentation/disabled%20person%20screens/chat_bot.dart';
import 'package:hold_my_hand/presentation/disabled%20person%20screens/chatting.dart';
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
                          Text(disabledPersonBloc.data["fname"] +
                              " " +
                              disabledPersonBloc.data["lname"])
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "User ID : ",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(disabledPersonBloc.data["userID"])
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
                                        userID:
                                            disabledPersonBloc.data["userID"]));
                              } else {
                                BlocProvider.of<LocationBloc>(context).add(
                                    DisableLocation(
                                        userID:
                                            disabledPersonBloc.data["userID"]));
                              }
                            });
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            child: const Icon(Icons.logout),
            onPressed: () {
              BlocProvider.of<RegisterationBloc>(context).add(SignOut());
            },
          ),
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.blue[800] as Color,
              Colors.blue[600] as Color
            ])),
            child: BlocConsumer<DisabledPersonBloc, DisabledPersonState>(
                builder: (context, state) {
                  return body(size, intro(size), functions(size));
                },
                listener: (context, state) {}),
          )),
    );
  }

  GridView functions(Size size) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 10),
      children: [
        TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => BlocProvider(
                          create: (_) => ChatBloc(
                              userID:
                                  BlocProvider.of<DisabledPersonBloc>(context)
                                      .data["userID"]),
                          child: const ChattingScreen(),
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
                "Start Chatting",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ))),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const ChatBot()));
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
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ))),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => BlocProvider(
                          create: (context) => OrderFoodBloc(),
                          child:const OrderFoodScreen(),
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
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ))),
        ),
        SizedBox(height: size.height * 0.0001)
      ],
    );
  }

  Column intro(Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {
                  globalKey.currentState!.openDrawer();
                },
                icon: const Icon(Icons.settings)),
          ],
        ),
        const Text("Welcome to your safe space",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        SizedBox(
          height: size.height * 0.02,
        ),
        const Text("Here's the list of every function you can make",
            style: TextStyle(fontSize: 18, color: Colors.white)),
      ],
    );
  }

  ListView body(Size size, Widget intro, Widget body) {
    return ListView(
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.blue[800] as Color,
            Colors.blue[600] as Color
          ])),
          width: size.width,
          height: size.height * 0.3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: intro,
          ),
        ),
        Container(
          height: size.height * 0.7,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: body,
        ),
      ],
    );
  }
}
