import 'package:flutter/material.dart';
import 'package:manager_users/modules/permission/permission_model.dart';
import 'package:manager_users/modules/profile/profile_model.dart';
import 'package:manager_users/shared/provider/permission_provider.dart';
import 'package:manager_users/shared/provider/profile_provider.dart';
import 'package:manager_users/shared/widgets/text_field/text_field_widget.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:provider/provider.dart';

class ProfileFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    List<dynamic> ids = [];
    List<dynamic> permissionsMap = [];

    List<PermissionModel> permissions =
        Provider.of<PermissionProvider>(context).getPermissions();
    permissions.forEach((element) {
      permissionsMap.add(element.toMap());
    });

    var currentProfile = Provider.of<ProfileProvider>(context, listen: false)
        .getCurrentProfile();

    ProfileModel profile = currentProfile ?? ProfileModel(name: '');

    if (profile.permissions != null) {
      profile.permissions!.forEach((element) {
        ids.add(element.id);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFieldWidget(
                initialValue: profile.name,
                onSaved: (value) => profile.name = value!,
                validator: (value) {
                  if (value == "") {
                    return 'Campo obrigatório';
                  }
                },
                icon: Icons.assignment,
                labelText: 'Nome',
              ),
              MultiSelectFormField(
                chipBackGroundColor: Colors.blue,
                chipLabelStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                checkBoxActiveColor: Colors.blue,
                checkBoxCheckColor: Colors.white,
                dialogShapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
                title: Text(
                  "Permissões",
                  style: TextStyle(fontSize: 16),
                ),
                dataSource: permissionsMap,
                textField: 'name',
                valueField: 'id',
                okButtonLabel: 'OK',
                cancelButtonLabel: 'CANCELAR',
                hintWidget: Text('Selecione uma ou mais permissões'),
                initialValue: ids,
                onSaved: (value) {
                  if (value == null) return;

                  ids = value;
                },
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: double.infinity,
                ),
                child: ElevatedButton(
                  style: ButtonStyle(),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      var message = 'Perfil cadastrado com sucesso!';

                      _formKey.currentState!.save();
                      /*if (currentUser != null) {
                        message = 'Usuário atualizado';
                      } else {
                        Provider.of<UserProvider>(context, listen: false)
                            .addUser(user);
                      }*/
                      List<PermissionModel> permissions = [];
                      ids.forEach((element) {
                        permissions.add(PermissionModel(id: element));
                      });

                      profile.permissions = permissions;

                      Provider.of<ProfileProvider>(context, listen: false)
                          .addProfile(profile);
                      Navigator.pop(
                        context,
                        message,
                      );
                    } else {
                      print('erro');
                    }
                  },
                  child: Text('Salvar'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
