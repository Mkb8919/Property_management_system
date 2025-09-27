import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/property_model.dart';
import '../services/api_service.dart';

class PropertyScreen extends StatefulWidget {
  @override
  _PropertyScreenState createState() => _PropertyScreenState();
}

class _PropertyScreenState extends State<PropertyScreen> {
  late Future<List<Property>> _futureProperties;
  final ImagePicker _picker = ImagePicker();
  List<XFile> _images = [];

  @override
  void initState() {
    super.initState();
    _futureProperties = ApiService.getProperties();
  }

  Future<void> pickImages() async {
    final List<XFile>? picked = await _picker.pickMultiImage();
    if (picked != null) {
      setState(() {
        _images = picked;
      });
    }
  }

  void _showAddPropertyDialog() {
    final _titleController = TextEditingController();
    final _descController = TextEditingController();
    final _addressController = TextEditingController();
    final _priceController = TextEditingController();
    String type = "apartment";
    String status = "available";

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Add Property"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: _titleController, decoration: InputDecoration(labelText: "Title")),
              TextField(controller: _descController, decoration: InputDecoration(labelText: "Description")),
              TextField(controller: _addressController, decoration: InputDecoration(labelText: "Address")),
              TextField(controller: _priceController, decoration: InputDecoration(labelText: "Price"), keyboardType: TextInputType.number),
              DropdownButton<String>(
                value: type,
                items: ["apartment", "villa", "plot"].map((e) => DropdownMenuItem(child: Text(e), value: e)).toList(),
                onChanged: (val) { type = val!; },
              ),
              DropdownButton<String>(
                value: status,
                items: ["available", "sold"].map((e) => DropdownMenuItem(child: Text(e), value: e)).toList(),
                onChanged: (val) { status = val!; },
              ),
              ElevatedButton(
                child: Text("Pick Images"),
                onPressed: pickImages,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(child: Text("Cancel"), onPressed: () => Navigator.pop(context)),
          ElevatedButton(
            child: Text("Add"),
            onPressed: () async {
              List<String> imagePaths = _images.map((e) => e.path).toList();
              await ApiService.addProperty({
                "title": _titleController.text,
                "description": _descController.text,
                "address": _addressController.text,
                "price": double.parse(_priceController.text),
                "type": type,
                "status": status,
                "images": imagePaths
              });
              Navigator.pop(context);
              setState(() {
                _futureProperties = ApiService.getProperties();
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
      appBar: AppBar(title: Text("Properties")),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _showAddPropertyDialog,
      ),
      body: FutureBuilder<List<Property>>(
        future: _futureProperties,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          List<Property> properties = snapshot.data!;
          if (properties.isEmpty) return Center(child: Text("No properties found"));
          return ListView.builder(
            itemCount: properties.length,
            itemBuilder: (context, index) {
              Property p = properties[index];
              return Card(
                child: ListTile(
                  title: Text(p.title),
                  subtitle: Text("${p.type} - ${p.status}"),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      await ApiService.deleteProperty(p.id);
                      setState(() {
                        _futureProperties = ApiService.getProperties();
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
