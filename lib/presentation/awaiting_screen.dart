import 'package:flutter/material.dart';

class AwaitingVerfication extends StatefulWidget {
  const AwaitingVerfication({Key? key}) : super(key: key);

  @override
  _AwaitingVerficationState createState() => _AwaitingVerficationState();
}

class _AwaitingVerficationState extends State<AwaitingVerfication> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Center(
      child: Container(
        width: size.width * 0.5,
        height: size.height * 0.3,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: const Center(child: Text("Awaiting Verfication")),
      ),
    ));
  }
}
