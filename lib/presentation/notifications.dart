import 'package:flutter/material.dart';
import 'package:hold_my_hand/classes/api.dart';
import 'package:hold_my_hand/presentation/registerScreen.dart';

class Notificatoins extends StatefulWidget {
  const Notificatoins({Key? key}) : super(key: key);

  @override
  State<Notificatoins> createState() => _NotificatoinsState();
}

class _NotificatoinsState extends State<Notificatoins> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                children: const [
                  const Text("Here are lists of pending services requests !",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const Text("Approve what suits you.",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ],
              ),
            ),
            Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                height: size.height * 0.7,
                width: size.width,
                child: FutureBuilder<dynamic>(
                  future: API.getRequest(benefectorData!["id"]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        if (snapshot.data.runtimeType != String) {
                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.all(18),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                    children: [
                                      ListTile(
                                        title: snapshot.data[index]["name"],
                                        leading: snapshot.data[index]
                                            ["service"],
                                        subtitle: snapshot.data[index]
                                            ["content"],
                                      ),
                                      SizedBox(
                                        width: size.width * 0.3,
                                        child: Row(
                                          children: [
                                            IconButton(
                                                onPressed: () async {
                                                  dynamic response =
                                                      await API.approveRequest(
                                                          benefectorData!["id"],
                                                          snapshot.data[index]
                                                              ["service_id"],
                                                          true);
                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response)));
                                                },
                                                icon: const Icon(
                                                    Icons.approval_rounded)),
                                            IconButton(
                                                onPressed: () {},
                                                icon: const Icon(Icons.remove)),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              });
                        }
                      }
                    }
                    return Center(
                      child: const Text("No Pending Requests"),
                    );
                  },
                ))
          ],
        ),
      ),
    );
  }
}
