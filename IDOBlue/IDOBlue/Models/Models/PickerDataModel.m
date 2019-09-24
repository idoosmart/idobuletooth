//
//  PickerDataModel.m
//  IDOBlue
//
//  Created by hedongyang on 2018/9/28.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "PickerDataModel.h"
#import "IDODemoUtility.h"

@implementation PickerDataModel
- (NSArray *)tenThousandArray
{
    if (!_tenThousandArray) {
        NSMutableArray * array = [NSMutableArray array];
        for (int i = 1; i <= 10; i++) {
            [array addObject:@(i * 10000)];
        }
        _tenThousandArray = array;
    }
    return _tenThousandArray;
}

- (NSArray *)thousandArray
{
    if (!_thousandArray) {
        NSMutableArray * array = [NSMutableArray array];
        for (int i = 1; i <= 10; i++) {
            [array addObject:@(i * 1000)];
        }
        _thousandArray = array;
    }
    return _thousandArray;
}

- (NSArray *)hundredArray
{
    if (!_hundredArray) {
        NSMutableArray * array = [NSMutableArray array];
        for (int i = 1; i <= 100; i++) {
            [array addObject:@(i)];
        }
        _hundredArray = array;
    }
    return _hundredArray;
}

- (NSArray *)bpArray
{
    if (!_bpArray) {
        NSMutableArray * array = [NSMutableArray array];
        for (int i = 50; i <= 300; i++) {
            [array addObject:@(i)];
        }
        _bpArray = array;
    }
    return _bpArray;
}

- (NSArray *)tenArray
{
    if (!_tenArray) {
        NSMutableArray * array = [NSMutableArray array];
        for (int i = 0; i <= 10; i++) {
            [array addObject:@(i)];
        }
        _tenArray = array;
    }
    return _tenArray;
}

- (NSArray *)heightArray
{
    if (!_heightArray) {
        NSMutableArray * heightArray = [NSMutableArray array];
        for (int i = 100; i< 250; i++) {
            [heightArray addObject:@(i)];
        }
        _heightArray = heightArray;
    }
    return _heightArray;
}

- (NSArray *)weightArray
{
    if (!_weightArray) {
        NSMutableArray * weightArray = [NSMutableArray array];
        for (int i = 20; i< 200; i++) {
            [weightArray addObject:@(i)];
        }
        _weightArray = weightArray;
    }
    return _weightArray;
}

- (NSArray *)hrArray
{
    if (!_hrArray) {
        NSMutableArray * hrArray = [NSMutableArray array];
        for (int i = 50; i<= 300; i++) {
            [hrArray addObject:@(i)];
        }
        _hrArray = hrArray;
    }
    return _hrArray;
}

- (NSArray *)hourArray
{
    if (!_hourArray) {
        NSMutableArray * hourArray = [NSMutableArray array];
        for (int i = 0; i< 24; i++) {
            [hourArray addObject:@(i)];
        }
        _hourArray = hourArray;
    }
    return _hourArray;
}

- (NSArray *)minuteArray
{
    if (!_minuteArray) {
        NSMutableArray * minuteArray = [NSMutableArray array];
        for (int i = 0; i< 60; i++) {
            [minuteArray addObject:@(i)];
        }
        _minuteArray = minuteArray;
    }
    return _minuteArray;
}

- (NSArray *)tempArray
{
    if (!_tempArray) {
        NSMutableArray * tempArray = [NSMutableArray array];
        for (int i = -50; i <= 60; i ++) {
            [tempArray addObject:@(i)];
        }
        _tempArray = tempArray;
    }
    return _tempArray;
}

- (NSArray *)screenModeArray
{
    if (!_screenModeArray) {
        _screenModeArray = @[lang(@"turn off auto tune"),lang(@"use ambient light sensors"),
                             lang(@"auto brightness at night"),lang(@"set time for night dimming")];
    }
    return _screenModeArray;
}

- (NSArray *)goalTypeArray
{
    if (!_goalTypeArray) {
        _goalTypeArray = @[lang(@"target step"),lang(@"target calories"),lang(@"target distance")];
    }
    return _goalTypeArray;
}

- (NSArray *)weekArray
{
    if (!_weekArray) {
        _weekArray = @[lang(@"monday"),lang(@"tuesday"),lang(@"wednesday"),lang(@"thursday"),lang(@"friday"),lang(@"saturday"),lang(@"sunday")];
    }
    return _weekArray;
}

- (NSArray *)typeArray
{
    if (!_typeArray) {
        _typeArray = @[lang(@"get up"),lang(@"sleep"),lang(@"exercise"),lang(@"take medicine"),lang(@"date"),lang(@"party"),lang(@"meeting"),lang(@"custom")];
    }
    return _typeArray;
}

