enum DeliveryMode {
  disabled(1),
  table(2),
  container(3);

  final int id;

  const DeliveryMode(this.id);
}
