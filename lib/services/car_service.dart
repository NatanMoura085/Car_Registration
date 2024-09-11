
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/car.dart';

class CarService {
  final String apiUrl = 'https://66e112a7c831c8811b53adcf.mockapi.io/car/Car_Registration'; 

  Future<List<Car>> fetchCars({int limit = 10, int offset = 0}) async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Car.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load cars');
    }
  }

  Future<void> createCar(Car car) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(car.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create car');
    }
  }

  Future<void> updateCar(Car car) async {
    final response = await http.put(
      Uri.parse('$apiUrl/${car.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(car.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update car');
    }
  }

  Future<void> deleteCar(String id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete car');
    }
  }
}
