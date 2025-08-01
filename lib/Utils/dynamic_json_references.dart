
import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, dynamic>> resolveDynamicJsonReferences({
  required Map<String, dynamic> input,
  required String module,
  required String screen,
}) async {
  Future<dynamic> resolve(dynamic value) async {
    if (value is String && value.startsWith('@')) {
      final docId = value.substring(1);
      final path = 'sdui_schemas/$module/screens/$screen/widgets /$docId';

      final docSnapshot = await FirebaseFirestore.instance
          .collection('sdui_schemas')
          .doc(module)
          .collection('screens')
          .doc(screen)
          .collection('widgets')
          .doc(docId)
          .get();

      if (!docSnapshot.exists) {
        throw Exception("Widget '$docId' not found at path: $path");
      }

      final data = docSnapshot.data();
      if (data is Map<String, dynamic>) {
        return await resolve(data); // handle nested @ references
      } else {
        return data;
      }
    } else if (value is Map<String, dynamic>) {
      final Map<String, dynamic> resolvedMap = {};
      for (var entry in value.entries) {
        resolvedMap[entry.key] = await resolve(entry.value);
      }
      return resolvedMap;
    } else if (value is List) {
      return Future.wait(value.map((item) => resolve(item)));
    } else {
      return value;
    }
  }

  return await resolve(input) as Map<String, dynamic>;
}
