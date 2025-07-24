import 'package:flutter/material.dart';
import 'package:mini_messenger/services/auth_service.dart';
import 'package:mini_messenger/services/chat_service.dart';
import 'package:mini_messenger/pages/chat_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void logout() {
    final authService = AuthService();
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Главная"),
        actions: [
          IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
        ],
      ),
      body: _buildUserList(context),
    );
  }
}

Widget _buildUserList(BuildContext context) {
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  return StreamBuilder(
    stream: _chatService.getUsersStream(),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return const Text("Ошибка!");
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }

      final users = snapshot.data!;
      return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];

          if (user["uid"] != _authService.getCurrrentUser()!.uid) {
            return _buildUserListItem(user, context);
          } else {
            return Container();
          }
        },
      );
    },
  );
}

Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
  return ListTile(
    title: Text(userData["email"]),
    onTap: () {
      //perehod
      print("Нажали на пользователя: ${userData["email"]}");
    },
  );
}
