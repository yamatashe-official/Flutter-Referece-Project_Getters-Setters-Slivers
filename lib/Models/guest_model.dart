class GuestModel {
  String name, id;
  bool hasReservation, isSelected = false;

  GuestModel({
    required this.id,
    required this.name,
    required this.hasReservation,
    required this.isSelected,
  });

  ///Update the isSelected value of the guest model.
  set updateIsSelected(bool value) {
    isSelected = value;
  }

  ///Update the hasReservation value of the guest model.
  set updateReservation(bool value) {
    hasReservation = value;
  }

  /// get the current hasReservation status
  get reservationStatus {
    return hasReservation;
  }

  /// get the current isSelected status
  get isSelectedStatus {
    return isSelected;
  }
}
