import 'package:shedule_app/models/day_shedule.dart';
import 'package:shedule_app/models/shedule.dart';

final mondayScheduleOdd = DaySchedule(
  day: 'Понедельник',
  lessons: [
    Schedule(
      type: 'Лабораторные занятия',
      name: 'Рефакторинг и работа с унаследованным кодом',
      teacherName: 'Степанова Елизавета Владимировна',
      audience: 'К-310',
      startLess: Duration(hours: 8, minutes: 0),
      endLess: Duration(hours: 9, minutes: 30),
    ),
    Schedule(
      type: 'Лабораторные занятия',
      name: 'Рефакторинг и работа с унаследованным кодом',
      teacherName: 'Степанова Елизавета Владимировна',
      audience: 'К-310',
      startLess: Duration(hours: 9, minutes: 40),
      endLess: Duration(hours: 11, minutes: 10),
    ),
    Schedule(
      type: 'Лабораторные занятия',
      name: 'Методы оптимизации',
      teacherName: 'Попова Ольга Борисовна',
      audience: 'К-310',
      startLess: Duration(hours: 11, minutes: 20),
      endLess: Duration(hours: 12, minutes: 50),
    ),
  ],
);

final tuesdayScheduleOdd = DaySchedule(
  day: 'Вторник',
  lessons: [
    Schedule(
      type: 'Лабораторные занятия',
      name: 'Компьютерное моделирование',
      teacherName: 'Лубенцова Елена Валерьевна',
      audience: 'К-301',
      startLess: Duration(hours: 8, minutes: 0),
      endLess: Duration(hours: 9, minutes: 30),
    ),
    Schedule(
      type: 'Лабораторные занятия',
      name: 'Компьютерное моделирование',
      teacherName: 'Лубенцова Елена Валерьевна',
      audience: 'К-301',
      startLess: Duration(hours: 9, minutes: 40),
      endLess: Duration(hours: 11, minutes: 10),
    ),
    Schedule(
      type: 'Лабораторные занятия',
      name: 'Компьютерное моделирование',
      teacherName: 'Лубенцова Елена Валерьевна',
      audience: 'К-159',
      startLess: Duration(hours: 11, minutes: 20),
      endLess: Duration(hours: 12, minutes: 50),
    ),
  ],
);

final wednesdayScheduleOdd = DaySchedule(
  day: 'Среда',
  lessons: [
    Schedule(
      type: 'Лекции',
      name: 'Системное программирование',
      teacherName: 'Мурлин Алексей Георгиевич',
      audience: 'К-247',
      startLess: Duration(hours: 9, minutes: 40),
      endLess: Duration(hours: 11, minutes: 10),
    ),
    Schedule(
      type: 'Лабораторные занятия',
      name: 'Теория автоматов и формальных языков',
      teacherName: 'Кушнир Надежда Владимировна',
      audience: 'К-305',
      startLess: Duration(hours: 11, minutes: 20),
      endLess: Duration(hours: 12, minutes: 50),
    ),
    Schedule(
      type: 'Лабораторные занятия',
      name: 'Методы оптимизации',
      teacherName: 'Попова Ольга Борисовна',
      audience: 'К-301',
      startLess: Duration(hours: 13, minutes: 20),
      endLess: Duration(hours: 14, minutes: 50),
    ),
    Schedule(
      type: 'Лабораторные занятия',
      name: 'Алгоритмы компьютерной графики',
      teacherName: 'Кузякина Марина Викторовна',
      audience: 'К-304',
      startLess: Duration(hours: 15, minutes: 0),
      endLess: Duration(hours: 16, minutes: 30),
    ),
  ],
);
final thursdayScheduleOdd = DaySchedule(
  day: 'Четверг',
  lessons: [
    Schedule(
      type: 'Практические занятия',
      name: 'Физическая культура и спорт',
      teacherName: 'Синельникова Наталья Александровна',
      audience: 'Ф-Спортивный комплекс',
      startLess: Duration(hours: 13, minutes: 20),
      endLess: Duration(hours: 14, minutes: 50),
    ),
    Schedule(
      type: 'Лекции',
      name: 'Алгоритмы компьютерной графики',
      teacherName: 'Кузякина Марина Викторовна',
      audience: 'А-506',
      startLess: Duration(hours: 15, minutes: 0),
      endLess: Duration(hours: 16, minutes: 30),
    ),
  ],
);

final fridayScheduleOdd = DaySchedule(
  day: 'Пятница',
  lessons: [
    Schedule(
      type: 'Лекции',
      name: 'Методы оптимизации',
      teacherName: 'Попова Ольга Борисовна',
      audience: 'К-159',
      startLess: Duration(hours: 13, minutes: 20),
      endLess: Duration(hours: 14, minutes: 50),
    ),
    Schedule(
      type: 'Лекции',
      name: 'Методы оптимизации',
      teacherName: 'Попова Ольга Борисовна',
      audience: 'К-159',
      startLess: Duration(hours: 15, minutes: 0),
      endLess: Duration(hours: 16, minutes: 30),
    ),
  ],
);

final saturdayScheduleOdd = DaySchedule(
  day: 'Суббота',
  lessons: [
    Schedule(
      type: 'Лабораторные занятия',
      name: 'Коллективная разработка и управление программными проектами',
      teacherName: 'Зайков Владимир Полиевктович',
      audience: 'К-301',
      startLess: Duration(hours: 9, minutes: 40),
      endLess: Duration(hours: 11, minutes: 10),
    ),
    Schedule(
      type: 'Лекции',
      name: 'Рефакторинг и работа с унаследованным кодом',
      teacherName: 'Волик Александр Георгиевич',
      audience: 'К-215',
      startLess: Duration(hours: 11, minutes: 20),
      endLess: Duration(hours: 12, minutes: 50),
    ),
  ],
);

final sundayScheduleOdd = DaySchedule(day: "Воскресенье", lessons: []);
