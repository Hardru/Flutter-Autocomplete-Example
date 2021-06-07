import 'package:flutter/material.dart';

import 'User.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(title: Text("Buscador d'usuaris")),
          body: Center(child: AutoCompleteExample())),
    );
  }
}

class AutoCompleteExample extends StatefulWidget {
  const AutoCompleteExample({Key? key}) : super(key: key);

  @override
  _AutoCompleteExampleState createState() => _AutoCompleteExampleState();
}

class _AutoCompleteExampleState extends State<AutoCompleteExample> {
  String province = '';
  User? user;

  void updateProvince(String newProvince) =>
      setState(() => province = newProvince);

  void changeUser(User newUser) => setState(() => user = newUser);

  @override
  Widget build(BuildContext context) {
    print(province);

    return Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "Escriu el correu d'un usuari per trobar-ne la informació. Si vols, pots filtrar per província"),
            Padding(padding: EdgeInsets.all(10)),
            Divider(),
            Padding(padding: EdgeInsets.all(10)),
            Text(
              "Província (opcional)",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            ProvinceAutocomplete(
              onProvinceChange: updateProvince,
            ),
            Padding(padding: EdgeInsets.all(20)),
            Text("Correu electrònic",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            UserAutocomplete(
              province: province,
              onUserChange: changeUser,
            ),
            if (user != null)
              Column(children: [
                Padding(padding: EdgeInsets.all(10)),
                Divider(),
                Padding(padding: EdgeInsets.all(10)),
                DisplayUserData(user: user!)
              ]),
          ],
        ));
  }
}

// In this autocomplete, options are suggested even before typing anything. The
// options are a list of strings, so it is very straightforward
class ProvinceAutocomplete extends StatelessWidget {
  final Function onProvinceChange;

  const ProvinceAutocomplete({Key? key, required this.onProvinceChange})
      : super(key: key);

  // We obtain the list of options from the options of the User class and only
  // get the provinces.
  // By converting it to a Set and then to a List, we only get unique values
  static List<String> options =
      User.options.map((e) => e.province).toSet().toList();

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          // Since we return the options here, all options will be displayed at
          // the beginning
          return options;
        }
        // We want to lowercase to avoid Barcelona not finding barcelona
        return options.where((String option) {
          return option
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (option) => {onProvinceChange(option)},
    );
  }
}

// In this autocomplete, options are not suggested until something is typed.
// The options are a list of Users, but displayed as emails, since they should
// be unique. It can also be filtered by province if a value is received
class UserAutocomplete extends StatelessWidget {
  final String province;
  final Function onUserChange;
  const UserAutocomplete(
      {Key? key, required this.province, required this.onUserChange})
      : super(key: key);

  // From a user, we return the email to be displayed
  static String displayStringForOption(User option) => option.email;

  @override
  Widget build(BuildContext context) {
    // Options is initialized inside build because we need access to province
    // If province is not set, we return all the options from the class User
    // Else, we filter them through province
    var options = province == ''
        ? User.options
        : User.options.where((User option) => option.province == province);

    return Autocomplete<User>(
      // Since we want to display a User with its email, we need to pass the
      // correspondant function
      displayStringForOption: displayStringForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          // Since we return an Empty iterable, if nothing is typed no options
          // will be shown
          return const Iterable<User>.empty();
        }

        // We want to lowercase to avoid Barcelona not finding barcelona
        return options.where((option) => option.email
            .toLowerCase()
            .contains(textEditingValue.text.toLowerCase()));
      },
      onSelected: (User selection) {
        onUserChange(selection);
      },
    );
  }
}

class DisplayUserData extends StatelessWidget {
  final User user;
  const DisplayUserData({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Padding(
            padding: EdgeInsets.all(14),
            child: Column(children: [
              Text(
                "Nom de l'usuari",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Padding(padding: EdgeInsets.all(6), child: Text(user.name))
            ])),
        Padding(
            padding: EdgeInsets.all(14),
            child: Column(children: [
              Text(
                "Correu de l'usuari",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Padding(padding: EdgeInsets.all(6), child: Text(user.email))
            ])),
        Padding(
            padding: EdgeInsets.all(14),
            child: Column(children: [
              Text(
                "Nickname",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Padding(padding: EdgeInsets.all(6), child: Text(user.username))
            ])),
        Padding(
            padding: EdgeInsets.all(14),
            child: Column(children: [
              Text(
                "Província",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Padding(padding: EdgeInsets.all(6), child: Text(user.province))
            ])),
      ],
    );
  }
}
