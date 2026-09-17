abstract final class ApiEndpoints {
  static const register = '/auth/register';
  static const login = '/auth/login';
  static const profile = '/profile';
  static const therapistBookings = '/bookings/therapist';
  static String bookingStatus(int bookingId) => '/bookings/$bookingId/status';
  static String bookingReschedule(int bookingId) =>
      '/bookings/$bookingId/reschedule';
  static String bookingNotes(int bookingId) => '/bookings/$bookingId/notes';
  static const availability = '/schedule/availability';
  static const schedule = '/schedule';
  static const scheduleSlots = '/schedule/slots';
  static const patients = '/patients';
  static String patient(int patientId) => '/patients/$patientId';
  static String patientNotes(int patientId) => '/patients/$patientId/notes';
  static String patientNote(int patientId, int noteId) =>
      '/patients/$patientId/notes/$noteId';
  static const availableTherapists = '/bookings/available-therapists';
  static String availableTherapistSlots(int therapistId) =>
      '/bookings/therapists/$therapistId/available-slots';
  static const createBooking = '/bookings';
}
