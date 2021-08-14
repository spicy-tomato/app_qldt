part of 'local_widgets.dart';

class Accessibility extends StatefulWidget {
  const Accessibility({Key? key}) : super(key: key);

  @override
  _AccessibilityState createState() => _AccessibilityState();
}

class _AccessibilityState extends State<Accessibility> {
  late String display = 'Mặc định';
  final List _listItem = ['Công khai', 'Mặc định', 'Riêng tư'];

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      leading: const Icon(Icons.lock_outline),
      title: DropdownButton(
        dropdownColor: Colors.grey,
        style: const TextStyle(color: Colors.black, fontSize: 22.0),
        elevation: 5,
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 36.0,
        isExpanded: true,
        value: display,
        onChanged: (newValue) {
          setState(() {
            display = newValue.toString();
          });
        },
        items: _listItem.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
      ),
    );
  }
}
