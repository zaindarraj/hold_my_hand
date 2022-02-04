import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hold_my_hand/consts.dart';
import 'package:hold_my_hand/logic/bloCs/registeration/bloc/registeration_bloc.dart';
import 'package:hold_my_hand/methods.dart';
import 'package:hold_my_hand/presentation/admin_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  double signInWidth = 0.1;
  double signUpWidth = 0.9;
  List<bool> accountType = List.generate(2, (index) => false);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue[800] as Color, Colors.blue[600] as Color])),
      child: BlocConsumer<RegisterationBloc, RegisterationState>(
          builder: (context, state) {
        if (state is Loading) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.white,
          ));
        }
        return PageView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              if (index == 0) {
                return signUpWidget(size);
              }
              return signInWidget(size);
            });
      }, listener: (context, state) async {
        if (state is ErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      }),
    ));
  }

  SingleChildScrollView signInWidget(Size size) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
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
                  const Text("Sign in",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  const Text("Welcome Back To Our Helpful World",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: size.height * 0.4,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          size.width * 0.1, 0, size.width * 0.1, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Form(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: TextFormField(
                              controller: email,
                              validator: validateEmail,
                              decoration:
                                  const InputDecoration(label: Text("Email")),
                            ),
                          ),
                          TextField(
                            controller: password,
                            decoration: const InputDecoration(
                              label: Text("Password"),
                            ),
                            obscureText: true,
                          ),
                          TextButton(
                            onPressed: () {
                              if (password.text.isNotEmpty &&
                                  email.text.isNotEmpty) {
                                if (password.text == adminPassword &&
                                    email.text == adminEmail) {
                                  Navigator.pushReplacement(
                                      context, MaterialPageRoute(builder: (context)=>const AdminScreen()));
                                }
                              }
                            },
                            child: Text("Sign in",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.blue[800] as Color)),
                          )
                        ],
                      ),
                    ),
                  ),
                  Text("Swipe to sign up <<<",
                      style: TextStyle(
                          fontSize: 17, color: Colors.blue[800] as Color))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView signUpWidget(Size size) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController firstName = TextEditingController();
    TextEditingController lastName = TextEditingController();
    TextEditingController disability = TextEditingController();
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
                  const Text("Sign Up",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  const Text("Enter A Helpful Word",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
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
                        decoration: const InputDecoration(label: Text("Email")),
                      ),
                    ),
                    TextField(
                      controller: password,
                      decoration: const InputDecoration(
                        label: Text("Password"),
                      ),
                      obscureText: true,
                    ),
                    TextField(
                      controller: firstName,
                      decoration: const InputDecoration(
                        label: Text("First Name"),
                      ),
                    ),
                    TextField(
                      controller: lastName,
                      decoration: const InputDecoration(
                        label: Text("Last Name"),
                      ),
                    ),
                    ToggleButtons(
                        selectedColor: Colors.blue,
                        onPressed: (index) {
                          for (int i = 0; i <= 1; i++) {
                            accountType[i] = false;
                          }
                          accountType[index] = true;
                          setState(() {});
                        },
                        children: [
                          SizedBox(
                            width: size.width * 0.2,
                            child: Center(
                                child: Text(
                              "Benefector",
                              style: TextStyle(
                                color: Colors.blue[800] as Color,
                              ),
                            )),
                          ),
                          SizedBox(
                            width: size.width * 0.2,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Disabled",
                                    style: TextStyle(
                                      color: Colors.blue[800] as Color,
                                    ),
                                  ),
                                  Text(
                                    "Person",
                                    style: TextStyle(
                                      color: Colors.blue[800] as Color,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                        isSelected: accountType),
                    accountType[1] == true
                        ? TextField(
                            controller: disability,
                            decoration: const InputDecoration(
                              label: Text("Disablity Type"),
                            ),
                          )
                        : Container(),
                    TextButton(
                        onPressed: () {
                          if (email.text.isNotEmpty &&
                                  password.text.isNotEmpty &&
                                  lastName.text.isNotEmpty &&
                                  firstName.text.isNotEmpty &&
                                  accountType.contains(true) &&
                                  accountType.indexWhere(
                                          (element) => element == true) ==
                                      1
                              ? disability.text.isNotEmpty
                              : false) {
                            BlocProvider.of<RegisterationBloc>(context).add(
                                SignUp(
                                    email: "email",
                                    password: "password",
                                    state: "0"));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("please fill all fields")));
                          }
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            color: Colors.blue[800] as Color,
                          ),
                        )),
                    Text("Swipe to sign in >>>",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).textScaleFactor * 16,
                          color: Colors.blue[800] as Color,
                        ))
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
