class Project {
  final String pictureUrl;
  final String name;
  final String location;
  final int totalUser;
  final int activeUser;
  final int inactiveUser;

  Project({
    required this.pictureUrl,
    required this.name,
    required this.location,
    required this.totalUser,
    required this.activeUser,
    required this.inactiveUser,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      pictureUrl: json['picture_url'] ?? '',
      name: json['name'] ?? 'No Name',
      location: json['location'] ?? 'No Location',
      totalUser: json['total_user'] ?? 0,
      activeUser: json['active_user'] ?? 0,
      inactiveUser: json['inactive_user'] ?? 0,
    );
  }
}
