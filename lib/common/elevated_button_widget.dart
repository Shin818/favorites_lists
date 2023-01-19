import 'package:flutter/material.dart';

import 'constants.dart';

class AddDataButton extends StatelessWidget {
  AddDataButton({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  Widget? child;
  Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed!,
      style: ElevatedButton.styleFrom(
        backgroundColor: kButtonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: child!,
      ),
    );
  }
}

class DeleteDataButton extends StatelessWidget {
  DeleteDataButton({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  Widget? child;
  Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed!,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: child!,
      ),
    );
  }
}
