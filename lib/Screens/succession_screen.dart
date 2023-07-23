import 'package:flutter/material.dart';
import '../Models/guest_list_model.dart';

class SuccessionScreen extends StatefulWidget {
  const SuccessionScreen({super.key});

  static const routeName = "/successionScreen";

  @override
  State<SuccessionScreen> createState() => _SuccessionScreenState();
}

class _SuccessionScreenState extends State<SuccessionScreen> {
  /// This is passing the all guests list into this page. This is not ideal.
  /// Ideally you would be using a state management package and accessing state variables and overall variables like that
  /// For now since no external packages are allowed, this is how you will transfer information between pages.
  GuestListModel allGuestsInAttendance = GuestListModel(allGuests: []);

  /// I need to invoke the init state in order to get access to the page arguments.
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ///This is getting the arguments parameter from the previous page and assigning it to the location variable that
      ///this page holds.
      setState(() => allGuestsInAttendance = ModalRoute.of(context)!.settings.arguments as GuestListModel);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(allGuestsInAttendance.errorsInReservations ? "Success!" : "Error!"),
      ),
      body: Center(
        child: Text(allGuestsInAttendance.errorsInReservations ? "All selected users had reservations." : "Some users DID NOT have reservations."),
      ),
    );
  }
}
