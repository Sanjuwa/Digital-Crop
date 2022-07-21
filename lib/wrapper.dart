import 'package:digitalcrop/controller/user_controller.dart';
import 'package:digitalcrop/models/user_model.dart';
import 'package:digitalcrop/views/home.dart';
import 'package:digitalcrop/views/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var userController = Provider.of<UserController>(context);

    return FutureBuilder<User?>(
      future: userController.getCurrentUser(),
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }

        return snapshot.data == null ? Login() : Home();
      },
    );
  }
}
