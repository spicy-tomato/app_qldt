part of 'local_widgets.dart';

class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = context.read<PlanBloc>().state.location;
    _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
  }

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      leading: const Icon(Icons.location_on_outlined),
      title: TextField(
        controller: _controller,
        onChanged: _onChanged,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Vị trí',
        ),
      ),
    );
  }

  void _onChanged(String text) {
    context.read<PlanBloc>().add(PlanLocationChanged(text));
  }
}
