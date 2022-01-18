import 'dart:math';
import 'package:flibrary/components/opds/searchBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flibrary/stores/opds/opds.dart';
import 'package:flibrary/components/opds/entry.dart';

class Opds extends ConsumerWidget {
  const Opds({Key? key}) : super(key: key);

  @override
  build(BuildContext context, WidgetRef ref) {
    final opdsState = ref.watch(opdsProvider);
    
    return Container(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: min(MediaQuery.of(context).size.width, 1024),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    splashRadius: 16,
                    onPressed: opdsState.goPrevPath,
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Expanded(child: Text(opdsState.pathTitle)),
                  IconButton(
                    splashRadius: 16,
                    onPressed: opdsState.goNextPage,
                    icon: const Icon(Icons.arrow_forward),
                  ),
                ],
              ),
              SearchBox(onSubmit: opdsState.search),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(top: 6) ,
                  children: opdsState.entries.map((element) => Entry(element: element, onClick: opdsState.goToPath)).toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}