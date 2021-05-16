import 'package:app_qldt/_widgets/data_table/data_table.dart';
import 'package:app_qldt/_widgets/model/user_data_model.dart';
import 'package:app_qldt/exam_schedule/bloc/exam_schedule_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

class ExamScheduleTable extends StatefulWidget {
  final ScrollControllers scrollControllers;

  const ExamScheduleTable({Key? key, required this.scrollControllers}) : super(key: key);

  @override
  _ExamScheduleTableState createState() => _ExamScheduleTableState();
}

class _ExamScheduleTableState extends State<ExamScheduleTable> {
  static final List<double> columnWidths = [105, 210, 120, 110, 110, 90];

  static final List<String> columnTitles = [
    'Ngày thi',
    'Giờ thi',
    'Số báo danh',
    'Phòng',
    'Hình thức',
    'Số tín chỉ',
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.white),
          ),
        ),
        child: BlocBuilder<ExamScheduleBloc, ExamScheduleState>(
          buildWhen: (previous, current) => previous.examScheduleData != current.examScheduleData,
          builder: (context, state) {
            return MyDataTable(
              scrollControllers: widget.scrollControllers,
              columnTitles: columnTitles,
              columnWidths: columnWidths,
              data: UserDataModel.of(context)
                  .localExamScheduleService
                  .getExamScheduleOfSemester(state.semester),
            );
          },
        ),
      ),
    );
  }
}
