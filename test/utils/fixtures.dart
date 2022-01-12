import 'dart:convert';
import 'dart:io';

Map<String, dynamic> fixture({required String name}) {
  final dir = Directory.current.path;
  return jsonDecode(File('$dir/test/fixtures/$name').readAsStringSync());
}
