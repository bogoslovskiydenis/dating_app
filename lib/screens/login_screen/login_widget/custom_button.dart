import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key, required this.tabController, this.text = 'Start',
        this.emailController, this.passwordController})
      : super(key: key);
  final TabController tabController;
  final String text;
  final TextEditingController? emailController;
  final TextEditingController? passwordController;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: const LinearGradient(
          colors: [Colors.red, Colors.blue],
        ),
      ),
      child: ElevatedButton(
        style:
            ElevatedButton.styleFrom(elevation: 0, primary: Colors.transparent),
        onPressed: () async{
          if(emailController !=null && passwordController !=null){
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: emailController!.text,
                password: passwordController!.text)
                .then((value)=> print("User Created"))
                .catchError((error) => print("Error"));
          }
          tabController.animateTo(tabController.index + 1);
        },
        child: SizedBox(
          width: double.infinity,
          child: Center(child: Text(text)),
        ),
      ),
    );
  }
}
