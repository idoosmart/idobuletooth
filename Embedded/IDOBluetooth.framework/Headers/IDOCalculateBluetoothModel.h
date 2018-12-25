//
//  IDOCalculateBluetoothModel.h
//  IDOBluetooth
//
//  Created by 何东阳 on 2018/10/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IDOBluetooth/IDOSyncInfoBluetoothModel.h>

struct ido_blood_pressure_data
{
    uint32_t sysBlood;
    uint32_t diasBlood;
};

@interface IDOCalculateBluetoothModel : NSObject

@end

@interface IDOCalculateBpBluetoothModel : NSObject

/**
 记录血压日期时间戳 | Record blood pressure date time stamp
 */
@property (nonatomic,copy) NSString * dateStr;

/**
 最大血压值 struct | Maximum blood pressure value
 */
@property (nonatomic,assign) struct ido_blood_pressure_data maxBp;

/**
 最小血压值 struct | Minimum blood pressure value
 */
@property (nonatomic,assign) struct ido_blood_pressure_data  minBp;

/**
 平均血压值 struct | Average blood pressure value
 */
@property (nonatomic,assign) struct ido_blood_pressure_data  avgBp;

/**
 最新血压值 struct | Latest blood pressure value
 */
@property (nonatomic,assign) struct ido_blood_pressure_data lastBp;

/**
 计算一天血压平均值 | Calculate the average blood pressure per day
 */
+ (__kindof IDOCalculateBpBluetoothModel *)calculateOneDayBpDataWithBpModel:(__kindof IDOSyncBpDataInfoBluetoothModel *)model;

/**
 计算一周、一月血压平均值 | Calculate the average blood pressure for one week and one month
 */
+ (__kindof IDOCalculateBpBluetoothModel *)calculateOneMonthOrWeekBpDataWithBpModels:(NSArray <__kindof IDOSyncBpDataInfoBluetoothModel *>*)models
                                                             allDayCalculateBpModels:(NSArray <IDOCalculateBpBluetoothModel *> **)calculateBpModels;

@end


@interface IDOCalculateHrBluetoothModel : NSObject

/**
 平均心率 | Average heart rate
 */
@property (nonatomic,assign) NSInteger avgHr;

/**
 最大心率 | Maximum heart rate
 */
@property (nonatomic,assign) NSInteger maxHr;

/**
 最小心率 | Most careful rate
 */
@property (nonatomic,assign) NSInteger minHr;

/**
 脂肪燃烧时长 (单位 ：分钟) | Fat burning time (unit: minute)
 */
@property (nonatomic,assign) NSUInteger burnFatMins;

/**
 肌肉锻炼时长 (单位 ：分钟) | Muscle training time (unit: minute)
 */
@property (nonatomic,assign) NSUInteger aerobicMins;

/**
 极限运动时长 (单位 ：分钟) | Extreme Sports Duration (Unit: Minutes)
 */
@property (nonatomic,assign) NSUInteger limitMins;

/**
 计算一天心率平均值 | Calculate the average heart rate per day
 */
+ (__kindof IDOCalculateHrBluetoothModel *)calculateOneDayHrDataWithHrModel:(__kindof IDOSyncHrDataInfoBluetoothModel *)model;
/**
 计算一周、一月心率平均值 | Calculate the heart rate average for one week and one month
 */
+ (__kindof IDOCalculateHrBluetoothModel *)calculateOneMonthOrWeekHrDataWithHrModels:(NSArray <__kindof IDOSyncHrDataInfoBluetoothModel *>*)models;
/**
 计算一年心率平均值 | Calculate the annual heart rate average
 */
+ (__kindof IDOCalculateHrBluetoothModel *)calculateOneYearHrDataWithHrModels:(NSArray <NSArray<__kindof IDOSyncHrDataInfoBluetoothModel *>*> *)models;

@end

@interface IDOCalculateSleepBluetoothModel : NSObject

/**
 平均一天睡眠时长 (单位 ：分钟) | Average one-day sleep duration (in minutes)
 */
@property (nonatomic,assign) NSInteger avgSleep;

/**
 平均一天深睡眠时长 (单位 ：分钟) | Average one-day deep sleep duration (unit: minute)
 */
@property (nonatomic,assign) NSInteger avgDeepSleep;

/**
 平均一天浅睡眠时长 (单位 ：分钟) | Average day light sleep duration (unit: minute)
 */
@property (nonatomic,assign) NSInteger avgLightSleep;

/**
 平均一天醒来时长 (单位 ：分钟) | Average wake-up time of one day (unit: minute)
 */
@property (nonatomic,assign) NSInteger avgWakeSleep;

/**
 平均入睡时间点 （格式 ：00:00） | Average sleep time (format: 00:00)
 */
@property (nonatomic,copy) NSString * sleepTime;

/**
 平均醒来时间点（格式 ：00:00） | Average wake-up time (format: 00:00)
 */
@property (nonatomic,copy) NSString * wakeTime;

/**
 计算一天睡眠平均值 | Calculate the average daily sleep
 */
+ (__kindof IDOCalculateSleepBluetoothModel *)calculateOneDaySleepDataWithSleepModel:(__kindof IDOSyncSleepDataInfoBluetoothModel *)model;

/**
 计算-周、一月睡眠平均值 | Calculation - Week, January sleep average
 */
+ (__kindof IDOCalculateSleepBluetoothModel *)calculateOneMonthOrWeekSleepDataWithSleepModels:(NSArray <__kindof IDOSyncSleepDataInfoBluetoothModel *>*)models;

/**
 计算一年睡眠平均值 | Calculate the average sleep value for one year
 */
+ (__kindof IDOCalculateSleepBluetoothModel *)calculateOneYearSleepDataWithSleepModels:(NSArray <NSArray<__kindof IDOSyncSleepDataInfoBluetoothModel *>*> *)models;

@end

@interface IDOCalculateSportBluetoothModel : NSObject

/**
 总运动里程（单位 ：米） | Total mileage (in meters)
 */
@property (nonatomic,assign) NSInteger totalMileage;

/**
 总步数 （单位 ：步数） | Total steps (unit: steps)
 */
@property (nonatomic,assign) NSInteger totalStep;

/**
 总卡路里 （单位 ：大卡） | Total calories (unit: big card)
 */
@property (nonatomic,assign) NSInteger totalCalories;

/**
 平均里程（单位 ：米） | Average mileage (in meters)
 */
@property (nonatomic,assign) NSInteger avgMileage;

/**
 平均步数（单位 ：步数） | Average steps (unit: steps)
 */
@property (nonatomic,assign) NSInteger avgStep;

/**
 平均卡路里（单位 ：大卡） | Average calories (unit: big card)
 */
@property (nonatomic,assign) NSInteger avgCalories;

/**
 计算一天步数平均值 | Calculate the average number of steps per day
 */
+ (__kindof IDOCalculateSportBluetoothModel *)calculateOneDaySportDataWithSportModel:(__kindof IDOSyncSportDataInfoBluetoothModel *)model;

/**
 计算-周、一月步数平均值 | Calculation - Week, January Step Average
 */
+ (__kindof IDOCalculateSportBluetoothModel *)calculateOneMonthOrWeekSportDataWithSportModels:(NSArray <__kindof IDOSyncSportDataInfoBluetoothModel *>*)models;

/**
 计算一年步数平均值 | Calculate the average number of steps in a year
 */
+ (__kindof IDOCalculateSportBluetoothModel *)calculateOneYearSportDataWithSportModels:(NSArray <NSArray<__kindof IDOSyncSportDataInfoBluetoothModel *>*> *)models;

@end


