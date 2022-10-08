import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/view/components/toast_message.dart';
import 'package:todo_app/view/screens/Tasks/tasksScreen.dart';
import 'package:todo_app/view_model/network/dioHelper.dart';
import 'package:todo_app/view_model/network/endPoints.dart';

import '../../../view_model/constant.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Text(
                    'Login Page',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please, Enter your Email';
                      }else if(value.contains('@gmail.com')){
                        return 'PLease, Enter a Valid Email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please, Enter your Password';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        print('Go Login');
                        DioHelper.postData(endPoint: login, query: {
                          'email' : emailController.text,
                          'password' : passwordController.text,
                        }).then((value){
                          // print(value.data);
                          token = value.data['authorisation']['token'];
                          showToast(message: 'Login Successfully');
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>TasksScreen()));
                          print(token);
                        }).catchError((error){
                          print('Login Error Here ${error.response.data}');
                          showToast(message: error.response.data['message']);
                        });
                      }
                    },
                    child: Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
