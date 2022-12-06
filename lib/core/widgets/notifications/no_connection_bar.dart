import 'package:flutter/material.dart';

class noConnectionBar extends StatelessWidget {
  const noConnectionBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Container(
        width: double.maxFinite,
        height: 40,
        color: Colors.black54,
        child: const Center(
          child: Text(
            'No internet connection, you are now in offline mode.',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
