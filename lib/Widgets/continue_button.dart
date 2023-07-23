import 'package:flutter/material.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({
    super.key,
    this.onCall,
    required this.greyOut,
  });

  final Function? onCall;
  final bool greyOut;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: GestureDetector(
        onTap: () {
          if (!greyOut) {
            onCall?.call();
          }
        },
        child: Opacity(
          opacity: greyOut ? 0.3 : 1,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Center(
              child: Text("Continue", style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ),
    );
  }
}
