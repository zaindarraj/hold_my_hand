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
    String userID =
        BlocProvider.of<DisabledPersonBloc>(context).data["id"].toString();

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<DeliveryServiceBloc, DeliveryServiceState>(
        listener: (context, state) {
          if (state is Done) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Done !")));
          }
        },
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              child: Container(
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(color: Colors.white),
                child: Stack(
                  children: [
                    Container(
                        alignment: Alignment.topCenter,
                        width: size.width,
                        height: size.height * 0.5,
                        child: Image.asset("assets/delivery.png")),
                    Positioned(
                        top: 0,
                        child: SafeArea(
                          child: Container(
                            width: size.width * 0.1,
                            height: size.height * 0.1,
                            color: Colors.white.withOpacity(0.5),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back_rounded,
                                  color: Colors.blue,
                                )),
                          ),
                        )),
                    Positioned(
                      top: size.height * 0.5,
                      child: Container(
                        width: size.width,
                        height: size.height * 0.5,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
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
                                  const Text(
                                    "Delivery Service right to your location",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        letterSpacing: 2,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 23),
                                  ),
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
                                      child: Container(
                                        width: size.width * 0.4,
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        padding: EdgeInsets.all(18),
                                        child: Center(
                                          child: Text(
                                            "Submit",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }


}
