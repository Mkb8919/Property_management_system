import 'package:flutter/material.dart';
import '../models/agent_model.dart';
import '../services/api_service.dart';

class AgentScreen extends StatefulWidget {
  @override
  _AgentScreenState createState() => _AgentScreenState();
}

class _AgentScreenState extends State<AgentScreen> {
  late Future<List<Agent>> _futureAgents;

  @override
  void initState() {
    super.initState();
    _futureAgents = ApiService.getAgents();
  }

  void _showAddAgentDialog() {
    final _nameController = TextEditingController();
    final _contactController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Add Agent"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: _nameController, decoration: InputDecoration(labelText: "Name")),
            TextField(controller: _contactController, decoration: InputDecoration(labelText: "Contact")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          ElevatedButton(
            child: Text("Add"),
            onPressed: () async {
              await ApiService.addAgent({
                "name": _nameController.text,
                "contact": _contactController.text,
                "assignedProperties": []
              });
              Navigator.pop(context);
              setState(() {
                _futureAgents = ApiService.getAgents();
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Agents")),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _showAddAgentDialog,
      ),
      body: FutureBuilder<List<Agent>>(
        future: _futureAgents,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          List<Agent> agents = snapshot.data!;
          if (agents.isEmpty) return Center(child: Text("No agents found"));
          return ListView.builder(
            itemCount: agents.length,
            itemBuilder: (context, index) {
              Agent a = agents[index];
              return Card(
                child: ListTile(
                  title: Text(a.name),
                  subtitle: Text("Contact: ${a.contact}"),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      await ApiService.deleteAgent(a.id);
                      setState(() {
                        _futureAgents = ApiService.getAgents();
                      });
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
