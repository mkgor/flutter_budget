import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tinycolor/tinycolor.dart';

import 'styles.dart';

class ExpenseItem extends StatelessWidget {
  String name;
  int spent;
  int available;
  String icon;
  Color iconBgColor;

  ExpenseItem(
      this.name, this.spent, this.available, this.icon, this.iconBgColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 200, .1),
                spreadRadius: 1,
                blurRadius: 8,
                offset: Offset(0, 6))
          ]),
      child: Padding(
        padding: const EdgeInsets.all(19),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Stack(children: [
                  Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft,
                              colors: [
                                TinyColor(this.iconBgColor).darken(15).color,
                                this.iconBgColor
                              ]),
                          borderRadius: BorderRadius.circular(100)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset(this.icon,
                              width: 30, color: Colors.white)
                        ],
                      )),
                  SizedBox(
                    width: 60,
                    height:60,
                    child: CircularProgressIndicator(
                      value: this.spent / this.available,
                      valueColor:  AlwaysStoppedAnimation((spent < available) ? TinyColor(this.iconBgColor).darken(15).color : Colors.redAccent),

                    ),
                  ),
                ]),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        this.name,
                        style: TextStyle(
                            color: Styles.colorSubheading,
                            fontWeight: FontWeight.w500,
                            fontSize: 17),
                      ),
                      Text((spent < available) ? "\$${available - spent} left" : "\$${(available - spent)*(-1)} overrun",
                          style: TextStyle(
                              color: (spent < available) ? Color.fromRGBO(144, 147, 149, 1) : Colors.red,
                              fontSize: 13))
                    ],
                  )),
                ),
              ],
            ),
            Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  "\$$available",
                  style: TextStyle(
                      color: Styles.colorMoneyBlue,
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
                ),
                Text("\$$spent of \$$available",
                    style: TextStyle(
                      color: (spent < available) ? Color.fromRGBO(144, 147, 149, 1) : Colors.red,
                      fontSize: 13,
                    ))
              ],
            ))
          ],
        ),
      ),
    );
  }
}
