import 'package:sheduler/models/day_shedule.dart';
import 'package:sheduler/models/shedule.dart';

final mondaySchedule = DaySchedule(
  day: 'Понедельник',
  lessons: [
    Schedule(
      type: 'Лекции',
      name: 'Методы построения трансляторов',
      teacherName: 'Кушнир Надежда Владимировна',
      audience: 'К-321',
      startLess: const Duration(hours: 15, minutes: 0),
      endLess: const Duration(hours: 16, minutes: 30),
    ),

    Schedule(
      type: 'Лабораторные занятия',
      name: 'Методы построения трансляторов',
      teacherName: 'Кушнир Надежда Владимировна',
      audience: 'К-308',
      startLess: const Duration(hours: 16, minutes: 40),
      endLess: const Duration(hours: 18, minutes: 10),
    ),

  ],
);

final tuesdaySchedule = DaySchedule(
  day: 'Вторник',
  lessons: [
    Schedule(
      type: 'Лабораторные занятия',
      name: 'Системы искусственного интеллекта',
      teacherName: 'Тотухов Константин Евгеньевич',
      audience: 'К-310',
      startLess: const Duration(hours: 8, minutes: 0),
      endLess: const Duration(hours: 9, minutes: 30),
    ),

    Schedule(
      type: 'Лекции',
      name: 'Разработка мобильных приложений',
      teacherName: 'Мурлин Алексей Георгиевич',
      audience: 'К-159',
      startLess: const Duration(hours: 9, minutes: 40),
      endLess: const Duration(hours: 11, minutes: 10),
    ),

    Schedule(
      type: 'Лекции',
      name: 'Системы искусственного интеллекта',
      teacherName: 'Тотухов Константин Евгеньевич',
      audience: 'К-215',
      startLess: const Duration(hours: 11, minutes: 20),
      endLess: const Duration(hours: 12, minutes: 50),
    ),
  ],
);

final wednesdaySchedule = DaySchedule(
  day: 'Среда',
  lessons: [
    Schedule(
      type: 'Лабораторные занятия',
      name: 'Разработка мобильных приложений',
      teacherName: 'Мурлин Алексей Георгиевич',
      audience: 'К-301',
      startLess: const Duration(hours: 8, minutes: 0),
      endLess: const Duration(hours: 9, minutes: 30),

    ),
    Schedule(
      type: 'Лабораторные занятия',
      name: 'Разработка мобильных приложений',
      teacherName: 'Мурлин Алексей Георгиевич',
      audience: 'К-301',
      startLess: const Duration(hours: 9, minutes: 40),
      endLess: const Duration(hours: 11, minutes: 10),

    ),
    Schedule(
      type: 'Лекции',
      name: 'Правовое обеспечение профессиональной деятельности',
      teacherName: 'Степаненко Сергей Григорьевич',
      audience: 'К-235',
      startLess: const Duration(hours: 11, minutes: 20),
      endLess: const Duration(hours: 12, minutes: 50),

    ),
    Schedule(
      type: 'Практические занятия',
      name: 'Правовое обеспечение профессиональной деятельности',
      teacherName: 'Степаненко Сергей Григорьевич',
      audience: 'К-202',
      startLess: const Duration(hours: 13, minutes: 20),
      endLess: const Duration(hours: 14, minutes: 50),
    ),
  ],
);

final thursdaySchedule = DaySchedule(
  day: 'Четверг',
  lessons: [
    Schedule(
      type: 'Лабораторные занятия',
      name: 'Параллельное программирование',
      teacherName: 'Арбузов Алексей Сергеевич',
      audience: 'К-304',
      startLess: const Duration(hours: 13, minutes: 20),
      endLess: const Duration(hours: 14, minutes: 50),
    ),
    Schedule(
      type: 'Лабораторные занятия',
      name: 'Параллельное программирование',
      teacherName: 'Арбузов Алексей Сергеевич',
      audience: 'К-304',
      startLess: const Duration(hours: 15, minutes: 0),
      endLess: const Duration(hours: 16, minutes: 30),
    ),
    Schedule(
      type: 'Лабораторные занятия',
      name: 'Системы искусственного интеллекта',
      teacherName: 'Тотухов Константин Евгеньевич',
      audience: 'К-304',
      startLess: const Duration(hours: 16, minutes: 40),
      endLess: const Duration(hours: 18, minutes: 10),
    ),
    Schedule(
      type: 'Лабораторные занятия',
      name: 'Основы робототехники',
      teacherName: 'Тотухов Константин Евгеньевич',
      audience: 'К-304',
      startLess: const Duration(hours: 18, minutes: 20),
      endLess: const Duration(hours: 19, minutes: 50),
    ),
  ],
);

final fridaySchedule = DaySchedule(day: "Пятница", lessons: [
  Schedule(
      type: 'Лабораторные занятия',
      name: 'Методы построения трансляторов',
      teacherName: 'Кушнир Надежда Владимировна',
      audience: 'К-308',
      startLess: const Duration(hours: 8, minutes: 0),
      endLess: const Duration(hours: 9, minutes: 30),
    ),
    Schedule(
      type: 'Лабораторные занятия',
      name: 'Методы построения трансляторов',
      teacherName: 'Кушнир Надежда Владимировна',
      audience: 'К-308',
      startLess: const Duration(hours: 9, minutes: 40),
      endLess: const Duration(hours: 11, minutes: 10),
    ),
    Schedule(
      type: 'Лекции',
      name: 'Параллельное программирование',
      teacherName: 'Арбузов Алексей Сергеевич',
      audience: 'К-159',
      startLess: const Duration(hours: 11, minutes: 20),
      endLess: const Duration(hours: 12, minutes: 50),
    ),
    Schedule(
      type: 'Лекции',
      name: 'Основы робототехники',
      teacherName: 'Тотухов Константин Евгеньевич',
      audience: 'К-159',
      startLess: const Duration(hours: 13, minutes: 20),
      endLess: const Duration(hours: 14, minutes: 50),
    ),
]);

final saturdaySchedule = DaySchedule(
  day: 'Суббота',
  lessons: [],
);

final sundaySchedule = DaySchedule(day: "Воскресенье", lessons: []);
