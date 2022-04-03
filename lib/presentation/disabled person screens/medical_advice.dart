



import 'package:flutter/material.dart';


class MedicalAdviceScreen extends StatefulWidget {
  const MedicalAdviceScreen({ Key? key }) : super(key: key);

  @override
  State<MedicalAdviceScreen> createState() => _MedicalAdviceScreenState();
}

class _MedicalAdviceScreenState extends State<MedicalAdviceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset("assets/doctor.jpg"),
          TextField(
            decoration: InputDecoration(
              label: Text("Injury")
            ),
          ),
          TextButton(onPressed: (){

          }, child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20)
            ),
            padding: EdgeInsets.all(18),
            alignment: Alignment.center,
            child: Text("Submit",
            style: TextStyle(color: Colors.white,
            fontWeight: FontWeight.bold,),),
          ))
        ],
      ),
    );
  }
}