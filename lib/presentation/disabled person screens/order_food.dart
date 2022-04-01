import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  List<bool> selectedFood = List.generate(4, (index) => false);
  List<String> foods = ["Pizza with vegetabled", "Shaorma", "Fries", "Soap"];
  List<String> addFood = [];
  @override
  Widget build(BuildContext context) {
    DisabledPersonBloc disabledPersonBloc =
        BlocProvider.of<DisabledPersonBloc>(context);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<OrderFoodBloc, OrderFoodState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is Done) {
            return const Center(
              child: Text("DONE"),
            );
          }
          return Center(
            child: Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.blue[800] as Color,
                Colors.blue[600] as Color
              ])),
              child: Column(
                children: [
                  Expanded(flex: 1, child: intro(size, context)),
                  Expanded(
                      flex: 2,
                      child: Container(
                        width: size.width,
                        height: size.height,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Center(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: ToggleButtons(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            foods[0],
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            foods[1],
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            foods[2],
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            foods[3],
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                        ),
                                      ],
                                      selectedColor:
                                          Theme.of(context).primaryColor,
                                      isSelected: selectedFood,
                                      onPressed: (index) {
                                        selectedFood[index] =
                                            !selectedFood[index];
                                        selectedFood[index]
                                            ? addFood.add(foods[index])
                                            : addFood.remove(foods[index]);
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        if (creditCardID.text.isNotEmpty &&
                                            addFood.isNotEmpty) {
                                          print(disabledPersonBloc
                                                      .data["id"]);
                                          BlocProvider.of<OrderFoodBloc>(
                                                  context)
                                              .add(OrderFood(
                                                  userID: disabledPersonBloc
                                                      .data["id"].toString(),
                                                  cardID: creditCardID.text,
                                                  order: addFood));
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "Please fill all fields")));
                                        }
                                      },
                                      child: const Center(
                                        child: Text("Submit"),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget intro(Size size, BuildContext context) {
  return Container(
    width: size.width,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.blue[800] as Color, Colors.blue[600] as Color])),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Order food !",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).textScaleFactor * 24),
        ),
        Text(
          "Enter your infromation here",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).textScaleFactor * 20),
        )
      ],
    ),
  );
}