- (NSArray *)notifyTitleArray
{
    if (!_notifyTitleArray) {
        _notifyTitleArray = @[@[lang(@"sub-switch"),lang(@"delay time"),lang(@"call reminder")],
                              @[lang(@"sms"),lang(@"email"),lang(@"wechat"),@"QQ",lang(@"sina weibo"),@"facebook",@"twitter"],
                              @[@"whatsapp",@"messenger",@"instagram",@"linked in",lang(@"calendar event"),@"skype",lang(@"alarm event"),@"pokeman"],
                              @[@"vkontakte",@"line",@"viber",@"kakaotalk",@"gmail",@"outlook",@"snapchat",@"telegram"],
                              @[@"chatwork",@"slack",@"yahoo mail",@"tumblr",@"youtube",@"yahoo pinterest"]];
    }
    return _notifyTitleArray;
}

- (NSArray *)weatherArray
{
    if (!_weatherArray) {
        _weatherArray =  @[lang(@"other"),lang(@"sunny days"),lang(@"cloudy1"),lang(@"cloudy2"),lang(@"rain1"),lang(@"rain2"),
                           lang(@"thunder storm"),lang(@"snow"),lang(@"snow rain"),lang(@"typhoon"),lang(@"sandstorm"),lang(@"shine at night"),
                           lang(@"cloudy at night"),lang(@"hot"),lang(@"cold"),lang(@"breezy"),lang(@"windy"),lang(@"misty"),lang(@"showers"),lang(@"cloudy to clear")];
    }
    return _weatherArray;
}

- (NSArray *)weatherTitleArray
{
    if (!_weatherTitleArray) {
        _weatherTitleArray = @[lang(@"current weather type:"),lang(@"current temperature:"),lang(@"current top temperature:"),
                               lang(@"current minimum temperature:"),lang(@"current humidity:"),lang(@"current uv intensity:"),lang(@"current air index:")];
    }
    return _weatherTitleArray;
}

- (NSArray *)hrModeArray
{
    if (!_hrModeArray) {
        _hrModeArray = @[lang(@"auto mode"),lang(@"manual mode"),lang(@"off")];
    }
    return _hrModeArray;
}

- (NSArray *)distanceUnitArray
{
    if (!_distanceUnitArray) {
        _distanceUnitArray = @[lang(@"invalid"),lang(@"km"),lang(@"mi")];
    }
    return _distanceUnitArray;
}

- (NSArray *)weightUnitArray
{
    if (!_weightUnitArray) {
        _weightUnitArray = @[lang(@"invalid"),lang(@"kg"),lang(@"lb"),lang(@"st")];
    }
    return _weightUnitArray;
}

- (NSArray *)tempUnitArray
{
    if (!_tempUnitArray) {
        _tempUnitArray = @[lang(@"invalid"),lang(@"°C"),lang(@"°F")];
    }
    return _tempUnitArray;
}

- (NSArray *)languageUnitArray
{
    if (!_languageUnitArray) {
        _languageUnitArray = @[lang(@"invalid"),lang(@"chinese"),lang(@"english"),lang(@"french"),
                               lang(@"german"),lang(@"italian"),lang(@"spanish"),lang(@"japanese"),
                               lang(@"polish"),lang(@"czech"),lang(@"romania"),lang(@"lithuanian"),
                               lang(@"dutch"),lang(@"slovenia"),lang(@"hungarian"),lang(@"russian"),
                               lang(@"ukrainian"),lang(@"slovak"),lang(@"danish"),lang(@"croatia"),
                               lang(@"indonesian"),lang(@"korean"),lang(@"hindi"),lang(@"portuguese")];
    }
    return _languageUnitArray;
}

- (NSArray *)timeUnitArray
{
    if (!_timeUnitArray) {
        _timeUnitArray = @[lang(@"invalid"),lang(@"24 hours"),lang(@"12 hours")];
    }
    return _timeUnitArray;
}

- (NSArray *)strideGpsArray
{
    if (!_strideGpsArray) {
        _strideGpsArray = @[lang(@"invalid"),lang(@"open"),lang(@"off")];
    }
    return _strideGpsArray;
}

- (NSArray *)gpsInfoTitleArray
{
    if (!_gpsInfoTitleArray) {
        _gpsInfoTitleArray = @[lang(@"startup mode:"),lang(@"operation mode:"),lang(@"positioning cycle:"),lang(@"positioning mode:")];
    }
    return _gpsInfoTitleArray;
}

- (NSArray *)unitTitleArray
{
    if (!_unitTitleArray) {
        _unitTitleArray = @[lang(@"distance unit:"),lang(@"weight unit:"),lang(@"temperature unit:"),lang(@"current language:"),
                            lang(@"walking step length:"),lang(@"running step length:"),lang(@"gps stride calibration:"),
                            lang(@"time format:"),lang(@"week start:")];
    }
    return _unitTitleArray;
}

- (NSArray *)sportShortcutTitleArray
{
    if (!_sportShortcutTitleArray) {
        _sportShortcutTitleArray = @[@[lang(@"walk"),lang(@"run"),lang(@"ride"),lang(@"hike"),lang(@"swim"),lang(@"mountain climbing"),lang(@"badminton"),lang(@"other")],
                                     @[lang(@"fitness"),lang(@"spinning"),lang(@"elliptical machine"),lang(@"treadmill"),lang(@"sit-ups"),lang(@"push-ups"),lang(@"dumbbells"),lang(@"weight lifting")],
                                     @[lang(@"calisthenics"),lang(@"yoga"),lang(@"rope skipping"),lang(@"table tennis"),lang(@"basketball"),lang(@"football"),lang(@"volleyball"),lang(@"tennis")],
                                     @[lang(@"golf"),lang(@"baseball"),lang(@"skiing"),lang(@"roller skating"),lang(@"dancing")]];
    }
    return _sportShortcutTitleArray;
}

