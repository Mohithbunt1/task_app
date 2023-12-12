import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_/screens/Gotask.dart';

var _wlmbg = const Color.fromRGBO(21, 96, 188, 1);
var _bodycolor = const Color.fromRGBO(55, 135, 235, 1);
var _appbarclr = const Color.fromRGBO(183, 214, 255, 1);
var _txtfield = Color.fromRGBO(166, 203, 248, 1);
var _gradbody = LinearGradient(
    begin: AlignmentDirectional.bottomStart,
    end: AlignmentDirectional.topStart,
    colors: [
      Color.fromRGBO(214, 232, 255, 1),
      Color.fromRGBO(214, 232, 255, 0),
    ]);

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();

  Future<void> login() async {
    if ((_email.text == "123" || _email.text == "7259282655") &&
        _pass.text == "123") {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool("loggedin", true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return TaskGo();
        }),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Invalid Email/Phone or Invalid Password"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(183, 214, 255, 1),
      child: SafeArea(
        child: Scaffold(
          body: Container(
            height: 1080,
            decoration: BoxDecoration(gradient: _gradbody),
            child: Column(
              children: [
                const Gap(30),
                Center(
                  child: Text(
                    "Welcome",
                    style: TextStyle(
                        fontSize: 25,
                        color: _wlmbg,
                        fontWeight: FontWeight.w600,
                        fontFamily: " VariableFont_slnt"),
                  ),
                ),
                Center(
                  child: Text(
                    "Login to continue",
                    style: TextStyle(
                        fontSize: 16,
                        color: _bodycolor,
                        fontWeight: FontWeight.w400,
                        fontFamily: " VariableFont_slnt"),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 150, right: 360, bottom: 2),
                  child: Text(
                    "Email/Phone",
                    style: TextStyle(
                        fontSize: 16,
                        color: _bodycolor,
                        fontWeight: FontWeight.w400,
                        fontFamily: " VariableFont_slnt"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16),
                  child: TextField(
                    controller: _email,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            style: BorderStyle.none,
                            color: _bodycolor,
                            width: 0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            style: BorderStyle.none,
                            width: 0,
                          ),
                        ),
                        fillColor: _txtfield,
                        filled: true),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 370, top: 10, bottom: 2),
                  child: Text(
                    "Password",
                    style: TextStyle(
                        fontSize: 16,
                        color: _bodycolor,
                        fontWeight: FontWeight.w400,
                        fontFamily: " VariableFont_slnt"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16),
                  child: TextField(
                    controller: _pass,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            style: BorderStyle.none,
                            color: _bodycolor,
                            width: 0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            style: BorderStyle.none,
                            width: 0,
                          ),
                        ),
                        fillColor: _txtfield,
                        filled: true),
                  ),
                ),
                const Gap(15),
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        padding:
                            const MaterialStatePropertyAll(EdgeInsets.all(10)),
                        shape: const MaterialStatePropertyAll(
                          BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                        ),
                        backgroundColor: MaterialStatePropertyAll(
                          _bodycolor,
                        )),
                    onPressed: login,
                    child: const Text(
                      "      Login      ",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontFamily: " VariableFont_slnt"),
                    ),
                  ),
                ),
                Gap(20),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 175),
                      child: Text(
                        "Don't have an Account?",
                        style: TextStyle(
                            fontSize: 13,
                            color: _bodycolor,
                            fontWeight: FontWeight.w400,
                            fontFamily: " VariableFont_slnt"),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              fontSize: 13,
                              color: _wlmbg,
                              fontWeight: FontWeight.w600,
                              fontFamily: " VariableFont_slnt"),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
