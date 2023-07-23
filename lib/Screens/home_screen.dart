import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../Models/guest_list_model.dart';
import '../Models/guest_model.dart';
import '../Widgets/continue_button.dart';
import '../Widgets/guest_error_warning.dart';
import '../Widgets/guests_reservations.dart';
import '../Widgets/warning_notifier.dart';
import 'succession_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ///MODIFY THIS LIST BELOW - FOLLOW THE CONVENTION AS STATED IN ORDER TO SEE HOW THE LIST IS IMPACTED.
  ///
  /// This is the list of all the guests in attendance.
  /// This is a simulated list. It uses a 'GuestModel' that requires the following: id, name, hasReservation, isSelected.
  ///
  /// GuestModel [id] = This is a unique identifier that should NOT be repeated in the list. This is a 'STRING' value.
  /// GuestModel [name] = This is the name of the guest. This is a 'STRING' value.
  /// GuestModel [hasReservation] = This is a boolean value that determines if the guest has a reservation or not. Set this to true if you want the user to appear in the 'has reservations' section. Set this to false if you want the user to appear in the 'no reservations' section.
  /// GuestModel [isSelected] = This is a boolean value that determines if the guest is selected or not. This is mainly used for the checkbox on each guest.
  ///
  /// This list is hard coded for the time being, however it should be replaced with a call to an API to get the current guest list. It should also run through some state management package like provider in order to make sure it is accessible throughout the application.
  /// This variable will get overwritten by the 'createRandomGuests' function.
  GuestListModel allGuestsInAttendance = GuestListModel(allGuests: []);

  /// This is a scroll controller. This will be attached to the 'SingleChildScrollView' widget on the HomeScreen.
  /// The purpose of this widget is to get access to scroll details from the 'SingleChildScrollView' widget and to change the app bar state based on scroll position
  ScrollController scrollController = ScrollController();

  ///This is a temporary threshold value. This is used to determine when the app bar should change state.
  int offsetValueThreshold = 40;

  /// This is a key that will be attached to the 'Guests without reservations' part of the screen.
  /// This will mainly be used in order to switch the app bar title when the user scrolls to this part of the screen and the title is not on screen.
  GlobalKey neededReservationsKey = GlobalKey();

  ///This is a simple bool to change the bottom button.
  ///This will convert the bottom button into a static and persistent 'modal.'
  ///Once the modal is tapped, it will reset this value.
  ///[true] means that it will show the bottom modal.
  ///[false] means it will not show the bottom modal.
  bool showErrorModal = false;

  ///check to see if the scroll controller y position is past the threshold value.
  /// returns [true] if it is past the threshold value.
  /// returns [false] if it is not past the threshold value.
  bool get isPastThreshold {
    return scrollController.hasClients && scrollController.offset > offsetValueThreshold;
  }

  ///This simply determine if the part of the slivers list that holds the 'guests with reservations' has left viewport.
  ///It checks to see if the overall scrollController offset / guest confirmation list is greater than 50. This represent the 'middle' of the list. once the middle has passed then the title for the app bar will switch.
  bool get switchSliverTitle {
    RenderSliverList v = findRenderSliverList(key: neededReservationsKey);
    return v.constraints.overlap > 50;
  }

  ///sets the [showErrorModal] value
  ///can be set either to [true] or [false]
  set updateErrorModal(bool errorValue) {
    setState(() => showErrorModal = errorValue);
  }

  /// This is used to simply get access to information supplied by the KEY.
  /// This key is attached to the [GuestReservation] widget that displayed guests that need a reservation
  RenderSliverList findRenderSliverList({required GlobalKey key}) {
    return key.currentContext!.findRenderObject() as RenderSliverList;
  }

  /// This is used to set the value of the GuestListModel.
  /// Mainly this will be used to update either the final list or set the list to some alternative guest list.
  /// It should follow the input convention to create a GuestListModel.
  /// For now this is used just for testing to assign a random amount of guests to the overall GuestListModel.
  set guestsToShow(GuestListModel guestListModel) {
    allGuestsInAttendance = guestListModel;
  }

  /// THIS IS A TESTER FUNCTION
  /// This function is used ONLY for testing purposes.
  /// The purpose of this function is to render any number of guests.
  /// The function will randomly assign the guest either to the reservation confirmed list or the reservation unconfirmed list.
  /// [numberToCreate] is an int. It can take any INT value.
  GuestListModel createRandomGuests({required int numberToCreate}) {
    List<GuestModel> guests = [];
    for (int i = 0; i < numberToCreate; i++) {
      guests.add(GuestModel(id: i.toString(), name: "Random Guest $i", hasReservation: Random().nextBool(), isSelected: false));
    }
    return GuestListModel(allGuests: guests);
  }

  ///I need access to the init state because I want to attach a listener to the scroll controller.
  ///This listener is mainly used to call 'set state' whenever the user scrolls.
  ///This is to update the app bar to a 'scrolled' position.
  @override
  void initState() {
    /// Here I will create a simple test function that randomly assigns a number of guests to either reservations or no reservations class;
    /// Supply the [numberToCreate] value to create a random number of guests. This NEEDS to be an INT and be whatever number you want.
    guestsToShow = createRandomGuests(numberToCreate: 100);
    scrollController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        height: showErrorModal ? 90 : 70,
        padding: const EdgeInsets.all(0),
        surfaceTintColor: Colors.transparent,
        child: showErrorModal
            ? GuestErrorWarning(
                onTap: (value) => setState(() => updateErrorModal = value),
              )
            : ContinueButton(
                greyOut: allGuestsInAttendance.onlySelectedGuests.isEmpty,
                onCall: () {
                  if (!allGuestsInAttendance.errorForOnlySelectedNonReservationGuests) {
                    updateErrorModal = true;
                    return;
                  }
                  Navigator.pushNamed(context, SuccessionScreen.routeName, arguments: GuestListModel(allGuests: allGuestsInAttendance.onlySelectedGuests));
                }),
        // child: GuestErrorWarning(),
      ),
      body: CustomScrollView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        semanticChildCount: 3,
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            toolbarHeight: 55,
            scrolledUnderElevation: isPastThreshold ? 5 : 1,
            shadowColor: Colors.black,
            surfaceTintColor: Theme.of(context).colorScheme.background,
            forceElevated: true,
            leading: isPastThreshold
                ? null
                : IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: !isPastThreshold,
              titlePadding: EdgeInsets.only(left: isPastThreshold ? 20 : 0, bottom: 20),
              title: Text(
                isPastThreshold
                    ? switchSliverTitle
                        ? "These Guests Need Reservations"
                        : 'These Guests Have Reservations'
                    : "Select Guests",
                // "Select Guests",
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
          GuestsReservations(
            guestListName: "These Guests Have Reservations",
            guestsAvailable: allGuestsInAttendance.getConfirmedReservations,
            guestListChanged: (value) => setState(() => allGuestsInAttendance.updateGuestList = value),
          ),

          GuestsReservations(
            key: neededReservationsKey,
            guestListName: "These Guests Need Reservations",
            guestsAvailable: allGuestsInAttendance.getDeniedReservations,
            guestListChanged: (value) {
              setState(() => allGuestsInAttendance.updateGuestList = value);
            },
          ),
          // SliverList(
          const WarningNotifier(),
          const SliverToBoxAdapter(child: SizedBox(height: 80))
        ],
      ),
    );
  }
}
