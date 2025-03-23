import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_and_morty/res/icons.dart';
import '../../models/characters_details.dart';

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
        return GetIt.I<CharactersBloc>()
          ..add(
            CharactersLoadData(),
          );
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
      body: SafeArea(
        child: BlocBuilder<CharactersBloc, CharactersState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.characters.isEmpty) {
              return const Text('ой-ой');
            }
            return _CharactersList(
              characters: state.characters,
              isLoadingMore: state.isLoadingMore,
            );
          },
        ),
      ),
    );
  }
}

class _CharactersList extends StatefulWidget {
  final List<Character> characters;
  final bool isLoadingMore;

  const _CharactersList({
    required this.characters,
    required this.isLoadingMore,
  });

  @override
  State<_CharactersList> createState() => _CharactersListState();
}

class _CharactersListState extends State<_CharactersList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(
      () async {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          context.read<CharactersBloc>().add(
                CharactersLoadMoreData(),
              );
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverPadding(
          padding: EdgeInsets.all(20),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) => CharacterCard(
                character: widget.characters[index],
              ),
              childCount: widget.characters.length,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 20,
              mainAxisExtent: 215,
            ),
          ),
        ),
        if (widget.isLoadingMore)
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: CircularProgressIndicator(),
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
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
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
