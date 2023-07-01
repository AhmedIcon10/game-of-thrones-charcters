import 'package:breaking_bad/constants/string.dart';
import 'package:flutter/material.dart';
import '../../data/models/characters_model.dart';

class CharacterItem extends StatelessWidget {
  final Character? character;
  const CharacterItem({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadiusDirectional.circular(10),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            charactersDetailsScreen,
            arguments: character,
          );
        },
        child: GridTile(
          footer: Hero(
            tag: character!.id.toString(),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Colors.black54,
              alignment: AlignmentDirectional.bottomCenter,
              child: Text(
                character!.fullName.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  height: 1.3,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          child: Container(
            color: Colors.grey,
            child: character!.imageUrl!.isNotEmpty
                ? FadeInImage.assetNetwork(
                    width: double.infinity,
                    height: double.infinity,
                    placeholder: 'assets/images/loading.gif',
                    image: character!.imageUrl.toString(),
                    fit: BoxFit.cover,
                  )
                : Image.asset('assets/images/placeholder.gif'),
          ),
        ),
      ),
    );
  }
}
