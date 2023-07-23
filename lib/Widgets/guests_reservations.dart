import 'package:flutter/material.dart';
import '../Models/guest_model.dart';
import 'guest.dart';

class GuestsReservations extends StatelessWidget {
  const GuestsReservations({
    super.key,
    required this.guestListName,
    required this.guestsAvailable,
    this.guestListChanged,
  });

  final String guestListName;
  final List<GuestModel> guestsAvailable;
  final ValueChanged<List<GuestModel>>? guestListChanged;

  updateGuestList(GuestModel guestModel) {
    final index = guestsAvailable.indexWhere((element) => element.id == guestModel.id);
    guestsAvailable[index] = guestModel;
    guestListChanged?.call(guestsAvailable);
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 5, left: 20, right: 20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  guestListName,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              guestsAvailable.isEmpty
                  ? const Column(
                      children: [
                        SizedBox(height: 30),
                        Text('No Guests Available'),
                      ],
                    )
                  : Column(
                      children: guestsAvailable
                          .map((e) => Guest(
                              guestModel: e,
                              guestSelectionChanged: (returnedGuest) {
                                updateGuestList(returnedGuest);
                              }))
                          .toList(),
                    ),
            ],
          ),
        ),
        childCount: 1,
      ),
    );
  }
}
