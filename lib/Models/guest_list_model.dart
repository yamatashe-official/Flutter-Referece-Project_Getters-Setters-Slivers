import 'guest_model.dart';

class GuestListModel {
  List<GuestModel> allGuests;
  GuestListModel({required this.allGuests});

  /// This function is called whenever a checkbox for the user is selected.
  /// It updates the list of guests in attendance with the new value.
  /// This value is given based on the section that the user clicks on. This section is either the 'These Guests Have Reservations' or 'These Guests Do Not Have Reservations' section.
  /// Ideally this function should be placed in a separate file and use a package like provider to handle overall state management and pass in variables to
  set updateGuestList(List<GuestModel> guestList) {
    for (var element in guestList) {
      final index = allGuests.indexWhere((e) => e.id == element.id);
      allGuests[index] = element;
    }
  }

  /// This will only return the 'selected' users from the initial list.
  /// This can return an empty list.
  List<GuestModel> get onlySelectedGuests {
    return allGuests.where((element) => element.isSelected == true).toList();
  }

  ///Gets all the users that have reservations set to true.
  List<GuestModel> get getConfirmedReservations {
    return allGuests.where((element) => element.hasReservation == true).toList();
  }

  ///Gets all the users that have reservations set to false.
  List<GuestModel> get getDeniedReservations {
    return allGuests.where((element) => element.hasReservation == false).toList();
  }

  /// This is checking to see if the supplied users INDEED had a reservation. Will return [true] if they all have reservations
  /// If not then it will return [false]
  bool get errorsInReservations {
    return allGuests.indexWhere((element) => element.hasReservation == false) == -1;
  }

  ///checks to see if only guests without reservations are selected
  ///returns [false] if only guests who are checked and DO NOT have a reservation is selected
  ///return [true] for all other instances.
  bool get errorForOnlySelectedNonReservationGuests {
    Set checkers = {};
    for (var element in allGuests) {
      if (element.isSelected) {
        checkers.add(element.hasReservation);
      }
    }
    if (checkers.contains(false) && !checkers.contains(true)) {
      return false;
    } else {
      return true;
    }
  }
}
