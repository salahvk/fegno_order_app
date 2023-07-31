List<Map<String, dynamic>> timeSlot = [
  {
    'timeslot': '9 am to 12 pm',
  },
  {
    'timeslot': '12 pm to 2 pm',
  },
  {
    'timeslot': '3 am to 6 pm',
  },
  {
    'timeslot': '6:30 pm to 12 am',
  },
  {
    'timeslot': '6 am to 8 am',
  },
];

class DummyTimeSlots {
  List<Map<String, dynamic>> getTimeSlots() {
    return timeSlot;
  }
}
