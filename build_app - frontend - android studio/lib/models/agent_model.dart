class Agent {
  String id;
  String name;
  String contact;
  List<String> assignedProperties;

  Agent({
    required this.id,
    required this.name,
    required this.contact,
    required this.assignedProperties,
  });

  factory Agent.fromJson(Map<String, dynamic> json) => Agent(
    id: json['_id'],
    name: json['name'],
    contact: json['contact'],
    assignedProperties: List<String>.from(json['assignedProperties']),
  );
}
