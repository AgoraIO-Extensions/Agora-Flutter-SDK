import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef ExampleActionsBuilder = Widget Function(
    BuildContext context, bool isLayoutHorizontal);

class ExampleActionsWidget extends StatelessWidget {
  const ExampleActionsWidget({
    Key? key,
    required this.displayContentBuilder,
    this.actionsBuilder,
  }) : super(key: key);

  final ExampleActionsBuilder displayContentBuilder;

  final ExampleActionsBuilder? actionsBuilder;

  @override
  Widget build(BuildContext context) {
    final mediaData = MediaQuery.of(context);
    final bool isLayoutHorizontal = mediaData.size.aspectRatio >= 1.5 ||
        (kIsWeb ||
            !(defaultTargetPlatform == TargetPlatform.android ||
                defaultTargetPlatform == TargetPlatform.iOS));

    if (actionsBuilder == null) {
      return displayContentBuilder(context, isLayoutHorizontal);
    }

    const actionsTitle = Text(
      'Actions',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
    );

    if (isLayoutHorizontal) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    actionsTitle,
                    actionsBuilder!(context, isLayoutHorizontal),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors.grey.shade100,
            width: 20,
          ),
          Expanded(
            flex: 2,
            child: displayContentBuilder(context, isLayoutHorizontal),
          ),
        ],
      );
    }

    return Stack(
      children: [
        SizedBox.expand(
          child: Container(
            padding: const EdgeInsets.only(bottom: 150),
            child: displayContentBuilder(context, isLayoutHorizontal),
          ),
        ),
        DraggableScrollableSheet(
          initialChildSize: 0.25,
          snap: true,
          maxChildSize: 0.7,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 253, 253, 253),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.0),
                    topRight: Radius.circular(24.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20.0,
                      color: Colors.grey,
                    ),
                  ]),
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    actionsTitle,
                    actionsBuilder!(context, isLayoutHorizontal),
                  ],
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
