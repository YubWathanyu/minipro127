import 'package:auth_buttons/auth_buttons.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/auth_service.dart';
import 'regis.dart';
import 'show.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/backlog.jpg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            logopic(),
            formfield(context),
          ],
        ),
      ),
    );
  }

  Widget logopic() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            const SizedBox(height: 20),
            Image.asset(
              'images/logo.png',
              fit: BoxFit.contain,
              height: 400,
              width: 350,
            ),
          ],
        ),
      ],
    );
  }

  SingleChildScrollView formfield(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 330),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 35, right: 35),
              child: Column(
                children: [
                  emailForm(),
                  const SizedBox(height: 30),
                  passwordForm(),
                  const SizedBox(height: 40),
                  loginWdg(context),
                  const SizedBox(height: 40),
                  regisWdg(context)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget regisWdg(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Don't have account yet?",
          style: TextStyle(fontSize: 14),
        ),
        TextButton(
          onPressed: () {
            var route = MaterialPageRoute(
              builder: (context) => const RegisterPage(),
            );
            Navigator.push(context, route);
          },
          child: Text(
            'Register Now',
            style: GoogleFonts.prompt(
              decoration: TextDecoration.underline,
              color: Color.fromARGB(255, 37, 184, 0),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget loginWdg(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 50,
          width: 170,
          child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 251, 220, 183)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              onPressed: () {
                siginWithEmail(_email.text, _password.text);
                var route = MaterialPageRoute(
                  builder: (context) => const ShowPage(),
                );
                Navigator.push(context, route);
              },
              child: Row(
                children: [
                  Text(
                    'Login',
                    style: GoogleFonts.prompt(
                        fontSize: 30, fontWeight: FontWeight.w700),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: FaIcon(
                      FontAwesomeIcons.solidArrowAltCircleRight,
                      size: 40,
                      color: Color.fromARGB(255, 245, 21, 5),
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
      style: const TextStyle(),
      obscureText: true,
      decoration: InputDecoration(
        label: const Text(
          'Password',
          style: TextStyle(fontSize: 20),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  TextFormField emailForm() {
    return TextFormField(
      controller: _email,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        label: const Text(
          'Email',
          style: TextStyle(fontSize: 20),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
