import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomsocialIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double size;
  final String imagePath;

  const CustomsocialIconButton({
    super.key,
    required this.onPressed,
    this.size = 52.0,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: 40.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white, // Background color of the container
        // borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ), // Border color
      ),
      child: TextButton(
        onPressed: onPressed, // Call the provided callback on press
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero, // Remove padding for a compact button
        ),
        child: Center(
          child: Image.asset(
            imagePath, // Path to your image asset
            width: size * 0.5, // Adjust width as needed
            height: size * 0.5, // Adjust height as needed
          ),
        ),
      ),
    );
  }
}
