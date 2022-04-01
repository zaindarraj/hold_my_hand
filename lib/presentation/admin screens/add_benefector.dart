import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hold_my_hand/logic/bloCs/admin/bloc/admin_bloc.dart';

import '../../methods.dart';

class AddBenefectorScreen extends StatefulWidget {
  const AddBenefectorScreen({Key? key}) : super(key: key);

  @override
  _AddBenefectorScreenState createState() => _AddBenefectorScreenState();
}

class _AddBenefectorScreenState extends State<AddBenefectorScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue[800] as Color, Colors.blue[600] as Color])),
      child: BlocConsumer<AdminBloc, AdminState>(
          builder: (context, state) {
            if (state is Done) {
              return Center(
                child: Container(
                  width: size.width * 0.5,
                  height: size.height * 0.3,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Center(child: Text("All Done")),
                ),
              );
            } else if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is Error) {
              return Center(
                child: Text(state.error),
              );
            }
            return body(size, context);
          },
          listener: (context, state) {}),
    ));
  }

  SingleChildScrollView body(Size size, BuildContext context) {
    return SingleChildScrollView(
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
                  const Text("Add a User",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const Text("Provide the information needed !",
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
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          label: Text("Email")),
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
