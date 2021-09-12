part of 'local_widgets.dart';

class PlanColor extends StatefulWidget {
  const PlanColor({Key? key}) : super(key: key);

  @override
  _PlanColorState createState() => _PlanColorState();
}

class _PlanColorState extends State<PlanColor> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlanBloc, PlanState>(
      buildWhen: (previous, current) => previous.color != current.color,
      builder: (context, state) {
        return CustomListTile(
          leading: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: state.color.color,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          title: Text(state.color.string),
          onTap: () async {
            await showDialog(
              context: context,
              builder: (_) {
                return RadioAlertDialog<PlanColors>(
                  optionsList: PlanColors.values,
                  currentOption: state.color,
                  stringFunction: PlanColorsExtension.stringFunction,
                  onSelect: _onSelect,
                  radioColorFunction: PlanColorsExtension.colorFunction,
                );
              },
            );
          },
        );
      },
    );
  }

  void _onSelect(PlanColors color) {
    context.read<PlanBloc>().add(PlanColorChanged(color));
    Navigator.of(context).pop();
  }
}
