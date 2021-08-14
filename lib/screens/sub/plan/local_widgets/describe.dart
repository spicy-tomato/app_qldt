part of 'local_widgets.dart';

class Describe extends StatefulWidget {
  const Describe({Key? key}) : super(key: key);

  @override
  _DescribeState createState() => _DescribeState();
}

class _DescribeState extends State<Describe> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = context.read<PlanBloc>().state.description;
    _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
  }

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      leading: const Icon(Icons.dehaze_outlined),
      title: TextField(
        controller: _controller,
        onChanged: _onChanged,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Mô tả',
        ),
      ),
    );
  }

  void _onChanged(String text) {
    context.read<PlanBloc>().add(PlanDescriptionChanged(text));
  }
}
