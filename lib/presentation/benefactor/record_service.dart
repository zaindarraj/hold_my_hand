import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hold_my_hand/classes/api.dart';
import 'package:hold_my_hand/classes/location.dart';
import 'package:hold_my_hand/consts.dart';
import 'package:hold_my_hand/presentation/registerScreen.dart';

import '../notifications.dart';

class RecordServiceScreen extends StatefulWidget {
  const RecordServiceScreen({Key? key}) : super(key: key);

  @override
  _RecordServiceScreenState createState() => _RecordServiceScreenState();
}

class _RecordServiceScreenState extends State<RecordServiceScreen> {
  List<int> services = [];
  bool locationEnabled = false;
  TextEditingController content = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        drawer: Drawer(
          child: Checkbox(
            value: locationEnabled,
            onChanged: (newValue) async {
              await API.enableLocation(1, benefectorData!["id"].toString(),
                          await LocationClass.getLocation()) ==
                      oK
                  ? locationEnabled = true
                  : locationEnabled = false;
              setState(() {});
            },
          ),
        ),
        body: Stack(
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
                top: 0,
                left: 0,
                child: SafeArea(
                    child: Container(
                  width: size.width,
                  height: size.height * 0.06,
                  color: Colors.blue.withOpacity(0.3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios_new_rounded)),
                      Text(
                        "Thanks for being the human that you are !",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ))),
            const Positioned(
                bottom: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Record your service and help other !",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                  ),
                )),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow:const  [
                    BoxShadow(
                        spreadRadius: 3,
                        offset: Offset(3, 0),
                        blurRadius: 10,
                        color: Colors.blue)
                  ],
                  borderRadius: BorderRadius.circular(20)),
              width: size.width * 0.9,
              height: size.height * 0.7,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ListTile(
                      selectedColor: Colors.blue,
                      selected: services.contains(1),
                      onTap: () {
                        if (services.contains(1)) {
                          services.remove(1);
                        } else {
                          services.add(1);
                        }
                        setState(() {});
                      },
                      leading: const Text("Service : "),
                      subtitle: const Text("Food Delivery"),
                    ),
                    ListTile(
                      selectedColor: Colors.blue,
                      selected: services.contains(2),
                      onTap: () {
                        if (services.contains(2)) {
                          services.remove(2);
                        } else {
                          services.add(2);
                        }
                        setState(() {});
                      },
                      leading: const Text("Service : "),
                      subtitle: const Text("Appointments"),
                    ),
                    ListTile(
                      selectedColor: Colors.blue,
                      selected: services.contains(3),
                      onTap: () {
                        if (services.contains(3)) {
                          services.remove(3);
                        } else {
                          services.add(3);
                        }
                        setState(() {});
                      },
                      leading: const Text("Service : "),
                      subtitle: const Text("Provide medical advide"),
                    ),
                    TextField(
                      maxLines: 4,
                      controller: content,
                      decoration: const InputDecoration(
                        hintText: "Describe your services",
                      ),
                    ),
                    TextButton(
                        onPressed: () async {
                          String message = await API.setServices(
                              benefectorData!["id"],
                              services.toString(),
                              content.text);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(message)));
                        },
                        child: Container(
                            alignment: Alignment.center,
                            width: size.width * 0.4,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20)),
                            padding: EdgeInsets.all(16),
                            child: Text(
                              "Submit",
                              style: TextStyle(color: Colors.white),
                            )))
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
