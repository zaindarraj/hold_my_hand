import 'package:flutter/material.dart';


class DisabledPersonScreen extends StatefulWidget {
  const DisabledPersonScreen({ Key? key }) : super(key: key);

  @override
  _DisabledPersonScreenState createState() => _DisabledPersonScreenState();
}

class _DisabledPersonScreenState extends State<DisabledPersonScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Disabled Person"),),
    );
  }
}