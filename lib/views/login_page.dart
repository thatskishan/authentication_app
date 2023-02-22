import 'package:authentication_app/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/my_utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? emailId;
  String? password;
  bool obscured = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  checkSignIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getBool(sfLogIn) ?? false) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }

  signIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(sfLogIn, true);

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkSignIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
          right: 8.0,
        ),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("Assets/Images/login.jpg"),
              const Text(
                "Login",
                style: TextStyle(
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                onSaved: (val) {
                  emailId = val!;
                },
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Please Enter Email Id";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: "Email Id",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
              const SizedBox(
                height: 8.0,
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
                height: 8.0,
              ),
              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Forget Password?",
                  style: TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              GestureDetector(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    signIn();
                    // setState(() {
                    //   Navigator.pushReplacementNamed(context, 'welcome');
                    // });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Login Successfully!!!"),
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
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 60,
                    width: 150,
                    decoration: const BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 20),
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
