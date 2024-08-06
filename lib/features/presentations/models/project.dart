class Project {
  final String picture;
  final String name;
  final String location;
  final int totalUsers;
  final int activeUsers;
  final int inactiveUsers;

  Project({
    required this.picture,
    required this.name,
    required this.location,
    required this.totalUsers,
    required this.activeUsers,
    required this.inactiveUsers,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      picture: json['picture'] ?? '',
      name: json['name'] ?? 'No Name',
      location: json['location'] ?? 'No Location',
      totalUsers: json['total_users'] ?? 0,
      activeUsers: json['active_users'] ?? 0,
      inactiveUsers: json['inactive_users'] ?? 0,
    );
  }
}
