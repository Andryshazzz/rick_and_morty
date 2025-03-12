import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/characters_details.dart';
import '../../repos/characters_repo.dart';
import 'characters_bloc.dart';
import '../details/details_screen.dart';

class CharactersScreen extends StatelessWidget {
  const CharactersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CharactersBloc(repository: context.read<CharacterRepository>()),
      child: _CharactersScreen(),
    );
  }
}

class _CharactersScreen extends StatefulWidget {
  const _CharactersScreen({super.key});

  @override
  State<_CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<_CharactersScreen> {
  @override
  void initState() {
    context.read<CharactersBloc>().add(CharactersLoadData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(),
      ),
      body: BlocBuilder<CharactersBloc, CharactersState>(
        builder: (context, state) {
          if (state is CharactersLoaded) {
            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.all(20),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => ContentCard(
                        data: state.character,
                        index: index,
                      ),
                      childCount: 6,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 20,
                      mainAxisExtent: 215,
                    ),
                  ),
                ),
              ],
            );
          } else if (state is CharactersInitial) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Text('ой-ой');
          }
        },
      ),
    );
  }
}

class ContentCard extends StatefulWidget {
  final int index;
  final List<Character> data;

  const ContentCard({
    super.key,
    required this.data,
    required this.index,
  });

  @override
  State<ContentCard> createState() => _ContentCardState();
}

class _ContentCardState extends State<ContentCard> {
  bool isLiked = false;

  @override
  void initState() {
    _loadLikeStatus();
    super.initState();
  }

  Future<void> _loadLikeStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLiked = prefs.getBool('liked_${widget.index}') ?? false;
    });
  }

  Future<void> toggleLike() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLiked = !isLiked;
    await prefs.setBool('liked_${widget.index}', isLiked);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CharactersDetailsScreenProvider(
              characterId: widget.data[widget.index].id,
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
                    Image.network(widget.data[widget.index].image ??
                        'https://i.pinimg.com/736x/85/08/0a/85080afc4cba3d34e2846e435fe3d802.jpg'),
                    IconButton(
                      onPressed: toggleLike,
                      icon: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: SvgPicture.asset(
                            isLiked
                                ? 'assets/icons/liked.svg'
                                : 'assets/icons/unliked.svg',
                          )),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    widget.data[widget.index].name ?? 'Не найдено',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
