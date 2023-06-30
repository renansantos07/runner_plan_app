class SessionUser {
  final String id;
  final String name;
  final String email;
  final String imageURL;

  const SessionUser({
    required this.id,
    required this.name,
    required this.email,
    this.imageURL = "assets/images/avatar.png",
  });
}
