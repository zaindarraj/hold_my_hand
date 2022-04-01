import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hold_my_hand/logic/bloCs/admin/bloc/admin_bloc.dart';
import 'package:hold_my_hand/logic/bloCs/registeration/bloc/registeration_bloc.dart';
import 'package:hold_my_hand/presentation/admin%20screens/add_benefector.dart';
import 'package:hold_my_hand/presentation/admin%20screens/adding_user.dart'
    as widget;
import 'package:hold_my_hand/presentation/admin%20screens/approve_benefector.dart';
import 'package:hold_my_hand/presentation/admin%20screens/approve_user.dart';
import 'package:hold_my_hand/presentation/admin%20screens/delete_benefector.dart';
import 'package:hold_my_hand/presentation/admin%20screens/delete_user.dart';
import 'package:hold_my_hand/presentation/registerScreen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int currentIndex = 0;
  List<String> centers = ["Khaerat", "Help Hand Center", "asda"];
  TextEditingController centerName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<RegisterationBloc, RegisterationState>(
      listener: (context, state) {
        if (state is RegisterationInitial) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => const RegisterScreen()));
        }
      },
      child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.logout,color: Colors.blue,),
            onPressed: () {
              BlocProvider.of<RegisterationBloc>(context).add(SignOut());
            },
          ),
          bottomNavigationBar: bottomAppBar(context),
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.blue[800] as Color,
              Colors.blue[600] as Color
            ])),
            child: BlocConsumer<AdminBloc, AdminState>(
                builder: (context, state) {
                  if (currentIndex == 0) {
                    return body(
                        size, manageAccountsIntro(size), manageAccounts(size));
                  } else {
                    BlocProvider.of<AdminBloc>(context).add(GetCenters());
                    return body(
                        size, manageAccountsIntro(size), manageCenters(size));
                  }
                },
                listener: (context, state) {}),
          )),
    );
  }

  BottomAppBar bottomAppBar(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 4.0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
              onPressed: () {
                setState(() {
                  currentIndex = 0;
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.person,
                    color: currentIndex == 0
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                  ),
                  Text(
                    "Manage Accounts",
                    style: TextStyle(
                        color: currentIndex == 0
                            ? Theme.of(context).primaryColor
                            : Colors.grey),
                  )
                ],
              )),
          TextButton(
              onPressed: () {
                setState(() {
                  currentIndex = 1;
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.person,
                    color: currentIndex == 1
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                  ),
                  Text(
                    "Manage Centers",
                    style: TextStyle(
                        color: currentIndex == 1
                            ? Theme.of(context).primaryColor
                            : Colors.grey),
                  )
                ],
              ))
        ],
      ),
    );
  }

  Widget body(Size size, Widget intro, Widget body) {
    return Column(
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
            child: intro,
          ),
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: body,
          ),
        ),
      ],
    );
  }

  Column manageAccountsIntro(Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Manager your users accounts",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        SizedBox(
          height: size.height * 0.02,
        ),
        const Text("Here's the list of every function you can make",
            style: TextStyle(fontSize: 18, color: Colors.white)),
      ],
    );
  }

  Widget manageCenters(Size size) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: centerName,
                  decoration: const InputDecoration(
                      label: Text("Center name"), icon: Icon(Icons.house)),
                ),
                TextButton(
                    onPressed: () {
                      if (centerName.text.isNotEmpty) {
                        BlocProvider.of<AdminBloc>(context)
                            .add(AddCenter(name: centerName.text));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Please fill the name field")));
                      }
                    },
                    child: const Text("Add Center"))
              ],
            ),
          ),
          BlocBuilder<AdminBloc, AdminState>(builder: (context, state) {
            if (state is Centers) {
              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Click on the center to delete it :",
                      style: TextStyle(fontSize: 20),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: state.list.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                onTap: () {
                                  BlocProvider.of<AdminBloc>(context).add(
                                      DeleteCenter(
                                          centerID: state.list[index]
                                              ["center_id"]));
                                },
                                dense: true,
                                textColor: Colors.green,
                                leading: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                title: Text(state.list[index]["name"]),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              );
            } else {
              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Click on the center to delete it :",
                      style: TextStyle(fontSize: 20),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: centers.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                dense: true,
                                textColor: Colors.green,
                                leading: Icon(
                                  Icons.remove,
                                  color: Colors.red,
                                ),
                                title: Text(centers[index]),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              );
            }
          })
        ],
      ),
    );
  }

  GridView manageAccounts(Size size) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 10),
      children: [
        TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => BlocProvider(
                          create: (_) => AdminBloc(),
                          child: const widget.AddUserScreen(),
                        )));
          },
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: LinearGradient(colors: [
                    Colors.blue[800] as Color,
                    Colors.blue[600] as Color
                  ])),
              child: const Center(
                  child: Text(
                "Add User",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ))),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => BlocProvider(
                          create: (_) => AdminBloc(),
                          child: const DeleteUserScreen(),
                        )));
          },
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: LinearGradient(colors: [
                    Colors.blue[800] as Color,
                    Colors.blue[600] as Color
                  ])),
              child: const Center(
                  child: Text(
                "Delete User",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ))),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => BlocProvider(
                          create: (_) => AdminBloc(),
                          child: const AddBenefectorScreen(),
                        )));
          },
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: LinearGradient(colors: [
                    Colors.blue[800] as Color,
                    Colors.blue[600] as Color
                  ])),
              child: const Center(
                  child: Text(
                "Add Benefector",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ))),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => BlocProvider(
                          create: (_) => AdminBloc(),
                          child: const DeleteBenefectorScreen(),
                        )));
          },
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: LinearGradient(colors: [
                    Colors.blue[800] as Color,
                    Colors.blue[600] as Color
                  ])),
              child: const Center(
                  child: Text(
                "Delete Benefector",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ))),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => BlocProvider(
                          create: (_) => AdminBloc()..add(GetUsersList()),
                          child: const ApproveUserScreen(),
                        )));
          },
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: LinearGradient(colors: [
                    Colors.blue[800] as Color,
                    Colors.blue[600] as Color
                  ])),
              child: const Center(
                  child: Text(
                "Approve User",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ))),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => BlocProvider(
                          create: (_) => AdminBloc()..add(GetBenefactorList()),
                          child: const ApproveBenefectorScreen(),
                        )));
          },
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: LinearGradient(colors: [
                    Colors.blue[800] as Color,
                    Colors.blue[600] as Color
                  ])),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Approve",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Benefector",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ))),
        ),
      ],
    );
  }
}
