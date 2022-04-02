import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hold_my_hand/logic/bloCs/admin/bloc/admin_bloc.dart';

import '../../methods.dart';

class Delete extends StatefulWidget {
  const Delete({Key? key}) : super(key: key);

  @override
  _DeleteState createState() => _DeleteState();
}

class _DeleteState extends State<Delete> {
  TextEditingController email = TextEditingController();
  bool isUser = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
          child: Stack(
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
                child: Row(
            children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back)),
                    Text("Delete a User or a Benefactor",
                    style: TextStyle(color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold),)
            ],
          ),
              )),
          Container(
            width: size.width * 0.9,
            padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(3, 0),
                      blurRadius: 10,
                      spreadRadius: 5,
                      color: Colors.blue)
                ]),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(label: Text("Email")),
                ),
                CheckboxListTile(
                    title: Text("Disabled User"),
                    value: isUser,
                    onChanged: (newVal) {
                      isUser = newVal as bool;
                      setState(() {});
                    }),
                CheckboxListTile(
                    title: Text("Benefactor"),
                    value: !isUser,
                    onChanged: (newVal) {
                      isUser = !(newVal as bool);
                      setState(() {});
                    }),
                IconButton(onPressed: (){

                }, icon: const Icon(Icons.delete_forever_rounded,color: Colors.blue,size: 30,))
              ],
            ),
          )
        ],
      )),
    );
  }
}
