import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';

import '../../entities/character.dart';
import 'characters_bloc.dart';
import '../details/details_screen.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreen();
}

class _CharactersScreen extends State<CharactersScreen> {
  @override
  void initState() {
    context.read<HomeBloc>().add(LoadData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is Loaded) {
            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.all(20),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => ContentCard(
                        data: state.content,
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
          } else if (state is Initial) {
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
  final List<CharacterEntities> data;

  const ContentCard({
    super.key,
    required this.data,
    required this.index,
  });

  @override
  State<ContentCard> createState() => _ContentCardState();
}

class _ContentCardState extends State<ContentCard> {
  late Box likesBox;

  @override
  void initState() {
    likesBox = Hive.box('likesBox');
    super.initState();
  }

  bool get isLiked =>
      likesBox.get('liked_${widget.index}', defaultValue: false);

  void toggleLike() {
    likesBox.put('liked_${widget.index}', !isLiked);
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
            builder: (context) => DetailScreen(
              data: widget.data[widget.index],
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
                    Image.network(widget.data[widget.index].imageUrl),
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
                                ? 'assets/icons/unliked.svg'
                                : 'assets/icons/liked.svg',
                          )),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    widget.data[widget.index].name,
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
