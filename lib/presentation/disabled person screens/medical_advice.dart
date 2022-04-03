import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hold_my_hand/classes/api.dart';

import '../../logic/bloCs/disabled person/bloc/disabled_person_bloc.dart';

class MedicalAdviceScreen extends StatefulWidget {
  const MedicalAdviceScreen({Key? key}) : super(key: key);

  @override
  State<MedicalAdviceScreen> createState() => _MedicalAdviceScreenState();
}

class _MedicalAdviceScreenState extends State<MedicalAdviceScreen> {
  TextEditingController injury = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String userID =
        BlocProvider.of<DisabledPersonBloc>(context).data["id"].toString();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            width: size.width * 0.9,
            height: size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.blue,
                        )),
                    const Text(
                      "Medical Advice",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    )
                  ],
                ),
                Image.asset(
                  "assets/doctor.png",
                ),
                TextField(
                  decoration: InputDecoration(label: Text("Injury")),
                ),
                TextButton(
                    onPressed: () async {
                      if (injury.text.isNotEmpty) {
                       String response =  await API.medicalAdvice(userID.toString(), injury.text);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(response)));
                      }else {
   ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text("please fill all fields")));
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.all(18),
                      alignment: Alignment.center,
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
