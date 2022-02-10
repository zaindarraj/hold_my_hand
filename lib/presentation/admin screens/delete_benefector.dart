import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hold_my_hand/logic/bloCs/admin/bloc/admin_bloc.dart';

import '../../methods.dart';

class DeleteBenefectorScreen extends StatefulWidget {
  const DeleteBenefectorScreen({Key? key}) : super(key: key);

  @override
  _DeleteBenefectorScreenState createState() => _DeleteBenefectorScreenState();
}

class _DeleteBenefectorScreenState extends State<DeleteBenefectorScreen> {
    TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Delete a User",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: size.height * 0.7,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      size.width * 0.1, 0, size.width * 0.1, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: TextFormField(
                          controller: email,
                          validator: validateEmail,
                          decoration:
                              const InputDecoration(label: Text("Email")),
                        ),
                      ),
                     
                      TextButton(
                          onPressed: () {
                            if (email.text.isNotEmpty 
                              ) {
                              BlocProvider.of<AdminBloc>(context).add(
                                  DeleteUser(email: email.text));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("please fill all fields")));
                            }
                          },
                          child: Text(
                            "Delete User",
                            style: TextStyle(
                              color: Colors.blue[800] as Color,
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
