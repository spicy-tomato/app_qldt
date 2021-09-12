import 'package:app_qldt/blocs/crawler/crawler_bloc.dart';
import 'package:app_qldt/widgets/component/item.dart';
import 'package:app_qldt/widgets/wrapper/shared_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'local_widgets/local_widgets.dart';

class RequestQldtPasswordPage extends StatefulWidget {
  const RequestQldtPasswordPage({Key? key}) : super(key: key);

  @override
  _RequestQldtPasswordPageState createState() => _RequestQldtPasswordPageState();
}

class _RequestQldtPasswordPageState extends State<RequestQldtPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return SharedUI(
      stable: false,
      child: BlocListener<CrawlerBloc, CrawlerState>(
        listener: (BuildContext context, state) {
          if (state.status.isFailed) {
            showDialog(
              context: context,
              builder: (_) => ServerErrorDialog(rootContext: context),
            );
          } else if (state.status.hasErrorWhileCrawling) {
            showDialog(
              context: context,
              builder: (_) => CrawlErrorDialog(rootContext: context),
            );
          }
        },
        child: Item(
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Instructor(),
                  const SizedBox(height: 10),
                  const QldtInputPassword(),
                  const SizedBox(height: 15),
                  QldtConfirmButton(),
                  const SizedBox(height: 25),
                  const QldtNote(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
