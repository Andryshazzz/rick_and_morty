import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rick_and_morty/res/icons.dart';
import '../../models/characters_details.dart';
import '../../repos/characters_repo.dart';
import '../../res/text_styles.dart';
import 'characters_bloc.dart';
import '../details/details_screen.dart';
import 'characters_event.dart';
import 'characters_state.dart';

class CharactersScreen extends StatelessWidget {
  const CharactersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final repository = context.read<CharacterRepository>();
        return CharactersBloc(repository: repository)
          ..add(CharactersLoadData());
      },
      child: const _CharactersScreen(),
    );
  }
}

class _CharactersScreen extends StatelessWidget {
  const _CharactersScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(),
      ),
      body: BlocBuilder<CharactersBloc, CharactersState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.characters.isEmpty) {
            return const Text('ой-ой');
          }
          return _CharactersList(characters: state.characters);
        },
      ),
    );
  }
}

class _CharactersList extends StatelessWidget {
  final List<Character> characters;

  const _CharactersList({
    required this.characters,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.all(20),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) => CharacterCard(
                character: characters[index],
              ),
              childCount: 8,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 20,
              mainAxisExtent: 215,
            ),
          ),
        ),
      ],
    );
  }
}

class CharacterCard extends StatelessWidget {
  final Character character;

  const CharacterCard({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharactersBloc, CharactersState>(
      builder: (context, state) {
        final isLiked = state.likedStatus[character.id] ?? false;
        return InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CharactersDetailsScreen(
                  characterId: character.id,
                ),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: Stack(
              children: [
                Container(
                  color: Colors.white,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.network(character.image),
                        IconButton(
                          onPressed: () {
                            context
                                .read<CharactersBloc>()
                                .add(CharactersLikeStatus(
                                  characterId: character.id,
                                  isLiked: !isLiked,
                                ));
                          },
                          icon: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: SvgPicture.asset(
                                isLiked
                                    ? ProjectIcons.liked
                                    : ProjectIcons.unLiked,
                              )),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        character.name,
                        style: ProjectTextStyles.bodyBold,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
