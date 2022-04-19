import 'package:flutter/material.dart';
import 'package:manager_users/modules/user/user_form_page.dart';
import 'package:manager_users/modules/user/user_model.dart';
import 'package:manager_users/shared/provider/user_provider.dart';
import 'package:provider/provider.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<UserModel> users = Provider.of<UserProvider>(context).getUsers();

    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(users[index].name),
              subtitle: Text(users[index].email),
              leading: CircleAvatar(
                child: Text(users[index].name[0].toUpperCase()),
              ),
              focusColor: Colors.red,
              onLongPress: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text('Excluir Usuário'),
                  content:
                      Text('Deseja excluir o usuário ${users[index].name} ?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Não'),
                    ),
                    TextButton(
                      onPressed: () {
                        Provider.of<UserProvider>(context, listen: false)
                            .deleteUser(users[index]);
                        Navigator.pop(context, 'Usuário excluido com sucesso!');
                      },
                      child: Text('Sim'),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Provider.of<UserProvider>(context, listen: false)
                    .setCurrentUser(users[index]);
                _navigate(context);
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<UserProvider>(context, listen: false)
              .setCurrentUser(null);
          _navigate(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _navigate(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute<String>(
        builder: (BuildContext context) => UserFormPage(),
        fullscreenDialog: true,
      ),
    );
    if (result != null) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text('$result'),
          ),
        );
    }
  }
}
