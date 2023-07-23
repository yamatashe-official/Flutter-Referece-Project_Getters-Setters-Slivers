import 'package:flutter/material.dart';

class WarningNotifier extends StatelessWidget {
  const WarningNotifier({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: LayoutBuilder(
          builder: (context, constraints) => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.info,
                size: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SizedBox(
                  width: constraints.biggest.width * 0.9,
                  child: const Text(
                      'At least one Guest in the party must have a reservation. Guests without reservations must remain in the same booking party in order to enter.'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
