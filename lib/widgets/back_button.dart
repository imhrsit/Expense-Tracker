import 'package:flutter/material.dart';
import '../constants.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 15,
      left: 15,
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              const BoxShadow(
                  color: Colors.black26, blurRadius: 4, offset: Offset(0, 1))
            ],
          ),
          child: Center(
            child: Icon(Icons.arrow_back,
                color: Theme.of(context).textTheme.titleLarge!.color,
                size: 28),
          ),
        ),
      ),
    );
  }
}
