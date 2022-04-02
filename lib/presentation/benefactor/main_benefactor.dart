import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
        alignment: Alignment.center,
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
        ],
      ),
    );
  }
}
