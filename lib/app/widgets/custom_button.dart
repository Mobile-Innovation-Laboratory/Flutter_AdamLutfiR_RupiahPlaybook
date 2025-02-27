import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function() onTap;
  final double height;
  final double width;
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: width,
          vertical: height,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF00623B),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
