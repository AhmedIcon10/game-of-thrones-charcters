import 'package:breaking_bad/business_logic/cubit/characters_cubit.dart';
import 'package:breaking_bad/presentation/widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  List<dynamic> allCharacters = [];
  List<dynamic> searchedForCharacters = [];
  bool _isSearching = false;
  final _searchTextController = TextEditingController();
  Widget _buildSearchField() => TextField(
        controller: _searchTextController,
        cursorColor: Colors.indigo,
        decoration: const InputDecoration(
          hintText: 'Find A Character ...',
          border: InputBorder.none,
          hintStyle: TextStyle(
            fontSize: 18,
            color: Colors.indigo,
          ),
        ),
        style: const TextStyle(
          fontSize: 18,
          color: Colors.indigo,
        ),
        onChanged: (searchedCharacter) {
          addSearchedForItemsForSearchedList(searchedCharacter);
        },
      );
  void addSearchedForItemsForSearchedList(String searchedCharacter) {
    searchedForCharacters = allCharacters
        .where((character) =>
            character.fullName.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.clear,
            color: Colors.indigo,
          ),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: () {
            _startSearch();
          },
          icon: const Icon(
            Icons.search,
            color: Colors.indigo,
          ),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(
      onRemove: _stopSearching,
    ));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  Widget showLoadingIndicator() {
    return const Center(
        child: CircularProgressIndicator(
      color: Colors.indigo,
    ));
  }

  Widget buildCharactersList() {
    return GridView.builder(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: _searchTextController.text.isEmpty
          ? allCharacters.length
          : searchedForCharacters.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      itemBuilder: (context, index) => CharacterItem(
          character: _searchTextController.text.isEmpty
              ? allCharacters[index]
              : searchedForCharacters[index]),
    );
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white10,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersStates>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = (state).characters;
          return buildLoadedListWidget();
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }

  Widget _buildAppBarTitle() => const Text(
        'C H A R A C T E R S',
        style: TextStyle(
          color: Colors.indigo,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        leading: _isSearching
            ? const BackButton(
                color: Colors.indigo,
              )
            : Container(),
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
        centerTitle: true,
        backgroundColor: Colors.white10,
        elevation: 5,
      ),
      body: buildBlocWidget(),
    );
  }
}
