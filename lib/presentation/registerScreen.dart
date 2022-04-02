import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hold_my_hand/consts.dart';
import 'package:hold_my_hand/logic/bloCs/admin/bloc/admin_bloc.dart' as admin;
import 'package:hold_my_hand/logic/bloCs/disabled%20person/bloc/disabled_person_bloc.dart';
import 'package:hold_my_hand/logic/bloCs/registeration/bloc/registeration_bloc.dart';
import 'package:hold_my_hand/logic/bloCs/voice%20commands/bloc/voice_commands_bloc.dart';
import 'package:hold_my_hand/methods.dart';
import 'package:hold_my_hand/presentation/admin%20screens/admin_screen.dart';
import 'package:hold_my_hand/presentation/benefactor/main_benefactor.dart';
import 'package:hold_my_hand/presentation/disabled%20person%20screens/disabled_person.dart';
Map<String, dynamic>? benefectorData;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  double signInWidth = 0.1;
  double signUpWidth = 0.9;
  List<bool> accountType = List.generate(2, (index) => false);
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController disability = TextEditingController();
  TextEditingController signInEmail = TextEditingController();
  TextEditingController signInPassword = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Scaffold(
          body: BlocConsumer<RegisterationBloc, RegisterationState>(
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
       

        if (state is User) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => MultiBlocProvider(
                        providers: [
                          BlocProvider<VoiceCommandsBloc>(
                            create: (BuildContext context) =>
                                VoiceCommandsBloc()..add(Initialize()),
                          ),
                          BlocProvider<DisabledPersonBloc>(
                            create: (BuildContext context) =>
                                DisabledPersonBloc(data: state.data),
                          ),
                        ],
                        child: const DisabledPersonScreen(),
                      )));
        } else if (state is Benefector) {
          benefectorData = state.data;
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const MainBenefactorScreen()));
        } else if (state is Admin) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => BlocProvider(
                        create: (_) => admin.AdminBloc(),
                        child: const AdminScreen(),
                      )));
        } else if (state is ErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      })),
    );
  }

  Widget signInWidget(Size size) {
    return SingleChildScrollView(
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                SizedBox(width: size.width, height: size.height * 0.5,
                
                child: SvgPicture.asset("assets/top.svg", fit: BoxFit.fill, ),
                )],
            ),
             Positioned(
              top: size.height*0.02,
              left: size.width*0.05,
              child: const SafeArea(
              child: Text("Sign in",
              
              style: TextStyle(color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 40
              )),
            )),
            Positioned(
             top: size.height*0.2,
              child: Container(
                height: size.height * 0.8,
                width: size.width*0.8,
                decoration:  BoxDecoration(
                    boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
                  borderRadius:const BorderRadius.only( 
                    topLeft: Radius.circular(20),
                    topRight : Radius.circular(20)
                  ),
                  color: Colors.white,
                ),
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
                                controller: signInEmail,
                                validator: validateEmail,
                                decoration: const InputDecoration(
                                    label: Text("Email"),
                                    icon: Icon(Icons.person)),
                              ),
                            ),
                            TextField(
                              controller: signInPassword,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.password),
                                label: Text("Password"),
                              ),
                              obscureText: true,
                            ),
                            TextButton(
                              onPressed: () {
                                if (signInPassword.text.isNotEmpty &&
                                    signInEmail.text.isNotEmpty) {
                                  if (signInPassword.text == adminPassword &&
                                      signInEmail.text == adminEmail) {
                                    BlocProvider.of<RegisterationBloc>(context)
                                        .add(SignInAdmin(
                                            email: adminEmail,
                                            password: adminPassword));
                                  } else {
                                    BlocProvider.of<RegisterationBloc>(context)
                                        .add(SignIn(
                                            email: signInEmail.text,
                                            password: signInPassword.text));
                                  }
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                color: Colors.blue[800] as Color,
                                borderRadius: BorderRadius.circular(6)
                                ),
                                padding :EdgeInsets.all(18),
                                child: Text("Sign in",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white)),
                              ),
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
      ),
    );
  }

  Widget signUpWidget(Size size) {
    return SingleChildScrollView(
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
            children: [
              SizedBox(width: size.width, height: size.height * 0.5,
              
              child: SvgPicture.asset("assets/top.svg", fit: BoxFit.fill, ),
              )],
          ),
           Positioned(
            top: size.height*0.02,
            left: size.width*0.05,
            child: const SafeArea(
            child: Text("Sign Up",
            
            style: TextStyle(color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 40
            )),
          )),
            Positioned(
               top: size.height*0.2,
              child: Container(
                height: size.height * 0.8,
                width: size.width*0.9,
                decoration:  BoxDecoration(
                         boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
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
                                label: Text("Email"), icon: Icon(Icons.email)),
                          ),
                        ),
                        Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: TextFormField(
                            validator: isNumeric,
                            controller: password,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.password),
                              label: Text("Password"),
                            ),
                            obscureText: true,
                          ),
                        ),
                        TextField(
                          controller: firstName,
                          decoration: const InputDecoration(
                              label: Text("First Name"), icon: Icon(Icons.person)),
                        ),
                        TextField(
                        
                          controller: lastName,
                          decoration: const InputDecoration(
                              label: Text("Last Name"), icon: Icon(Icons.person)),
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
                                    fontSize:
                                        MediaQuery.textScaleFactorOf(context) * 12,
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
                                          fontSize: MediaQuery.textScaleFactorOf(
                                                  context) *
                                              12,
                                          color: Colors.blue[800] as Color,
                                        ),
                                      ),
                                      Text(
                                        "Person",
                                        style: TextStyle(
                                          fontSize: MediaQuery.textScaleFactorOf(
                                                  context) *
                                              12,
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
                                  validateEmail(email.text) == null &&
                                  isNumeric(password.text) == null) {
                                if (accountType
                                        .indexWhere((element) => element == true) ==
                                    1) {
                                  if (disability.text.isNotEmpty) {
                                    BlocProvider.of<RegisterationBloc>(context)
                                        .add(SignUp(
                                      fName: firstName.text,
                                      lName: lastName.text,
                                      disabilityType: disability.text,
                                      email: "email",
                                      password: "password",
                                      accountType: accountType.indexWhere(
                                                  (element) => element == true) ==
                                              1
                                          ? "disabled person"
                                          : "benefector",
                                    ));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "please make sure you entered all the fields")));
                                  }
                                } else {
                                  BlocProvider.of<RegisterationBloc>(context)
                                      .add(SignUp(
                                    fName: firstName.text,
                                    lName: lastName.text,
                                    disabilityType: accountType.indexWhere(
                                                (element) => element == true) ==
                                            1
                                        ? disability.text
                                        : null,
                                    email: "email",
                                    password: "password",
                                    accountType: accountType.indexWhere(
                                                (element) => element == true) ==
                                            1
                                        ? "disabled person"
                                        : "benefactor",
                                  ));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("please fill all fields")));
                              }
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                color: Colors.blue[800] as Color,
                                borderRadius: BorderRadius.circular(6)
                                ),
                                padding :EdgeInsets.all(18),
                                child: Text("Sign Up",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white)),
                              ),),
                        Text("Swipe to sign in >>>",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).textScaleFactor * 16,
                              color: Colors.blue[800] as Color,
                            ))
                      ],
                    ),
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
