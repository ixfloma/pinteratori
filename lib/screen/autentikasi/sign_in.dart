import 'package:flutter/material.dart';
import 'package:pinteratori/screen/service/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 100,
                        child: Image.asset('assets/image/logoupn.png'),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'P I N T E R A T O R I',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.w200
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              // Column(
              //   children: <Widget>[
              //     Container(
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: <Widget>[
              //           Container(
              //             height: 50,
              //             width: screenWidth * 0.8,
              //             decoration: BoxDecoration(
              //               color: Colors.white,
              //               border: Border.all(width: 1, color: Colors.cyan),
              //             ),
              //             child: Padding(
              //               padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              //             ),
              //           )
              //         ],
              //       ),
              //     ),
              //     Container(
              //       margin: EdgeInsets.only(top: 15),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: <Widget>[
              //           Container(
              //             height: 50,
              //             width: screenWidth * 0.8,
              //             decoration: BoxDecoration(
              //               color: Colors.white,
              //               border: Border.all(width: 1, color: Colors.cyan),
              //             ),
              //             child: Padding(
              //               padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              //             ),
              //           )
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              Container(
                height: 50,
                width: screenWidth * 0.8,
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  shape: BoxShape.rectangle,
                ),
                child: FlatButton(
                  onPressed: () async {
                    dynamic result = await _auth.signInWithGoogle();
                    if(result == null){
                      print('gagal');
                    } else {
                      print(result.uid);
                    }
                  },
                  child: Center(
                    child: Text(
                      'Masuk Menggunakan Google',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w300
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
