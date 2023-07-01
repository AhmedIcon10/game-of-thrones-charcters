import 'package:breaking_bad/data/models/characters_model.dart';
import 'package:flutter/material.dart';

class CharactersDetailsScreen extends StatelessWidget {
  final Character character;

  const CharactersDetailsScreen({super.key, required this.character});

  Widget buildSliverAppBar() => SliverAppBar(
        stretch: true,
        pinned: true,
        expandedHeight: 600,
        backgroundColor: Colors.black,
        flexibleSpace: FlexibleSpaceBar(
          title: Text(
            character.fullName.toString(),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          background: Hero(
            tag: character.id.toString(),
            child: Image.network(
              character.imageUrl.toString(),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
  Widget characterInfo(String title, String value) => RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: Colors.indigo,
              fontWeight: FontWeight.w500,
              fontSize: 22,
            ),
          ),
          TextSpan(
            text: ' $value  .',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: 20,
            ),
          ),
        ]),
      );
  Widget buildDivider(double endIndent) => Divider(
        color: Colors.indigo,
        height: 30,
        thickness: 2,
        endIndent: endIndent,
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: const EdgeInsets.all(4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    characterInfo('Title : ', character.title.toString()),
                    buildDivider(315),
                    characterInfo(
                        'Family Name : ', character.family.toString()),
                    buildDivider(230),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 650,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
