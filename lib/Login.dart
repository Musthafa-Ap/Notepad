
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/routes.dart';
class Login extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20,right: 20),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'email',
              ),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'password',
              ),
            ),
            SizedBox(height: 20,),
            FlatButton(
              padding: EdgeInsets.symmetric(horizontal: 50,vertical: 13),
              shape: StadiumBorder(),
              child: Text("Login"),
              onPressed: ()async{
                try{
                  User user= (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text)) as User;
                  if(user != null){
                    Navigator.of(context).pushNamed(AppRoutes.menu);
                  }
                }catch(e){
                  print(e);
                  _emailController.text="";
                  _passwordController.text="";
                }

              },
              color: Colors.green,
            ),
          ],),
        ),
      ),
    );
  }
}
