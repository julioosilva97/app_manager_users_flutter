import 'package:flutter/material.dart';
import 'package:manager_users/modules/profile/profile_model.dart';
import 'package:manager_users/modules/user/user_model.dart';
import 'package:manager_users/shared/provider/profile_provider.dart';
import 'package:manager_users/shared/provider/user_provider.dart';
import 'package:manager_users/shared/widgets/text_field/text_field_widget.dart';
import 'package:provider/provider.dart';

class UserFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    List<ProfileModel> profiles = [];

    var currentUser =
        Provider.of<UserProvider>(context, listen: false).getCurrentUser();

    UserModel user = currentUser ??
        UserModel(
          name: "",
          email: "",
          enabled: false,
        );

    profiles =
        Provider.of<ProfileProvider>(context, listen: false).getProfiles();

    var selectedProfile =
        currentUser != null ? currentUser.profile : profiles[0];

    return Scaffold(
      appBar: AppBar(
        title: Text('Full-screen Dialog'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFieldWidget(
                initialValue: user.name,
                onSaved: (value) => user.name = value!,
                validator: (value) {
                  if (value == "") {
                    return 'Campo obrigatório';
                  }
                },
                icon: Icons.person,
                labelText: 'Nome',
              ),
              TextFieldWidget(
                initialValue: user.email,
                onSaved: (value) => user.email = value!,
                validator: (value) {
                  if (value == "") {
                    return 'Campo obrigatório';
                  }
                },
                icon: Icons.mail,
                labelText: 'Email',
              ),
              Container(
                margin: EdgeInsets.only(bottom: 15),
                child: DropdownButtonFormField(
                  validator: (value) {
                    if (value == "") {
                      return 'Campo obrigatório';
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.assignment),
                  ),
                  value: selectedProfile,
                  onChanged: (Object? newValue) {
                    selectedProfile = newValue! as ProfileModel;
                    user.profile = selectedProfile;
                    Provider.of<ProfileProvider>(context, listen: false)
                        .setProfileSelected(selectedProfile);
                  },
                  items: profiles.map((ProfileModel profile) {
                    return DropdownMenuItem<ProfileModel>(
                      value: profile,
                      child: Text(profile.name),
                    );
                  }).toList(),
                  /*<String>['One', 'Two', 'Free', 'Four']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),*/
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: double.infinity,
                ),
                child: ElevatedButton(
                  style: ButtonStyle(),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      var message = 'Usuário cadastrado com sucesso!';
                      _formKey.currentState!.save();
                      if (currentUser != null) {
                        message = 'Usuário atualizado';
                      } else {
                        Provider.of<UserProvider>(context, listen: false)
                            .addUser(user);
                      }
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
