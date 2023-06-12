import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user_search_app/logic/cubits/user_search_cubit/user_search_cubit.dart';
import 'package:github_user_search_app/logic/cubits/user_search_cubit/user_search_state.dart';
import 'package:github_user_search_app/presentation/screens/profile_screen.dart';

import '../../logic/cubits/user_cubit/user_cubit.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff141a1c),
        centerTitle: true,
        title: const Text("Search"),
      ),
      body: SafeArea(
        child: BlocConsumer<UserSearchCubit, UserSearchState>(
            listener: (context, state) {
          if (state is UserSearchErrorState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.error),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }, builder: (context, state) {
          if (state is UserSearchLoadingState) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  initialView(),
                  // SizedBox(height: 200),
                  const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ]);
          }
          if (state is UserSearchLoadedState) {
            return state.users.items!.isEmpty
                ? Column(children: [
                    initialView(),
                    const Center(
                      child: Text(
                        "No users found!",
                        style: TextStyle(
                            fontSize: 22, fontStyle: FontStyle.italic),
                      ),
                    )
                  ])
                : Column(
                    children: [
                      initialView(),
                      Expanded(
                        child: ListView.builder(
                            itemCount: state.users.items!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 32, right: 32, top: 4),
                                child: Card(
                                  color: const Color(0xff2c343b),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: const BorderSide(color: Colors.blueGrey)),
                                  elevation: 4,
                                  clipBehavior: Clip.hardEdge,
                                  child: InkWell(
                                    // splashColor: Colors.blue.withAlpha(30),
                                    child: ListTile(
                                      title: Text(state
                                          .users.items![index].login
                                          .toString(),style: const TextStyle(color: Colors.white70),),
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(state
                                            .users.items![index].avatarUrl
                                            .toString()),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => BlocProvider(
                                                  create: (context) =>
                                                      UserCubit(state.users
                                                          .items![index].login
                                                          .toString()),
                                                  child:
                                                      const ProfileScreen())));
                                    },
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  );
          }
          if (state is UserSearchInitialState) {
            return initialView();
          }

          return initialView();
        }),
      ),
    );
  }

  Widget initialView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                style: const TextStyle(color: Colors.white70),
                controller: searchTextController,
                decoration: const InputDecoration(
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey)),
                    fillColor: Color(0xff1c2424),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    hintText: "Name",
                    counterText: "",hintStyle: TextStyle(color: Colors.white30)),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CupertinoButton(
                  onPressed: () {
                    BlocProvider.of<UserSearchCubit>(context)
                        .searchUser(searchTextController.text);
                  },
                  color: Colors.white,
                  child: const Text("Search",style: TextStyle(color: Color(0xff0e1117)),),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
