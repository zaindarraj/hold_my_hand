import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hold_my_hand/logic/bloCs/admin/bloc/admin_bloc.dart';

import '../../methods.dart';

class AddBenefactorScreen extends StatefulWidget {
  const AddBenefactorScreen({Key? key}) : super(key: key);

  @override
  _AddBenefactorScreenState createState() => _AddBenefactorScreenState();
}

class _AddBenefactorScreenState extends State<AddBenefactorScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: BlocConsumer<AdminBloc, AdminState>(builder: (context, state) {
      return body(size, context);
    }, listener: (context, state) {
      if (state is Done) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Done")));
      }
      if (state is Error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.error)));
      }
    }));
  }

  SingleChildScrollView body(Size size, BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        alignment: Alignment.bottomCenter,
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
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back)),
                      Text(
                        "Add a Benefactor to the database !",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              )),
          Container(
            height: size.height * 0.7,
            decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    spreadRadius: 5,
                    color: Colors.blue,
                  )
                ],
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
                        decoration: const InputDecoration(
                            icon: Icon(Icons.person), label: Text("Email")),
                      ),
                    ),
                    TextField(
                      controller: password,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.password),
                        label: Text("Password"),
                      ),
                      obscureText: true,
                    ),
                    TextField(
                      controller: firstName,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.drafts),
                        label: Text("First Name"),
                      ),
                    ),
                    TextField(
                      controller: lastName,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.drafts),
                        label: Text("Last Name"),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          if (email.text.isNotEmpty &&
                              password.text.isNotEmpty &&
                              lastName.text.isNotEmpty &&
                              firstName.text.isNotEmpty) {
                            BlocProvider.of<AdminBloc>(context)
                                .add(AddBenefector(
                              fname: firstName.text,
                              lnamel: lastName.text,
                              email: email.text,
                              password: password.text,
                            ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("please fill all fields")));
                          }
                        },
                        child: Text(
                          "Add User",
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
    );
  }
}
