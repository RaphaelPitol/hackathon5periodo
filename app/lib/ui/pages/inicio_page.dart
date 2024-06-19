import 'package:app_flutter/ui/pages/home_page.dart';
import 'package:app_flutter/ui/pages/login_page.dart';
import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {

  @override
  void initState() {
    super.initState();
    verificarToken().then((value) {
      if(value) {
        Navigator.pushReplacement(context, 
        MaterialPageRoute(builder: (context) => HomePage(),
        ),
        );
      }else {

        Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => LoginPage(),
          ),
        );
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),

    );
  }

  Future<bool> verificarToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString('token') != null) {
      return true;
    } else {
      return false;
    }
  }
}
