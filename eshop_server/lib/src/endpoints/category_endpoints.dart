import 'package:eshop_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class CategoryEndpoint extends Endpoint {
  Future<List<Category>> getAllCategories(Session session) async {
    return await Category.db.find(session);
  }

  Future<Category?> getCategoryById(Session session, int id) async {
    return await Category.db.findById(session, id);
  }

  Future<Category> createCategory(Session session, Category category) async {
    final result = await Category.db.insertRow(session, category);
    return result;
  }

  Future<Category> updateCategory(Session session, Category category) async {
    final result = await Category.db.update(session, [category]);
    return result.first;
  }

  Future<void> deleteCategory(Session session, int id) async {
    await Category.db.deleteWhere(session, where: (c) => c.id.equals(id));
  }
}