- (NSArray *)sportSortTitleArray
{
    if (!_sportSortTitleArray) {
        _sportSortTitleArray = @[lang(@"walk"),lang(@"run"),lang(@"ride"),lang(@"hike"),lang(@"swim"),lang(@"mountain climbing"),lang(@"badminton"),lang(@"other"),
                                 lang(@"fitness"),lang(@"spinning"),lang(@"elliptical machine"),lang(@"treadmill"),lang(@"sit-ups"),lang(@"push-ups"),lang(@"dumbbells"),lang(@"weight lifting"),
                                 lang(@"calisthenics"),lang(@"yoga"),lang(@"rope skipping"),lang(@"table tennis"),lang(@"basketball"),lang(@"football"),lang(@"volleyball"),lang(@"tennis"),
                                 lang(@"golf"),lang(@"baseball"),lang(@"skiing"),lang(@"roller skating"),lang(@"dancing"),lang(@"outdoor running"),lang(@"indoor running"),lang(@"outdoor cycling"),
                                 lang(@"indoor cycling"),lang(@"outdoor walking"),lang(@"indoor walking"),lang(@"pool swimming"),lang(@"open water swimming"),lang(@"elliptical machine"),
                                 lang(@"rowing machine"),lang(@"high-intensity interval training")];
    }
    return _sportSortTitleArray;
}

- (NSArray *)bootModeArray
{
    if (!_bootModeArray) {
        _bootModeArray = @[lang(@"invalid"),lang(@"cold start"),lang(@"hot start")];
    }
    return _bootModeArray;
}

- (NSArray *)operatingModeArray
{
    if (!_operatingModeArray) {
        _operatingModeArray = @[lang(@"invalid"),lang(@"normal"),lang(@"low power"),lang(@"invalid"),lang(@"balance"),lang(@"1pps")];
    }
    return _operatingModeArray;
}

- (NSArray *)satelliteModeArray
{
    if (!_satelliteModeArray) {
        _satelliteModeArray = @[lang(@"invalid"),lang(@"GPS"),lang(@"GLONASS"),lang(@"GPS+GLONASS")];
    }
    return _satelliteModeArray;
}

- (NSArray *)hotStartTitleArray
{
    if (!_hotStartTitleArray) {
        _hotStartTitleArray = @[lang(@"crystal oscillation offset:"),lang(@"longitude:"),lang(@"latitude:"),lang(@"height:")];
    }
    return _hotStartTitleArray;
}

- (NSArray *)hotStartplaceholderArray
{
    if (!_hotStartplaceholderArray) {
        NSString * str1 = [NSString stringWithFormat:@"%@10^1",lang(@"accurate to")];
        NSString * str2 = [NSString stringWithFormat:@"%@10^6",lang(@"accurate to")];
        NSString * str3 = [NSString stringWithFormat:@"%@10^6",lang(@"accurate to")];
        NSString * str4 = [NSString stringWithFormat:@"%@10^1",lang(@"accurate to")];
        _hotStartplaceholderArray = @[str1,str2,str3,str4];
    }
    return _hotStartplaceholderArray;
}

- (NSArray *)targetTypes
{
    if (!_targetTypes) {
        _targetTypes = @[lang(@"none"),lang(@"times"),lang(@"meter"),lang(@"minute"),lang(@"calories")];
    }
    return _targetTypes;
}

- (NSArray *)sportTypes
{
    if (!_sportTypes) {
        _sportTypes =  @[lang(@"walk"),lang(@"run"),lang(@"ride"),lang(@"hike"),lang(@"swim"),lang(@"mountain climbing"),lang(@"badminton"),lang(@"other"),
                         lang(@"fitness"),lang(@"spinning"),lang(@"elliptical machine"),lang(@"treadmill"),lang(@"sit-ups"),lang(@"push-ups"),lang(@"dumbbells"),lang(@"weight lifting"),
                         lang(@"calisthenics"),lang(@"yoga"),lang(@"rope skipping"),lang(@"table tennis"),lang(@"basketball"),lang(@"football"),lang(@"volleyball"),lang(@"tennis"),
                         lang(@"golf"),lang(@"baseball"),lang(@"skiing"),lang(@"roller skating"),lang(@"dancing"),
                         lang(@"indoor rowing"),lang(@"pilates"),lang(@"cross training"),lang(@"aerobics"),lang(@"zumba"),
                         lang(@"square dance"),lang(@"plank"),lang(@"gym")];
    }
    return _sportTypes;
}

- (NSArray *)firmwareTypes
{
    if (!_firmwareTypes) {
        _firmwareTypes = @[@"soft_device",@"boot_loader",@"soft_device_boot_loader",@"application"];
    }
    return _firmwareTypes;
}

@end
