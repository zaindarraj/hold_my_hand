import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hold_my_hand/logic/bloCs/admin/bloc/admin_bloc.dart';
import 'package:hold_my_hand/logic/bloCs/registeration/bloc/registeration_bloc.dart'
    as reg;
import 'package:hold_my_hand/presentation/admin%20screens/add_benefector.dart';
import 'package:hold_my_hand/presentation/admin%20screens/adding_user.dart';
import 'package:hold_my_hand/presentation/admin%20screens/delete.dart';
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
    return BlocListener<reg.RegisterationBloc, reg.RegisterationState>(
      listener: (context, state) {
        if (state is reg.RegisterationInitial) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => const RegisterScreen()));
        }
      },
      child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            child: const Icon(
              Icons.logout,
              color: Colors.blue,
            ),
            onPressed: () {
              BlocProvider.of<reg.RegisterationBloc>(context)
                  .add(reg.SignOut());
            },
          ),
          bottomNavigationBar: bottomAppBar(context, size),
          body: BlocConsumer<AdminBloc, AdminState>(
              builder: (context, state) {
                if (currentIndex == 0) {
                  return manageAccounts(size);
                } else {
                  BlocProvider.of<AdminBloc>(context).add(GetCenters());
                  return manageCenters(size);
                }
              },
              listener: (context, state) {})),
    );
  }

  BottomAppBar bottomAppBar(BuildContext context, Size size) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 4.0,
      child: Container(
        height: size.height * 0.1,
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
      ),
    );
  }

  Widget manageCenters(Size size) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.asset("assets/centers.png"),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: TextField(
                      controller: centerName,
                      decoration: const InputDecoration(
                          label: Text("Center name"), icon: Icon(Icons.house)),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        if (centerName.text.isNotEmpty) {
                          BlocProvider.of<AdminBloc>(context)
                              .add(AddCenter(name: centerName.text));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Please fill the name field")));
                        }
                      },
                      child: const Text("Add Center"))
                ],
              ),
            ),
            BlocConsumer<AdminBloc, AdminState>(listener: (context, state) {
              if (state is Done) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            }, builder: (context, state) {
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
                                    gradient: LinearGradient(colors: [
                                      Colors.deepPurple,
                                      Colors.deepPurple.withOpacity(0.5)
                                    ]),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.purple.withOpacity(0.5),
                                        spreadRadius: 3,
                                        blurRadius: 3,
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
                                                ["id"]));
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
              }
              return Text(
                "It's such an empty space here! Add some centers !",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    letterSpacing: 1.3),
              );
            })
          ],
        ),
      ),
    );
  }

  Stack manageAccounts(Size size) {
    return Stack(
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
          ],
        ),
        Positioned(
            top: 0,
            left: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  "Admin Screen",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )),
        Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.blueAccent,
                    blurRadius: 10,
                    spreadRadius: 5,
                    offset: Offset(4, 0))
              ],
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          width: size.width * 0.9,
          height: size.height * 0.7,
          child: GridView(
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
                                child: const AddUserScreen(),
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
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ))),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => BlocProvider(
                                create: (_) => AdminBloc(),
                                child: const AddBenefactorScreen(),
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
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ))),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => BlocProvider(
                                create: (_) => AdminBloc(),
                                child: const Delete(),
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
                      "Delete User/Benefactor",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ))),
              ),
             
             
            ],
          ),
        ),
      ],
    );
  }
}
