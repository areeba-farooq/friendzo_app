import 'package:flutter/material.dart';
import 'package:friendzo_app/Models/user_model.dart';
import 'package:friendzo_app/Providers/user_provider.dart';
import 'package:friendzo_app/Utils/colors.dart';
import 'package:friendzo_app/Widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({Key? key, this.snap}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;

  @override
  Widget build(BuildContext context) {
    final UserModel user = Provider.of<UserProvider>(context).getUser;
    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(children: [
        ///********************HEADER SECTION**************************
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(widget.snap['profileImg']),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.snap['username'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: ListView(
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            children: ['Delete']
                                .map(
                                  (e) => InkWell(
                                    onTap: () {},
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 16),
                                      child: Text(e.toString()),
                                    ),
                                  ),
                                )
                                .toList()),
                      ),
                    );
                  },
                  icon: const Icon(Icons.more_vert))
            ],
          ),
        ),

        ///********************IMAGE SECTION**************************
        GestureDetector(
          onDoubleTap: () {
            setState(() {
              isLikeAnimating = true;
            });
          },
          child: Stack(alignment: Alignment.center, children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              width: double.infinity,
              child: Image.network(
                widget.snap['postUrl'],
                fit: BoxFit.cover,
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: isLikeAnimating ? 1 : 0,
              child: LikesAnimation(
                child: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 200,
                ),
                isAnimating: isLikeAnimating,
                duration: const Duration(milliseconds: 400),
                onEnd: () {
                  setState(() {
                    isLikeAnimating = false;
                  });
                },
              ),
            )
          ]),
        ),

        ///********************LIKES, COMMENT,SHARE SECTION**************************
        Row(
          children: [
            LikesAnimation(
              isAnimating: widget.snap['likes']
                  .contains(user.uid), //checking if it has user.uid
              smallLike: true,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border_outlined),
              ),
            ),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.comment_outlined)),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.send),
            ),
            Expanded(
                child: Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.bookmark_border_outlined),
              ),
            ))
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              '${widget.snap['likes'].length} likes',
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500),
            ),
            Container(
              padding: const EdgeInsets.only(top: 8),
              width: double.infinity,
              child: RichText(
                  text: TextSpan(
                      style: const TextStyle(color: Colors.white),
                      children: [
                    TextSpan(
                        text: widget.snap['username'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    TextSpan(text: '  ${widget.snap['description']}')
                  ])),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                child: const Text(
                  'View all 40 comments',
                  style: TextStyle(color: Colors.white60, fontSize: 16),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              width: double.infinity,
              child: Text(
                DateFormat.yMMMMd().format(
                  widget.snap['datePublished'].toDate(),
                ),
                style: const TextStyle(color: Colors.white60),
              ),
            ),
          ]),
        )
      ]),
    );
  }
}
