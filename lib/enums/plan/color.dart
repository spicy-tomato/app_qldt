part of 'plan_enum.dart';

enum PlanColors {
  tomato,
  tangerine,
  banana,
  basil,
  sage,
  peacock,
  blueberry,
  lavender,
  grape,
  flamingo,
  graphite,
  defaultColor
}

extension PlanColorsExtension on PlanColors {
  static String stringFunction(PlanColors color) {
    return color.string;
  }

  static Color colorFunction(PlanColors color) {
    return color.color;
  }

  String get string {
    switch (this) {
      case PlanColors.tomato:
        return 'Màu cà chua';

      case PlanColors.tangerine:
        return 'Màu vỏ quýt';

      case PlanColors.banana:
        return 'Màu chuối';

      case PlanColors.basil:
        return 'Màu húng quế';

      case PlanColors.sage:
        return 'Màu lá mạ';

      case PlanColors.peacock:
        return 'Màu lông công';

      case PlanColors.blueberry:
        return 'Màu việt quất';

      case PlanColors.lavender:
        return 'Màu oải hương';

      case PlanColors.grape:
        return 'Màu nho';

      case PlanColors.flamingo:
        return 'Màu hồng hạc';

      case PlanColors.graphite:
        return 'Màu khói';

      default:
        return 'Màu mặc định';
    }
  }

  Color get color {
    switch (this) {
      case PlanColors.tomato:
        return const Color(0xffff3d1e);

      case PlanColors.tangerine:
        return const Color(0xfff28500);

      case PlanColors.banana:
        return const Color(0xfff8cf0e);

      case PlanColors.basil:
        return const Color(0xff579229);

      case PlanColors.sage:
        return const Color(0xff32CD32);

      case PlanColors.peacock:
        return const Color(0xff007bff);

      case PlanColors.blueberry:
        return const Color(0xff464196);

      case PlanColors.lavender:
        return const Color(0xffbaa2fd);

      case PlanColors.grape:
        return const Color(0xff8d2da8);

      case PlanColors.flamingo:
        return const Color(0xfffc8eac);

      case PlanColors.graphite:
        return const Color(0xff848884);

      default:
        return const Color(0xff007bff);
    }
  }
}

extension IntToPlanColors on int {
  PlanColors toPlanColors() {
    switch (this) {
      case 0xffff6347:
        return PlanColors.tomato;

      case 0xfff28500:
        return PlanColors.tangerine;

      case 0xffffe135:
        return PlanColors.banana;

      case 0xff579229:
        return PlanColors.basil;

      case 0xff32CD32:
        return PlanColors.sage;

      case 0xff007bff:
        return PlanColors.peacock;

      case 0xff464196:
        return PlanColors.blueberry;

      case 0xffbaa2fd:
        return PlanColors.lavender;

      case 0xff8d2da8:
        return PlanColors.grape;

      case 0xfffc8eac:
        return PlanColors.flamingo;

      case 0xff848884:
        return PlanColors.graphite;

      default:
        return PlanColors.defaultColor;
    }
  }
}
