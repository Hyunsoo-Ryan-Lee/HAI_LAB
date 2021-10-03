import 'package:flutter/material.dart';

class Ex_2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Exercise_2(),
        ),
      ),
    );
  }
}

class Exercise_2 extends StatefulWidget {
  @override
  _Exercise_2State createState() => _Exercise_2State();
}

class _Exercise_2State extends State<Exercise_2> {
  TextEditingController _passwordController;

  bool isPasswordValid = false;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _validatePassword() {
    setState(() {
      if (_passwordController.text.length < 1) {
        isPasswordValid = false;
      } else {
        isPasswordValid = true;
      }
    });
  }

  UnderlineInputBorder borderMaker(Color color) {
    return UnderlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(4),
      ),
      borderSide: BorderSide(
        width: 2,
        color: color,
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return TextField(
      controller: _passwordController,
      onChanged: (_) {
        _validatePassword();
      },
      onSubmitted: (String value) {
        print("password: $value");
        _validatePassword();
      },
      decoration: InputDecoration(
          border: borderMaker(Colors.black),
          errorBorder: borderMaker(Colors.red),
          errorText: isPasswordValid ? null : "횟수를 입력해주세요"),
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.only(top: 110),
          child: Column(
            children: [
              Expanded(
                child: Column(children: [
                  Container(
                    height: size.height * 0.2,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/icons/pushup.png'),
                            fit: BoxFit.contain)),
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 0, right: 0),
                        child: SizedBox(
                          width: size.width * 0.35,
                          child: _buildPasswordTextField(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          '회',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  OutlinedButton(
                      onPressed: () {},
                      child: Text(
                        'START  >',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      style: OutlinedButton.styleFrom(
                        fixedSize: Size(120, 15),
                        primary: Colors.black,
                        side: BorderSide(width: 1, color: Colors.black),
                      ))
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
