import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(home: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  double rs = 0.0;
  double dong = 0.0;
  TextEditingController rsController = TextEditingController();
  TextEditingController dongController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      color: const Color.fromRGBO(17, 0, 25, 1),
      padding: const EdgeInsets.fromLTRB(5, 50, 5, 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Mulya",
              textAlign: TextAlign.center,
              style: GoogleFonts.spaceMono(
                color: Color.fromRGBO(200, 230, 0, 1),
                fontWeight: FontWeight.bold,
                fontSize: 30,
              )),
          SizedBox(
            child: Column(
              children: [
                CurrencyTextBox(
                  curr: "Dong",
                  val: dong.toString(),
                  sourceTextEditingController: dongController,
                  destTextEditingController: rsController,
                  multiplier: 0.0035,
                ),
                SizedBox(
                  height: 20,
                ),
                CurrencyTextBox(
                  curr: "Rupee",
                  val: rs.toString(),
                  sourceTextEditingController: rsController,
                  destTextEditingController: dongController,
                  multiplier: 288.19,
                ),
              ],
            ),
          ),
          SizedBox(),
        ],
      ),
    ));
  }
}

// ignore: must_be_immutable
class CurrencyTextBox extends StatefulWidget {
  var curr;
  double multiplier;
  String val;
  TextEditingController sourceTextEditingController;
  TextEditingController destTextEditingController;
  CurrencyTextBox(
      {Key? key,
      required this.curr,
      required this.multiplier,
      required this.val,
      required this.sourceTextEditingController,
      required this.destTextEditingController})
      : super(key: key);

  @override
  State<CurrencyTextBox> createState() => _CurrencyTextBoxState();
}

class _CurrencyTextBoxState extends State<CurrencyTextBox> {
  @override
  Widget build(BuildContext context) {
    const currencyMap = {"Dong": "₫", "Rupee": "₹"};
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * .75,
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), color: Color.fromARGB(255, 40, 15, 50)),
      child: Row(
        children: [
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width * .75 * .15,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
              color: Color.fromRGBO(150, 110, 165, 1),
            ),
            child: Center(
              child: Text(
                "${currencyMap[widget.curr]}",
                textAlign: TextAlign.center,
                style: GoogleFonts.spaceMono(fontSize: 25),
              ),
            ),
          ),
          Flexible(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .75 * .80,
              child: TextField(
                controller: widget.sourceTextEditingController,
                onChanged: (val) {
                  try {
                    widget.destTextEditingController.text = (double.parse(val) * widget.multiplier).toString();
                  } catch (e) {
                    widget.destTextEditingController.text = '0.0';
                  }
                },
                keyboardType: TextInputType.number,
                style: GoogleFonts.spaceMono(color: Colors.white),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 2),
                    hintText: "Enter ${widget.curr}",
                    hintStyle: GoogleFonts.spaceMono(color: Color.fromARGB(141, 255, 255, 255))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
