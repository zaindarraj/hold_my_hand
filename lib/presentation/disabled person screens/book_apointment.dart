import 'package:flutter/material.dart';

class BookApointment extends StatefulWidget {
  const BookApointment({Key? key}) : super(key: key);

  @override
  State<BookApointment> createState() => _BookApointmentState();
}

class _BookApointmentState extends State<BookApointment> {
  bool isDoctor = false;
  bool isDentist = false;
  bool isVet = false;
  DateTime? picked;
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.blue[800] as Color,
          Colors.blue[600] as Color
        ])),
        child: Column(
          children: [
            Expanded(flex: 1, child: intro(size, context)),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Column(
                    children: [
                      const Text("Appointment type : "),
                      Row(
                        children: [
                          CheckboxListTile(
                              title: const Text("Doctor's appointment"),
                              value: isDoctor,
                              onChanged: (newValue) {
                                if (newValue == true) {
                                  isDoctor = true;
                                  isDentist = false;
                                  isVet = false;
                                  setState(() {});
                                } else {
                                  isDoctor = false;
                                }
                              }),
                          CheckboxListTile(
                              title: const Text("Dentist's appointment"),
                              value: isDentist,
                              onChanged: (newValue) {
                                if (newValue == true) {
                                  isDoctor = false;
                                  isDentist = true;
                                  isVet = false;
                                  setState(() {});
                                } else {
                                  isDentist = true;
                                }
                              }),
                          CheckboxListTile(
                              title: const Text("Dentist's appointment"),
                              value: isVet,
                              onChanged: (newValue) {
                                if (newValue == true) {
                                  isDoctor = false;
                                  isDentist = false;
                                  isVet = true;
                                  setState(() {});
                                } else {
                                  isVet = true;
                                }
                              }),
                        ],
                      ),
                      TextButton(
                          onPressed: () async {
                            picked = await showDatePicker(
                                context: context,
                                initialDate: selectedDate,
                                firstDate: DateTime(2015, 8),
                                lastDate: DateTime(2101));
                          },
                          child: const Text("Pick Date"))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget intro(Size size, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue[800] as Color, Colors.blue[600] as Color])),
      child: Column(
        children: const [
          Text(
            "Book an apointment",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            "by entering your info here : ",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
