import 'package:flutter/material.dart';
import 'package:im/shared/component/componant.dart';

class see extends StatefulWidget {
  @override
  _seeState createState() => _seeState();
}

class _seeState extends State<see> {
  var emailContent = TextEditingController();
  var passContent = TextEditingController();
  bool showPass = false;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('login page'),
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 40.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    defaultField(
                      Controller: emailContent,
                      type: TextInputType.emailAddress,
                      vale: (value) {
                        if (value!.isEmpty) {
                          return 'd5l elmail ysta';
                        }
                        return null;
                      },
                      lbName: 'email address',
                      pre: Icons.email,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    defaultField(
                        secure: showPass,
                        Controller: passContent,
                        type: TextInputType.visiblePassword,
                        vale: (value) {
                          if (value!.isEmpty) {
                            return 'ysta d5l elpass ysta !';
                          }
                          return null;
                        },
                        lbName: 'enter your password',
                        pre: Icons.lock,
                        f: () {
                          setState(() {
                            showPass = !showPass;
                          });
                        },
                        suf:
                            showPass ? Icons.visibility_off : Icons.visibility),
                    const SizedBox(
                      height: 15.0,
                    ),
                    defaultButton(
                        upperCase: true,
                        text: 'LOGIN',
                        color: Colors.red,
                        radius: 2.0,
                        function: () {
                          if (formKey.currentState!.validate()) {
                            print(emailContent.text);
                            print(passContent.text);
                          }
                        }),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      children: [
                        const Text('Don\'t have an account?'),
                        TextButton(
                            onPressed: () {},
                            child: const Text('Register Now')),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
