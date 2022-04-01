import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hold_my_hand/logic/bloCs/delivery%20bloc/bloc/delivery_service_bloc.dart';
import 'package:hold_my_hand/logic/bloCs/disabled%20person/bloc/disabled_person_bloc.dart';

class DeliveryService extends StatefulWidget {
  const DeliveryService({Key? key}) : super(key: key);

  @override
  State<DeliveryService> createState() => _DeliveryServiceState();
}

class _DeliveryServiceState extends State<DeliveryService> {
  TextEditingController from = TextEditingController();
  TextEditingController object = TextEditingController();

  @override
  Widget build(BuildContext context) {
        String userID = BlocProvider.of<DisabledPersonBloc>(context).data["id"].toString();

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<DeliveryServiceBloc, DeliveryServiceState>(
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
                                    controller: from,
                                    decoration: const InputDecoration(
                                        icon: Icon(Icons.house),
                                        label: Text("From")),
                                  ),
                                  TextField(
                                    controller: object,
                                    decoration: const InputDecoration(
                                        icon: Icon(Icons.add_box),
                                        label: Text("Object")),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.04,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        if (from.text.isNotEmpty &&
                                            object.text.isNotEmpty) {
                                          BlocProvider.of<DeliveryServiceBloc>(
                                                  context)
                                              .add(RequestDelivery(
                                                  from: from.text,
                                                  object: object.text,
                                                  userID: userID));
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
            "Delivery Service !",
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
}