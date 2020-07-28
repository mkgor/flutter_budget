import 'package:budget/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

import 'styles.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> _expenseCategories = ['Auto', 'Food', 'Sport'];
  Map<String, Map> _expenses = {
    "auto": {"available": 1000, "spent": 0},
    "food": {"available": 1200, "spent": 0},
    "sport": {"available": 950, "spent": 0}
  };

  String _selectedExpense;

  final formKey = new GlobalKey<FormState>();

  void addSpent(String category, int value) {
    setState(() {
      _expenses[category]["spent"] += value;
    });
  }

  int getAllSpentings() {
    int spentings = 0;

    _expenses.forEach((key, value) {
      spentings += value["spent"];
    });

    return spentings;
  }

  int getAllAvailable() {
    int available = 0;

    _expenses.forEach((key, value) {
      available += value["available"];
    });

    return available;
  }

  Future<String> createAlertDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                  title: Text("Adding expense"),
                  content: Form(
                      child: Column(children: <Widget>[
                    DropdownButton(
                      hint: Text('Please choose a expense category'),
                      // Not necessary for Option 1
                      value: _selectedExpense,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedExpense = newValue;
                        });
                      },
                      items: _expenseCategories.map((location) {
                        return DropdownMenuItem(
                          child: new Text(location),
                          value: location,
                        );
                      }).toList(),
                    ),
                    TextField(
                      controller: customController,
                      decoration:
                          InputDecoration(hintText: 'Please enter a value'),
                    )
                  ])),
                  actions: <Widget>[
                    MaterialButton(
                        elevation: 5.0,
                        child: Text("Submit"),
                        onPressed: () {
                          addSpent(_selectedExpense.toLowerCase(),
                              int.parse(customController.text.toString()));
                          Navigator.of(context).pop();
                        })
                  ]);
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
        width: double.infinity,
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [
              TinyColor(Styles.colorBlue).darken(14).color,
              Styles.colorBlue,
            ])),
      ),
      Container(
          padding: EdgeInsets.all(15),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SvgPicture.asset('assets/images/open-menu.svg',
                          width: 30, color: Colors.white),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, .2),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            )
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 22.0,
                          backgroundImage:
                              AssetImage('assets/images/avatar.jpg'),
                        ),
                      )
                    ],
                  ),
                ),
                Text(
                  "Budgets",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                      width: double.infinity,
                      height: 150,
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
                        padding: EdgeInsets.all(19),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Total",
                                style: TextStyle(
                                    color: Styles.colorSubheading,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w500)),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("\$ ${getAllAvailable()}",
                                    style: TextStyle(
                                        color: Styles.colorMoneyBlue,
                                        fontSize: 48,
                                        fontWeight: FontWeight.w500)),
                                Material(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Styles.colorMoneyBlue,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(100),
                                    splashColor: Colors.white,
                                    onTap: () {
                                      return createAlertDialog(context);
                                    },
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: Styles.colorMoneyBlue
                                                  .withAlpha(150),
                                              blurRadius: 20,
                                              offset: Offset(0, 5))
                                        ],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          SvgPicture.asset(
                                            'assets/images/plus.svg',
                                            width: 20,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Text(
                              "- \$${getAllSpentings()} today",
                              style: TextStyle(color: Colors.red, fontSize: 15),
                            )
                          ],
                        ),
                      )),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: ListView(
                      children: <Widget>[
                        ExpenseItem(
                            'Auto',
                            _expenses["auto"]["spent"],
                            _expenses["auto"]["available"],
                            'assets/images/pickup-car.svg',
                            Styles.colorBlue),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ExpenseItem(
                              'Food',
                              _expenses["food"]["spent"],
                              _expenses["food"]["available"],
                              'assets/images/food.svg',
                              Colors.amber),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ExpenseItem(
                              'Sport',
                              _expenses["sport"]["spent"],
                              _expenses["sport"]["available"],
                              'assets/images/sport.svg',
                              Colors.green),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ))
    ]));
  }
}
