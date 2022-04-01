


import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ManageCenters extends StatefulWidget {
  const ManageCenters({ Key? key }) : super(key: key);

  @override
  State<ManageCenters> createState() => _ManageCentersState();
}

class _ManageCentersState extends State<ManageCenters> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Scaffold(
      body: Column(
        children: [
            SizedBox(
              width: size.width,
              child: SvgPicture.asset("assets/c.svg",)),
              
        ],
      ),
    );
  }
}