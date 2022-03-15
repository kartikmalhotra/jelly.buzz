import 'package:flutter/material.dart';
import 'package:task_app/shared/model/model.dart';

class PhotoAppCard extends StatelessWidget {
  final double height;
  final Photo photoes;
  final VoidCallback callback;

  const PhotoAppCard({
    Key? key,
    required this.photoes,
    required this.height,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Card(
        child: Container(
          height: height,
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    border: Border.all(width: 0.1),
                    image: !(photoes.url?.contains("null") ?? true)
                        ? DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: NetworkImage("${photoes.url}"),
                          )
                        : null,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  photoes.title ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PostAppCard extends StatelessWidget {
  final double width;
  final Post post;
  final VoidCallback callback;

  const PostAppCard({
    Key? key,
    required this.post,
    required this.width,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                post.title ?? "",
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              if (post.body?.isNotEmpty ?? false) ...[
                const SizedBox(height: 20.0),
                Text(
                  post.body ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.grey[600]),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class AppCircularProgressLoader extends StatelessWidget {
  final double? value;

  const AppCircularProgressLoader({Key? key, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
        color: const Color(0xFF0C54BE), value: value);
  }
}
