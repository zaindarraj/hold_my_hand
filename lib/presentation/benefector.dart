import 'package:flutter/material.dart';
import 'package:hold_my_hand/classes/api.dart';
import 'package:hold_my_hand/classes/location.dart';
import 'package:hold_my_hand/consts.dart';
import 'package:hold_my_hand/presentation/registerScreen.dart';

import 'notifications.dart';

class BenefactorScreen extends StatefulWidget {
  const BenefactorScreen({Key? key}) : super(key: key);

  @override
  _BenefactorScreenState createState() => _BenefactorScreenState();
}

class _BenefactorScreenState extends State<BenefactorScreen> {
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
              setState(() {
                
              });
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.blue[800] as Color,
          Colors.blue[600] as Color
        ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.blue[800] as Color,
                Colors.blue[600] as Color
              ])),
              width: size.width,
              height: size.height * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Notificatoins()));
                        },
                        icon: const Icon(Icons.notifications)),
                  ),
                  const Text("Benefactor Screen !",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const Text("Select your services down below!",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Container(
                height: size.height * 0.7,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
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
                              benefectorData!["id"], services.toString(), content.text);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(message)));
                        },
                        child: const Text("Submit"))
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
