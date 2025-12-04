
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'veiculo_model.dart';
import 'dart:developer' as developer;

class StorageService {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // Modificado para aceitar uma chave (nome do arquivo)
  Future<File> _localFile(String key) async {
    final path = await _localPath;
    return File('$path/$key.json');
  }

  // Modificado para aceitar a chave
  Future<void> saveVehicles(List<Vehicle> vehicles, String key) async {
    try {
      final file = await _localFile(key);
      String data = jsonEncode(vehicles.map((v) => v.toMap()).toList());
      await file.writeAsString(data);
    } catch (e, s) {
      developer.log("Error saving file", name: key, error: e, stackTrace: s);
    }
  }

  // Modificado para aceitar a chave
  Future<List<Vehicle>> loadVehicles(String key) async {
    try {
      final file = await _localFile(key);
      if (!await file.exists()) return [];

      String content = await file.readAsString();
      List<dynamic> jsonList = jsonDecode(content);
      return jsonList.map((json) => Vehicle.fromMap(json)).toList();
    } catch (e, s) {
      developer.log("Error reading file", name: key, error: e, stackTrace: s);
      return [];
    }
  }
}
