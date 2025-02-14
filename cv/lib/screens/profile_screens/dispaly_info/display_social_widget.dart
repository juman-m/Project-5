import 'package:cv/blocs/delete_bloc/delete_bloc.dart';
import 'package:cv/models/social.dart';
import 'package:cv/services/social/get_social.dart';
import 'package:cv/style/colors.dart';
import 'package:cv/style/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

class DisplayAllSocials extends StatefulWidget {
  const DisplayAllSocials({super.key});

  @override
  State<DisplayAllSocials> createState() => _DisplayAllSocialsState();
}

class _DisplayAllSocialsState extends State<DisplayAllSocials> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getsocials(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Social> socialsList = snapshot.data!;
            return socialsList.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 18.0),
                        child: Text(
                          "Scoial Media:",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.teal,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: socialsList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              Widget? logo;
                              if (socialsList[index].social == "facebook") {
                                logo = Logo(Logos.facebook_f, size: 20);
                              } else if (socialsList[index].social ==
                                  "youtube") {
                                logo = Logo(Logos.youtube, size: 20);
                              } else if (socialsList[index].social ==
                                  "whatsapp") {
                                logo = Logo(Logos.whatsapp, size: 20);
                              } else if (socialsList[index].social ==
                                  "instagram") {
                                logo = Logo(Logos.instagram, size: 20);
                              } else if (socialsList[index].social ==
                                  "twitter") {
                                logo = Logo(Logos.twitter, size: 20);
                              } else if (socialsList[index].social ==
                                  "telegram") {
                                logo = Logo(Logos.telegram, size: 20);
                              } else if (socialsList[index].social ==
                                  "tiktok") {
                                logo = const Text("Tik");
                              }
                              return Row(
                                children: [
                                  Chip(
                                    onDeleted: () async {
                                      context.read<DeleteBloc>().add(
                                          DeleteSocialEvent(
                                              socialsList[index].id!, context));
                                    },
                                    backgroundColor: lightBlue,
                                    avatar: logo,
                                    label: Text(
                                      socialsList[index].username ?? "",
                                      // style:
                                      //     const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  width14(),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                : const Text("");
          } else if (snapshot.hasError) {
            return const Center(child: Text("error"));
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
