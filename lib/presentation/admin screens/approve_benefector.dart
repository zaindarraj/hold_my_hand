import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hold_my_hand/logic/bloCs/admin/bloc/admin_bloc.dart';

class ApproveBenefectorScreen extends StatefulWidget {
  const ApproveBenefectorScreen({Key? key, email}) : super(key: key);

  @override
  _ApproveBenefectorScreenState createState() =>
      _ApproveBenefectorScreenState();
}

class _ApproveBenefectorScreenState extends State<ApproveBenefectorScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.blue[800] as Color,
          Colors.blue[600] as Color
        ])),
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
                    const Text("Choose to accept or reject benefactors",
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
                width: size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: BlocConsumer<AdminBloc, AdminState>(
                    builder: (context, state) {
                  print(state);
                  if (state is BenefactorListReady) {
                    return ListView.builder(
                        itemCount: state.list.length,
                        itemBuilder: (context, index) {
                          /*  return ListTile(
                            title: Text(
                              state.list[index]["name"],
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                            subtitle: Text(
                              state.list[index]["email"],
                            ),
                            onTap: () {
                              BlocProvider.of<AdminBloc>(context).add(
                                  ApproveBenefector(
                                      userID: state.list[index]["id"]));
                            },
                          );*/
                          return Container(
                            margin: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: Theme.of(context).primaryColor)),
                            padding: const EdgeInsets.all(8),
                            child: ListTile(
                              trailing: SizedBox(
                                  width: size.width * 0.3,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                          
                                            BlocProvider.of<AdminBloc>(context)
                                                .add(Approve(
                                                    order: "accept",
                                                    userID: state.list[index]
                                                            ["data"]["id"]
                                                        .toString()));
                                          },
                                          icon: const Icon(Icons.person_add)),
                                      IconButton(
                                          onPressed: () {
                                            BlocProvider.of<AdminBloc>(context)
                                                .add(Approve(
                                                    order: "reject",
                                                    userID: state.list[index]
                                                            ["data"]["id"]
                                                        .toString()));
                                          },
                                          icon: const Icon(Icons.person_remove))
                                    ],
                                  )),
                              title: Text(
                                state.list[index]["data"]["name"],
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                              subtitle: Text(
                                state.list[index]["data"]["email"],
                              ),
                              onTap: () {
                                BlocProvider.of<AdminBloc>(context).add(Approve(
                                  userID: state.list[index]["data"]["id"]
                                      .toString(),
                                  order: 'accept',
                                ));
                              },
                            ),
                          );
                        });
                  } else if (state is Error) {
                    return Center(child: Text(state.error));
                  }
                   else if (state is NoUsers) {
                    return Center(child: Text("No Users Awaiting"));
                  }
                  return const Center(child: CircularProgressIndicator());
                }, listener: (context, state) {
                  if (state is Error) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.error)));
                  }
                }))
          ],
        ),
      ),
    );
  }
}
