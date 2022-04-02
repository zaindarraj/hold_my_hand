import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hold_my_hand/logic/bloCs/disabled%20person/bloc/disabled_person_bloc.dart';
import 'package:hold_my_hand/logic/bloCs/order%20food/bloc/order_food_bloc.dart';
import 'package:hold_my_hand/methods.dart';

class OrderFoodScreen extends StatefulWidget {
  const OrderFoodScreen({Key? key}) : super(key: key);

  @override
  _OrderFoodScreenState createState() => _OrderFoodScreenState();
}

class _OrderFoodScreenState extends State<OrderFoodScreen> {
  TextEditingController creditCardID = TextEditingController();
  TextEditingController food = TextEditingController();
  @override
  Widget build(BuildContext context) {
    DisabledPersonBloc disabledPersonBloc =
        BlocProvider.of<DisabledPersonBloc>(context);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: BlocConsumer<OrderFoodBloc, OrderFoodState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is Done) {
                return const Center(
                  child: Text("DONE"),
                );
              }
              return Stack(
                alignment: Alignment.centerLeft,
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
                      top: 0,
                      left: 0,
                      child: SafeArea(
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back)))),
                  Container(
                    width: size.width * 0.85,
                    height: size.height * 0.5,
                    decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 15,
                              offset: Offset(3, 0),
                              color: Colors.blueAccent)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                controller: creditCardID,
                                decoration: const InputDecoration(
                                    icon: Icon(Icons.card_membership),
                                    label: Text("Card ID")),
                              ),
                              SizedBox(
                                height: size.height * 0.04,
                              ),
                              TextButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                            elevation: 40,
                                            child: Container(
                                              padding: EdgeInsets.all(20),
                                              height: size.height * 0.3,
                                              child: Column(
                                                children: [
                                                  const Text(
                                                    "We have several foods available for you, order right to your door step.",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.blue,
                                                        letterSpacing: 1.05),
                                                  ),
                                                  TextField(
                                                    controller: food,
                                                    decoration:
                                                        const InputDecoration(
                                                            label: Text(
                                                                "Enter the food you want to order")),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.all(18),
                                                      color: Colors.blue,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "Done",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    width: size.width * 0.6,
                                    height: size.height * 0.1,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text(
                                          "Browse Available Food",
                                          style: TextStyle(
                                              color: Colors.white,
                                              letterSpacing: 1.5),
                                        ),
                                        Icon(
                                          Icons.browse_gallery_rounded,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 0,
                      bottom: 0,
                      left: size.width * 0.8,
                      child: IconButton(
                          onPressed: () {
                            if (creditCardID.text.isNotEmpty &&
                                food.text.isNotEmpty) {
                              BlocProvider.of<OrderFoodBloc>(context).add(
                                  OrderFood(
                                      userID: disabledPersonBloc.data["id"]
                                          .toString(),
                                      cardID: creditCardID.text,
                                      order: food.text));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Please fill all fields")));
                            }
                          },
                          icon: const Icon(
                            Icons.start_rounded,
                            size: 40,
                            color: Colors.blue,
                          ))),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
