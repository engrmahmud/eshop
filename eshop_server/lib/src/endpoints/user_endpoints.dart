import 'package:eshop_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class UserEndpoint extends Endpoint {
  //MANUAL ADMIN LOGIN

  Future<User?> adminLogin(
    Session session,
    String email,
    String password,
  ) async {
    final users = await User.db.find(
      session,
      where: (u) =>
          u.email.equals(email) &
          u.password.equals(password) &
          u.isAdmin.equals(true),
    );
    if (users.isEmpty) {
      return null;
    } else {
      return users.first;
    }
  }

  //MANUAL REGISTER NEW USER

  Future<User> registerCustomer(Session session, User user) async {
    user.isAdmin = false;
    await User.db.insertRow(session, user);
    return user;
  }

  //GET ALL USERS

  Future<List<User>> getAllUsers(Session session) async {
    return await User.db.find(session);
  }
}
