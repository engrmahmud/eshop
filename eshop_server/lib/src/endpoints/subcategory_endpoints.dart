import 'package:eshop_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class SubcategoryEndpoint extends Endpoint {
  Future<List<Subcategory>> getAllSubcategories(Session session) async {
    return await Subcategory.db.find(session);
  }

  Future<Subcategory?> getSubcategoryById(Session session, int id) async {
    return await Subcategory.db.findById(session, id);
  }

  Future<Subcategory> createSubcategory(
    Session session,
    Subcategory subcategory,
  ) async {
    final result = await Subcategory.db.insertRow(session, subcategory);
    return result;
  }

  Future<Subcategory> updateSubcategory(
    Session session,
    Subcategory subcategory,
  ) async {
    final result = await Subcategory.db.update(session, [subcategory]);
    return result.first;
  }

  Future<void> deleteSubcategory(Session session, int id) async {
    await Subcategory.db.deleteWhere(session, where: (c) => c.id.equals(id));
  }
}
