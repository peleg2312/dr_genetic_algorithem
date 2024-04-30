import 'package:dr_app/provider/auth_provider.dart';
import 'package:dr_app/screen/admin_home_page.dart';
import 'package:dr_app/screen/client_home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class userType extends StatefulWidget {
  const userType({super.key});

  @override
  State<userType> createState() => _userTypeState();
}

class _userTypeState extends State<userType> {

  @override
  void initState(){
    super.initState();
    try {
      Provider.of<AuthProviderApp>(context, listen: false).fetchUserData(context);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if(Provider.of<AuthProviderApp>(context, listen: true).isAdmin == true){
                        return AdminMainPage();
                      }else{
                        return ClientMainPage();
                      }
  }
}