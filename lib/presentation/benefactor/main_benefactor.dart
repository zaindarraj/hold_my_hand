import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hold_my_hand/classes/api.dart';
import 'package:hold_my_hand/presentation/registerScreen.dart';

import '../../logic/bloCs/location/bloc/location_bloc.dart';
import '../../logic/bloCs/registeration/bloc/registeration_bloc.dart';

class MainBenefactorScreen extends StatefulWidget {
  const MainBenefactorScreen({Key? key}) : super(key: key);

  @override
  State<MainBenefactorScreen> createState() => _MainBenefactorScreenState();
}

class _MainBenefactorScreenState extends State<MainBenefactorScreen> {
  String getService(String intVal) {
    if (intVal == "1") {
      return "Food Delivery";
    } else if (intVal == "2") {
      return "Appointments";
    } else {
      return "Provide medical advide";
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
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
                          Text(benefectorData!["name"])
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "User ID : ",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(benefectorData!["id"].toString())
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "Email : ",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(benefectorData!["email"])
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
                                        userID: benefectorData!["id"]
                                            .toString()));
                              } else {
                                BlocProvider.of<LocationBloc>(context).add(
                                    DisableLocation(
                                        userID: benefectorData!["id"]
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
      body: Stack(
        alignment: Alignment.bottomCenter,
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
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,

            child: SafeArea(
              
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     const Text("Benefactor Screen",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 30),),
                      IconButton(onPressed: (){

                      }, icon: const Icon(Icons.settings,size: 30,color: Colors.blue,))
                    
                    ],
                  ),
                ),
              ),
            )),
          FutureBuilder<List<Map<String, dynamic>>?>(
              future: API.getNearbyUsers(benefectorData!["id"]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Container(
                      padding: EdgeInsets.all(18),
                      alignment: Alignment.topCenter,
                      width: size.width * 0.9,
                      height: size.height * 0.7,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(3, 0),
                                color: Colors.grey,
                                blurRadius: 10,
                                spreadRadius: 4)
                          ],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        child: Container(
                                          width: size.width * 0.9,
                                          height: size.height * 0.7,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            children: [
                                              ListTile(
                                                title: const Text("Name : "),
                                                subtitle: Text(snapshot
                                                    .data![index]["name"]),
                                              ),
                                              ListTile(
                                                title: const Text("User Id : "),
                                                subtitle: Text(snapshot
                                                    .data![index]["id"]),
                                              ),
                                              ListTile(
                                                title: const Text(
                                                    "Service Request : "),
                                                subtitle: Text(getService(
                                                    snapshot.data![index]
                                                            ["service"]
                                                        .toString())),
                                              ),
                                              ListTile(
                                                title: const Text(
                                                    "Service Content : "),
                                                subtitle: Text(
                                                  getService(snapshot
                                                      .data![index]["content"]
                                                      .toString()),
                                                  overflow: TextOverflow.clip,
                                                ),
                                              ),
                                              TextButton(
                                                  onPressed: () async {
                                                    await API.approveRequest(
                                                        benefectorData!["id"],
                                                        snapshot.data![index]
                                                            ["id"]);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    padding: EdgeInsets.all(18),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "Approve",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  )),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    padding: EdgeInsets.all(18),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: size.width * 0.7,
                                height: size.height * 0.1,
                                margin: EdgeInsets.all(8),
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Colors.blue,
                                    Colors.blue.withOpacity(0.5)
                                  ]),
                                  boxShadow: const [
                                    BoxShadow(
                                        offset: Offset(3, 0),
                                        color: Colors.blueAccent,
                                        blurRadius: 4,
                                        spreadRadius: 5)
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "Name : " + snapshot.data![index]["name"],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          }),
                    );
                  }
                }
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/no data.svg"),
                    const Text(
                        "No Pedning Requests !, Thanks for being the human that you are")
                  ],
                ));
              })
        ],
      ),
    );
  }
}
