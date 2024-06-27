import 'package:flutter/material.dart';

class RotaPagina extends StatelessWidget {

  final WidgetBuilder builder;

  RotaPagina({
   required this.builder
});

  void _navigate(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const builder),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
        onPressed: () => _navigate(context),
        child: Text(''),
    );
  }
}
