import 'package:authentication_app/utils/my_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  checkSignIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getBool(sfSignUp) ?? false) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginPage()));
    }
  }

  signUp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(sfSignUp, true);
    prefs.setString(sfUserName, userName);

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkSignIn();
  }

  String userName = "Hello User";
  String email = "noemail@gmail.com";
  String name = "No Name";
  String password = "0000";

  bool obscured = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 250,
                      width: double.infinity,
                      child: Image.asset(
                        "Assets/Images/register.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Signup",
                      style: GoogleFonts.openSans(
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                          color: Colors.indigo),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      onSaved: (val) {
                        userName = val!;
                      },
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please Enter User Name";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "User Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        prefixIcon: const Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onSaved: (val) {
                        email = val!;
                      },
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please Enter Email-Id!";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Email Id",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        prefixIcon: const Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onSaved: (val) {
                        name = val!;
                      },
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please Enter Full Name";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Full Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        prefixIcon: const Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onSaved: (val) {
                        password = val!;
                      },
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please Enter Password";
                        } else {
                          return null;
                        }
                      },
                      obscureText: obscured,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscured = !obscured;
                            });
                          },
                          icon: Icon(
                            obscured ? Icons.visibility : Icons.visibility_off,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        // onTap: signUp,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            signUp();
                            // setState(() {
                            //   Navigator.pushReplacementNamed(context, 'welcome');
                            // });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Sign Up Successfully!!!"),
                                backgroundColor: Colors.green,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please Enter Valid Details!!!"),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 150,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                            color: Colors.indigo,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Signup",
                            style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
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
    );
  }
}
