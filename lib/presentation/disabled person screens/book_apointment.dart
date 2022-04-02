import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hold_my_hand/classes/api.dart';

class BookApointment extends StatefulWidget {
  const BookApointment({Key? key}) : super(key: key);

  @override
  State<BookApointment> createState() => _BookApointmentState();
}

class _BookApointmentState extends State<BookApointment> {
  DateTime? picked;
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          child: Stack(
            alignment: Alignment.centerLeft,
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
                  SizedBox(
                    width: size.width,
                    height: size.height * 0.5,
                    child: SvgPicture.asset(
                      "assets/bottom.svg",
                      fit: BoxFit.fill,
                    ),
                  )
                ],
              ),
              Positioned(
                  top: 0,
                  left: 0,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back)),
                          Text(
                            "Book an appointment",
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  )),
              Container(
                padding: EdgeInsets.all(18),
                decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.blueAccent,
                          offset: Offset(3, 0),
                          blurRadius: 10)
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                width: size.width * 0.8,
                height: size.height * 0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "Insert your appointment's info",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        letterSpacing: 1.5,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                          label: Text("Appointment Type : "),
                          hintText: "e.g : Doctor's appointment, dentist etc"),
                    ),
                    TextButton(
                        onPressed: () {
                          _selectDate(context);
                        },
                        child: Container(
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20)),
                          padding: EdgeInsets.all(18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedDate.year.toString() +
                                    "/" +
                                    selectedDate.month.toString() +
                                    "/" +
                                    selectedDate.day.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(
                                Icons.date_range,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              ),
              Positioned(
                left: size.width * 0.75,
                top: 0,
                bottom: 0,
                child: IconButton(
                    onPressed: () async {
                    },
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: Colors.blue,
                      size: 40,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
