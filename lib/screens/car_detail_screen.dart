import 'package:flutter/material.dart';
import '../models/car.dart';
import '../services/car_service.dart';

class CarDetailScreen extends StatefulWidget {
  final Car? car;

  CarDetailScreen({this.car});

  @override
  _CarDetailScreenState createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen> {
  final _makeController = TextEditingController();
  final _modelController = TextEditingController();
  final _yearController = TextEditingController();
  final CarService _carService = CarService();

  @override
  void initState() {
    super.initState();
    if (widget.car != null) {
      _makeController.text = widget.car!.make;
      _modelController.text = widget.car!.model;
      _yearController.text = widget.car!.year.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.car == null ? 'Add Car' : 'Edit Car'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _makeController,
              decoration: InputDecoration(labelText: 'Make'),
            ),
            TextField(
              controller: _modelController,
              decoration: InputDecoration(labelText: 'Model'),
            ),
            TextField(
              controller: _yearController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Year'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final car = Car(
                  id: widget.car?.id ?? DateTime.now().toString(),
                  make: _makeController.text,
                  model: _modelController.text,
                  year: int.parse(_yearController.text),
                );

                try {
                  if (widget.car == null) {
                    await _carService.createCar(car);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Car added successfully')),
                    );
                  } else {
                    await _carService.updateCar(car);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Car updated successfully')),
                    );
                  }
                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to save car')),
                  );
                }
              },
              child: Text(widget.car == null ? 'Add Car' : 'Update Car'),
            ),
            if (widget.car != null)
              ElevatedButton(
                onPressed: () async {
                  try {
                    await _carService.deleteCar(widget.car!.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Car deleted successfully')),
                    );
                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to delete car')),
                    );
                  }
                },
                child: Text('Delete Car'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
