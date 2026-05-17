import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  final url = Uri.parse('https://api.jsonbin.io/v3/b/6a095f58adc21f119ab1042a');
  final response = await http.get(url);
  print('Status: ${response.statusCode}');
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    print('Clés: ${data.keys}');
    print('Nombre d\'hôtels: ${(data['record'] as List).length}');
  } else {
    print('Erreur HTTP');
  }
}