import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user_search_app/data/models/user_model.dart';

import '../../logic/cubits/user_cubit/user_cubit.dart';
import '../../logic/cubits/user_cubit/user_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
  }

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff141a1c),
        centerTitle: true,
        title: const Text("Profile"),
      ),
      body: Material(
        color: const Color(0xff232933),
        child: SafeArea(
          child: BlocConsumer<UserCubit, UserState>(listener: (context, state) {
            if (state is UserErrorState) {
              SnackBar snackBar = SnackBar(
                content: Text(state.error),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          }, builder: (context, state) {
            if (state is UserLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            if (state is UserLoadedState) {
              UserModel user = state.user;
              return buildLoadedView(user);
            }

            return const Center(
              child: Text("Error Occurred"),
            );
          }),
        ),
      ),
    );
  }

  Material buildLoadedView(UserModel user) {
    return Material(
      color: const Color(0xff232933),
      child: ListView(children: <Widget>[
        Container(
          height: 250,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff0e1117), Color(0xff232933)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0.2, 0.9],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.white70,
                    minRadius: 60.0,
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundImage: NetworkImage(user.avatarUrl.toString()),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                user.login.toString(),
                style: const TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              user.name != null
                  ? Text(
                      user.name.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(decoration: BoxDecoration(
                color: const Color(0xff232933),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(6))
              ),
                child: ListTile(
                  title: Text(
                    user.followers.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: const Text(
                    'Followers',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xff0e1117),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(6))
                ),
                child: ListTile(
                  title: Text(
                    user.publicRepos.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: const Text(
                    'Repositories',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 12),
              child: Divider(
                color: Colors.white,
              ),
            ),
            ListTile(
              title: const Text(
                'Bio:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: user.bio != null
                  ? Text(
                      user.bio.toString(),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    )
                  : const Text(
                      "User does not have a bio!",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontStyle: FontStyle.italic
                      ),
                    ),
            ),
            // Expanded(child: Container())
          ],
        )
      ]),
    );
  }
}
