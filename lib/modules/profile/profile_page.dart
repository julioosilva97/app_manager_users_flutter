import 'package:flutter/material.dart';
import 'package:manager_users/modules/permission/permission_model.dart';
import 'package:manager_users/modules/profile/profile_form_page.dart';
import 'package:manager_users/modules/profile/profile_model.dart';
import 'package:manager_users/shared/provider/profile_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProfileProvider>(context);

    List<ProfileModel> profiles = provider.getProfiles();

    return Scaffold(
        body: ListView.builder(
            itemCount: profiles.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${profiles[index].name}'),
                onTap: () {
                  Provider.of<ProfileProvider>(context, listen: false)
                      .setCurrentProfile(profiles[index]);

                  _navigate(context);
                },
                onLongPress: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text('Excluir Perfil'),
                    content: Text(
                        'Deseja excluir o perfil ${profiles[index].name} ?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Não'),
                      ),
                      TextButton(
                        onPressed: () {
                          Provider.of<ProfileProvider>(context, listen: false)
                              .deleteProfile(profiles[index]);
                          Navigator.pop(
                              context, 'Perfil excluido com sucesso!');
                        },
                        child: Text('Sim'),
                      ),
                    ],
                  ),
                ),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Provider.of<ProfileProvider>(context, listen: false)
                .setCurrentProfile(null);
            _navigate(context);
          },
          child: Icon(Icons.add),
        ));
  }

  void _navigate(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute<String>(
        builder: (BuildContext context) => ProfileFormPage(),
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
