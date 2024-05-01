import 'package:dr_app/provider/auth_provider.dart';
import 'package:dr_app/styles/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(40), color: Color(MyColors.primary)),
                height: 40,
                width: 90,
                margin: new EdgeInsets.only(left: 15.0, top: 60.0),
                child: TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 15,
                      color: Colors.white,
                    ),
                    label: Text(
                      "BACK",
                      style: TextStyle(color: Colors.white),
                    ))),
            Padding(
              padding: EdgeInsets.only(left: 15.0, top: 60.0, right: 30),
              child: IconButton(
                  onPressed: LogOut,
                  icon: Icon(
                    Icons.exit_to_app,
                    size: 26,
                    color: Colors.red,
                  )),
            )
          ],
        ),
        SizedBox(
          height: height * 0.05,
        ),
        Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                // Provider.of<AuthProviderApp>(context, listen: true)
                //         .imageProfileUrl ==
                //     null
                // ?
                InkWell(
                  child: CircleAvatar(
                    backgroundColor: Color(MyColors.bg01),
                    radius: height * 0.15,
                  ),
                  onTap: () {
                    Provider.of<AuthProviderApp>(context, listen: false).uploadImage();
                  },
                )
                // : InkWell(
                //     child: CircleAvatar(
                //       radius: height * 0.15,
                //       backgroundImage: Image.network(
                //           Provider.of<AuthProviderApp>(context, listen: false)
                //               .imageProfileUrl!) as ImageProvider,
                //     ),
                //   )
              ],
            )),
        SizedBox(
          height: height * 0.05,
        ),
        ProfileFields(),
        SizedBox(
          height: height * 0.1,
        ),
      ]),
    );
  }

  void LogOut() {
    showDialog(
        context: context,
        builder: ((ctx) => AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Do you want to sign out?'),
              actions: [
                TextButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                  },
                ),
                TextButton(
                  child: Text('Yes'),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(ctx).pop();
                    setState(() {});
                  },
                )
              ],
            )));
  }
}

//show the fields of the user and the option to edit them
class ProfileFields extends StatelessWidget {
  const ProfileFields({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: 300,
                  child:
                      Text("Name: " + Provider.of<AuthProviderApp>(context).userName!, style: TextStyle(fontSize: 20))),
            ),
            IconButton(
              icon: Icon(Icons.edit, color: Color(MyColors.primary)),
              onPressed: () {},
            )
          ],
        ),
        SizedBox(
          height: height * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: 300,
                  child: Text("Email: " + Provider.of<AuthProviderApp>(context).userEmail!,
                      style: TextStyle(fontSize: 20))),
            ),
            IconButton(
              icon: Icon(Icons.edit, color: Color(MyColors.primary)),
              onPressed: () {},
            )
          ],
        ),
        SizedBox(
          height: height * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 300,
                  child: Provider.of<AuthProviderApp>(context).userPhone == ""
                      ? Text("Phone: Not set", style: TextStyle(fontSize: 20))
                      : Text("Phone: " + Provider.of<AuthProviderApp>(context).userPhone!,
                          style: TextStyle(fontSize: 20)),
                )),
            IconButton(
              icon: Icon(Icons.edit, color: Color(MyColors.primary)),
              onPressed: () {},
            )
          ],
        ),
      ],
    );
  }
}
