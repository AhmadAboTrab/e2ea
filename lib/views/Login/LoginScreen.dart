import 'package:e2ea/HelpedClassesForCreateTables/addMed.dart';

import '../../Controller/Api/Search/EmployeeSearch/EmployeeSearchByEmail.dart';

import '../../models/employee.dart';

import '../../Widgets/widgets.dart';
import '../../views/MainHome/MainScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email, password;

  //String email, password;
  //AccountsOp accountsOp;
  String result = "";
  MediaQueryData mediaQuery;
  bool show = true;
  final auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    super.initState();
    //accountsOp = AccountsOp();
  }

  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBarPharmacy(
        title: "Pharmacy",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            child: Container(
              height: 600,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: mediaQuery.size.height * 0.001,
                      ),
                      Container(
                          child: new Image.asset("assets/images/gr1.jpg")),
                      SizedBox(
                        height: mediaQuery.size.height * 0.07,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: email,
                        validator: (value) => value.isNotEmpty
                            ? null
                            : "Please Enter a email address",
                        decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(Icons.mail),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: mediaQuery.size.height * 0.04,
                      ),
                      TextFormField(
                        controller: password,
                        validator: (value) => value.length < 6
                            ? "less than 6 character should be more than 8"
                            : null,
                        obscureText: show,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "password",
                          prefixIcon: IconButton(
                            icon: show
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                            onPressed: () {
                              setState(() {
                                show = !show;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: mediaQuery.size.height * 0.05,
                      ),
                      MaterialButton(
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddMed()));
                          // if (formKey.currentState.validate()) {
                          //   print(email.text + " " + password.text);
                          //   try {
                          //     await auth.signInWithEmailAndPassword(
                          //         email: email.text, password: password.text);

                          //     result = 'correct';
                          //   } on FirebaseAuthException catch (exception) {
                          //     // print(exception.code);
                          //     switch (exception.code) {
                          //       case 'user-not-found':
                          //         {
                          //           result = 'user-not-found';
                          //           break;
                          //         }
                          //       case 'wrong-password':
                          //         {
                          //           result = 'wrong-password';
                          //           break;
                          //         }
                          //       case 'network-request-failed':
                          //         {
                          //           result = 'network-request-failed';
                          //           break;
                          //         }
                          //       default:
                          //         {
                          //           result = 'undefined';
                          //           break;
                          //         }
                          //     }
                          //   }
                          // } //if validation email and password
                          // if (result == 'correct') {
                          //   List temp = await EmployeeSearchByEmail()
                          //       .getUserSugesstions(email.text);
                          //   if (temp == null) {
                          //     showDialog(
                          //         context: context,
                          //         builder: (context) => AlertDialog(
                          //               title: Text('Warning'),
                          //               content:
                          //                   Text('this employee is not there '),
                          //               actions: [
                          //                 MaterialButton(
                          //                   onPressed: () {
                          //                     Navigator.pop(context);
                          //                   },
                          //                   child: Text('okay'),
                          //                 )
                          //               ],
                          //             ));
                          //   }
                          //   Employee employee = temp[0];

                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => MainScreen(
                          //         employee: employee,
                          //       ),
                          //     ),
                          //   );
                          // } else {
                          //   showDialog(
                          //     context: context,
                          //     builder: (context) => AlertDialog(
                          //       content: Text(result),
                          //       actions: [
                          //         // ignore: deprecated_member_use
                          //         RaisedButton(
                          //           onPressed: () {
                          //             Navigator.of(context).pop(false);
                          //           },
                          //           child: Text("close"),
                          //         )
                          //       ],
                          //     ),
                          //   ); //show dialog function
                          // }
                        },
                        height: mediaQuery.size.height * 0.08,
                        minWidth: double.infinity,
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// SizedBox(
//   height: mediaQuery.size.height * 0.05,
// ),
// MaterialButton(
//   onPressed: () {
//     if (formKey.currentState.validate()) {
//       print(cemail.text + " " + cpassword.text);
//       Future<String> t = accountsOp.addEmployeeProc(
//           cemail.text,
//           cpassword.text,
//           'Ahmad',
//           '0988888888',
//           10,
//           35.2);
//       if (t == null) {
//         print("ya 7ra is null\n");
//       } else {
//         //String s = t.toString();
//         print(t);
//       }

//       //accountsOp.signIn(cemail, password)
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => MainScreen(),
//         ),
//       );
//       // var email = cemail.text.toString();
//       // var password = cpassword.text.toString();

//       /*try {
//       auth.signInWithEmailAndPassword(
//           email: email, password: password);
//     } catch (e) {
//       setState(() {
//         x = "rooror";
//       });
//     }*/
//     }
//   },
//   height: mediaQuery.size.height * 0.08,
//   minWidth: double.infinity,
//   color: Theme.of(context).primaryColor,
//   textColor: Colors.white,
//   shape: RoundedRectangleBorder(
//     borderRadius: BorderRadius.circular(20),
//   ),
//   child: Text(
//     "sign up",
//     style: TextStyle(
//       fontSize: 20,
//       fontWeight: FontWeight.bold,
//     ),
//   ),
// ),
// SizedBox(
//   height: mediaQuery.size.height * 0.05,
// ),
// MaterialButton(
//   onPressed: () {
//     if (formKey.currentState.validate()) {
//       print(cemail.text + " " + cpassword.text);
//       accountsOp.logoutproc();

//       //accountsOp.signIn(cemail, password)
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => MainScreen(),
//         ),
//       );
//       // var email = cemail.text.toString();
//       // var password = cpassword.text.toString();

//       /*try {
//       auth.signInWithEmailAndPassword(
//           email: email, password: password);
//     } catch (e) {
//       setState(() {
//         x = "rooror";
//       });
//     }*/
//     }
//   },
//   height: mediaQuery.size.height * 0.08,
//   minWidth: double.infinity,
//   color: Theme.of(context).primaryColor,
//   textColor: Colors.white,
//   shape: RoundedRectangleBorder(
//     borderRadius: BorderRadius.circular(20),
//   ),
//   child: Text(
//     "sign out",
//     style: TextStyle(
//       fontSize: 20,
//       fontWeight: FontWeight.bold,
//     ),
//   ),
// ),
