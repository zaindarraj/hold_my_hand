import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hold_my_hand/logic/bloCs/admin/bloc/admin_bloc.dart';
import 'package:hold_my_hand/logic/bloCs/registeration/bloc/registeration_bloc.dart';
import 'package:hold_my_hand/presentation/admin%20screens/adding_user.dart'
    as widget;
import 'package:hold_my_hand/presentation/registerScreen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int currentIndex = 0;
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
            child: const Icon(Icons.logout),
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
                    return const Text("manage centers");
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

  ListView body(Size size, Widget intro, Widget body) {
    return ListView(
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
        Container(
          height: size.height * 0.7,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: body,
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
                    builder: (_) => BlocProvider(create: (_)=> AdminBloc(),
                    child:const widget.AddUserScreen(),)));
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
          onPressed: () {},
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
          onPressed: () {},
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
          onPressed: () {},
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
          onPressed: () {},
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
          onPressed: () {},
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
        SizedBox(height: size.height * 0.0001)
      ],
    );
  }
}
