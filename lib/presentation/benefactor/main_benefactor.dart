import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hold_my_hand/classes/api.dart';
import 'package:hold_my_hand/presentation/registerScreen.dart';

class MainBenefactorScreen extends StatefulWidget {
  const MainBenefactorScreen({Key? key}) : super(key: key);

  @override
  State<MainBenefactorScreen> createState() => _MainBenefactorScreenState();
}

class _MainBenefactorScreenState extends State<MainBenefactorScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
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
              SizedBox(
                width: size.width,
                height: size.height * 0.5,
                child: SvgPicture.asset(
                  "assets/bottom.svg",
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
          FutureBuilder<List<Map<String, dynamic>>?>(
              future: API.getNearbyUsers("1"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Container(
                      padding: EdgeInsets.all(18),
                      alignment: Alignment.topCenter,
                      width: size.width * 0.9,
                      height: size.height * 0.7,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(3, 0),
                                color: Colors.grey,
                                blurRadius: 10,
                                spreadRadius: 4)
                          ],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              alignment: Alignment.center,
                              width: size.width * 0.7,
                              height: size.height * 0.1,
                              margin: EdgeInsets.all(8),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Colors.blue,
                                  Colors.blue.withOpacity(0.5)
                                ]),
                                boxShadow: const [
                                  BoxShadow(
                                      offset: Offset(3, 0),
                                      color: Colors.blueAccent,
                                      blurRadius: 4,
                                      spreadRadius: 5)
                                ],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                "Name : " + snapshot.data![index]["name"],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          }),
                    );
                  }
                }
                return SvgPicture.asset("assets/no data.svg");
              })
        ],
      ),
    );
  }
}
