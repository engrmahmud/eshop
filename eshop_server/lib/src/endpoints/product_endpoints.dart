import 'package:eshop_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class ProductEndpoint extends Endpoint {
  Future<List<Product>> getAllProducts(Session session) async {
    return await Product.db.find(session);
  }

  Future<Product?> getProductById(Session session, int id) async {
    return await Product.db.findById(session, id);
  }

  Future<Product> createProduct(Session session, Product product) async {
    final result = await Product.db.insertRow(session, product);
    return result;
  }

  Future<Product> updateProduct(Session session, Product product) async {
    final result = await Product.db.updateRow(session, product);
    return result;
  }

  Future<void> deleteProduct(Session session, int id) async {
    await Product.db.deleteWhere(session, where: (c) => c.id.equals(id));
  }
}
