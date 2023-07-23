import 'package:flutter/material.dart';

class GuestErrorWarning extends StatelessWidget {
  const GuestErrorWarning({super.key, required this.onTap});

  final ValueChanged onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.onBackground,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Reservation Needed",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.background,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    "Select at least one Guest that has a reservation to continue.",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.background,
                    ),
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                onTap(false);
              },
              icon: const Icon(Icons.cancel),
              color: Theme.of(context).colorScheme.background,
            )
          ],
        ),
      ),
    );
  }
}
