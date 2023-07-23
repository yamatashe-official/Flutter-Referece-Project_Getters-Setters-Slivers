import 'package:flutter/material.dart';
import '../Models/guest_model.dart';

class Guest extends StatefulWidget {
  const Guest({
    super.key,
    required this.guestModel,
    required this.guestSelectionChanged,
  });

  final GuestModel guestModel;
  final ValueChanged<GuestModel> guestSelectionChanged;

  @override
  State<Guest> createState() => _GuestState();
}

class _GuestState extends State<Guest> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() => widget.guestModel.updateIsSelected = !widget.guestModel.isSelected);
        widget.guestSelectionChanged(widget.guestModel);
      },
      child: SizedBox(
        child: Row(
          children: [
            Checkbox(
              visualDensity: VisualDensity.compact,
              value: widget.guestModel.isSelected,
              side: const BorderSide(width: 0.5),
              activeColor: Colors.green[700],
              onChanged: (val) {
                setState(() => widget.guestModel.updateIsSelected = val!);
                widget.guestSelectionChanged(widget.guestModel);
              },
            ),
            Text(widget.guestModel.name, style: const TextStyle(fontSize: 16))
          ],
        ),
      ),
    );
  }
}
