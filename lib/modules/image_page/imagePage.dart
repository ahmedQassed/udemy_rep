import 'package:flutter/material.dart';

class imagee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('image'),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(50.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(80.0),
                        bottomEnd: Radius.circular(80.0))),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image.asset(
                      'ahmed/s.jpg',
                      width: 300.0,
                      height: 300.0,
                      fit: BoxFit.cover,
                    ),
                    Container(
                        width: 300.0,
                        color: Colors.green.withOpacity(0.3),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: Text(
                            'ahmed',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
