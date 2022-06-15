class AppointmentModel {
  final String customerId;
  final String barberId;
  final String startTime;
  final String endTime;
  final int seatNo;
  final String shopName;
  final String shopAddress;
  final String barberContact;
  final String appointmentStatus;

  const AppointmentModel({
    required this.shopName,
    required this.shopAddress,
    required this.barberContact,
    required this.customerId,
    required this.barberId,
    required this.startTime,
    required this.endTime,
    required this.seatNo,
    required this.appointmentStatus,
  });
}
