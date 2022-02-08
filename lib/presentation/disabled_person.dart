import 'package:flutter/material.dart';


class DisabledPerson extends StatefulWidget {
  const DisabledPerson({ Key? key }) : super(key: key);

  @override
  _DisabledPersonState createState() => _DisabledPersonState();
}

class _DisabledPersonState extends State<DisabledPerson> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Disabled Person"),),
    );
  }
}