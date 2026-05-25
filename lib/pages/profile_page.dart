import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mon Compte"),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset("/assets/images/person.svg"),
              Container(
                child: Column(children: [
                  Text("ATEUMO ARIANE"),
                  Text("arianeateumo@gmail.com"),
                ]),
              )
            ],
          )
        ],
      )),
    );
  }
}
