import 'package:auth_buttons/auth_buttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/auth_service.dart';
import 'login_page.dart';
import 'show.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  Future<void> addUser() {
    return users
        .add({
          'name': _name.text,
          'email': _email.text,
          'password': _password.text,
        })
        .then((value) => print("User data has been successfully"))
        .catchError((error) => print("Failed to add data: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/backlog.jpg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/logo1.png',
                    fit: BoxFit.contain,
                    height: 200,
                    width: 180,
                  ),
                ],
              ),
            ),
            formfield(context),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView formfield(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 170),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 35, right: 35),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  nameForm(),
                  const SizedBox(height: 15),
                  emailForm(),
                  const SizedBox(height: 15),
                  passwordForm(),
                  const SizedBox(height: 15),
                  regisWdg(context),
                  const SizedBox(height: 20),
                  googleSignin(),
                  const SizedBox(height: 40),
                  loginWdg(context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget googleSignin() {
    return SizedBox(
      width: 270,
      height: 50,
      child: GoogleAuthButton(
        onPressed: () {
          signInWithGoogle();
        },
      ),
    );
  }

  Widget loginWdg(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Do you have account ?',
          style: TextStyle(fontSize: 16),
        ),
        TextButton(
          onPressed: () {
            var route = MaterialPageRoute(
              builder: (context) => const LoginPage(),
            );
            Navigator.pop(context, route);
          },
          child: Text(
            'Login Now',
            style: GoogleFonts.mali(
              decoration: TextDecoration.underline,
              color: Color.fromARGB(255, 9, 229, 2),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget regisWdg(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 50,
          width: 270,
          child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 255, 255, 255)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              onPressed: () {
                registerWithEmail(_email.text, _password.text);
                addUser();
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    backgroundColor: Color.fromARGB(255, 213, 248, 219),
                    title: Text(
                      "Register Successfully ",
                      style: GoogleFonts.mali(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    content: Text("Go to the  Main Page"),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          var route = MaterialPageRoute(
                            builder: (context) => const ShowPage(),
                          );
                          Navigator.push(context, route);
                        },
                        child: Text(
                          "NEXT",
                          style: GoogleFonts.prompt(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 72, 37, 34)),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Register',
                    style: GoogleFonts.prompt(
                        fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: FaIcon(
                      FontAwesomeIcons.solidArrowAltCircleRight,
                      size: 40,
                      color: Color.fromARGB(255, 9, 255, 0),
                    ),
                  )
                ],
              )),
        )
      ],
    );
  }

  TextFormField passwordForm() {
    return TextFormField(
      controller: _password,
      style:
          const TextStyle(color: Color.fromARGB(255, 140, 2, 2), fontSize: 22),
      obscureText: true,
      decoration: InputDecoration(
        label: Text(
          'Password',
          style: TextStyle(fontSize: 20, color: Colors.grey.shade700),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 5, 0, 105),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  TextFormField emailForm() {
    return TextFormField(
      controller: _email,
      style:
          const TextStyle(color: Color.fromARGB(255, 140, 2, 2), fontSize: 22),
      decoration: InputDecoration(
        label: Text(
          'Email',
          style: TextStyle(fontSize: 20, color: Colors.grey.shade700),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 5, 0, 105),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  TextFormField nameForm() {
    return TextFormField(
      controller: _name,
      style:
          const TextStyle(color: Color.fromARGB(255, 140, 2, 2), fontSize: 22),
      decoration: InputDecoration(
        label: Text(
          'Your name',
          style: TextStyle(fontSize: 20, color: Colors.grey.shade700),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 5, 0, 105),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
