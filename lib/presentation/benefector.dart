import 'package:flutter/material.dart';


class BenefectorScreen extends StatefulWidget {
  const BenefectorScreen({ Key? key }) : super(key: key);

  @override
  _BenefectorScreenState createState() => _BenefectorScreenState();
}

class _BenefectorScreenState extends State<BenefectorScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Benefector"),),
      
    );
  }
}