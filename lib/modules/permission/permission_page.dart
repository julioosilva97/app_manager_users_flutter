import 'package:flutter/material.dart';
import 'package:manager_users/modules/permission/permission_model.dart';
import 'package:manager_users/shared/provider/permission_provider.dart';
import 'package:manager_users/shared/widgets/text_field/text_field_widget.dart';
import 'package:provider/provider.dart';

class PermissionPage extends StatelessWidget {
  const PermissionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<PermissionModel> permissions =
        Provider.of<PermissionProvider>(context).getPermissions();
    print(permissions.length);
    return Scaffold(
        body: ListView.builder(
            itemCount: permissions.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${permissions[index].name}'),
                onTap: () {
                  Provider.of<PermissionProvider>(context, listen: false)
                      .setCurrentPermission(permissions[index]);
                  _navigate(context);
                },
                onLongPress: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text('Excluir Permissão'),
                    content: Text(
                        'Deseja excluir a permissão ${permissions[index].name} ?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Não'),
                      ),
                      TextButton(
                        onPressed: () {
                          Provider.of<PermissionProvider>(context,
                                  listen: false)
                              .deletePermission(permissions[index]);
                          Navigator.pop(
                              context, 'Permissão excluida com sucesso!');
                        },
                        child: Text('Sim'),
                      ),
                    ],
                  ),
                ),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Provider.of<PermissionProvider>(context, listen: false)
                .setCurrentPermission(null);
            _navigate(context);
          },
          child: Icon(Icons.add),
        ));
  }

  void _navigate(BuildContext context) async {
    final result = await showModalBottomSheet(
        context: context, builder: (BuildContext context) => AddTaskScreen());

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

class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var currentPermission =
        Provider.of<PermissionProvider>(context, listen: false)
            .getCurrentPermission();

    PermissionModel permission = currentPermission ??
        PermissionModel(
          name: '',
        );

    String title =
        currentPermission != null ? 'Editar Permissão' : 'Adicionar Permissão';

    TextEditingController _controller =
        TextEditingController(text: permission.name);

    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blue,
                fontSize: 30.0,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _controller,
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                permission.name = value;
              },
            ),
            TextButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue)),
              onPressed: () {
                var message = 'Perfil cadastrado com sucesso!';
                _controller.clear();
                Provider.of<PermissionProvider>(context, listen: false)
                    .addPermission(permission);
                Navigator.pop(context, message);
              },
              child: Text(
                'Adicionar',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
