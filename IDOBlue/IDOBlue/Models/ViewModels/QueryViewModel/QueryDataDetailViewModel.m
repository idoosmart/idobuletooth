//
//  QueryDataDetailViewModel.m
//  IDOBlue
//
//  Created by 何东阳 on 2019/3/12.
//  Copyright © 2019年 hedongyang. All rights reserved.
//

#import "QueryDataDetailViewModel.h"
#import "TextViewCellModel.h"
#import "FuncCellModel.h"
#import "FuncViewController.h"
#import "OneButtonTableViewCell.h"
#import "OneTextViewTableViewCell.h"
#import "NSObject+ModelToDic.h"

@interface QueryDataDetailViewModel()
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,copy) NSString * macAddr;
@property (nonatomic,assign) NSInteger year;
@property (nonatomic,assign) NSInteger month;
@property (nonatomic,assign) NSInteger day;
@property (nonatomic,assign) NSInteger week;
@end

@implementation QueryDataDetailViewModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.macAddr = @"";
        self.rightButtonTitle = @"🔒";
        self.isRightButton = YES;
        self.rightButton   = @selector(actionButton:);
        IDOSetTimeInfoBluetoothModel * time = [IDOSetTimeInfoBluetoothModel new];
        self.year  = time.year;
        self.month = time.month;
        self.day   = time.day;
        self.week  = 0;
        [self getTextViewCallback];
        [self getButtonCallback];
        [self getCellModels];
    }
    return self;
}

- (void)actionButton:(UIBarButtonItem *)sender
{
    if ([sender.title isEqualToString:@"🔒"]) {
        self.macAddr = __IDO_MAC_ADDR__;
        [sender setTitle:@"🔓"];
    }else {
        self.macAddr = @"";
        [sender setTitle:@"🔒"];
    }
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    
    TextViewCellModel * model1 = [[TextViewCellModel alloc]init];
    model1.typeStr = @"oneTextView";
    model1.data = @[@""];
    model1.textViewCallback = self.textViewCallback;
    model1.cellHeight = 310;
    model1.isShowLine = YES;
    model1.cellClass  = [OneTextViewTableViewCell class];
    [cellModels addObject:model1];
    
    FuncCellModel * model2 = [[FuncCellModel alloc]init];
    model2.typeStr = @"oneButton";
    model2.data    = @[lang(@"previous year")];
    model2.cellHeight = 70.0f;
    model2.index = 0;
    model2.cellClass  = [OneButtonTableViewCell class];
    model2.modelClass = [NSNull class];
    model2.isShowLine = YES;
    model2.buttconCallback = self.buttconCallback;
    [cellModels addObject:model2];
    
    FuncCellModel * model3 = [[FuncCellModel alloc]init];
    model3.typeStr = @"oneButton";
    model3.data    = @[lang(@"next year")];
    model3.cellHeight = 70.0f;
    model3.index = 1;
    model3.cellClass  = [OneButtonTableViewCell class];
    model3.modelClass = [NSNull class];
    model3.isShowLine = YES;
    model3.buttconCallback = self.buttconCallback;
    [cellModels addObject:model3];
    
    self.cellModels = cellModels;
}

- (void)setTimeType:(NSInteger)timeType
{
    _timeType = timeType;
    switch (_timeType) {
        case 0:
        {
            FuncViewController * funcVc = (FuncViewController *)[IDODemoUtility getCurrentVC];
            NSIndexPath * indexPath1 = [NSIndexPath indexPathForRow:1 inSection:0];
            NSIndexPath * indexPath2 = [NSIndexPath indexPathForRow:2 inSection:0];
            FuncCellModel * model1 = [self.cellModels objectAtIndex:1];
            FuncCellModel * model2 = [self.cellModels lastObject];
            model1.data = @[lang(@"previous year")];
            model2.data = @[lang(@"next year")];
            [funcVc.tableView reloadRowsAtIndexPaths:@[indexPath1,indexPath2] withRowAnimation:UITableViewRowAnimationNone];
        }
            break;
        case 1:
        {
            FuncViewController * funcVc = (FuncViewController *)[IDODemoUtility getCurrentVC];
            NSIndexPath * indexPath1 = [NSIndexPath indexPathForRow:1 inSection:0];
            NSIndexPath * indexPath2 = [NSIndexPath indexPathForRow:2 inSection:0];
            FuncCellModel * model1 = [self.cellModels objectAtIndex:1];
            FuncCellModel * model2 = [self.cellModels lastObject];
            model1.data = @[lang(@"previous month")];
            model2.data = @[lang(@"next month")];
            [funcVc.tableView reloadRowsAtIndexPaths:@[indexPath1,indexPath2] withRowAnimation:UITableViewRowAnimationNone];
        }
            break;
        case 2:
        {
            FuncViewController * funcVc = (FuncViewController *)[IDODemoUtility getCurrentVC];
            NSIndexPath * indexPath1 = [NSIndexPath indexPathForRow:1 inSection:0];
            NSIndexPath * indexPath2 = [NSIndexPath indexPathForRow:2 inSection:0];
            FuncCellModel * model1 = [self.cellModels objectAtIndex:1];
            FuncCellModel * model2 = [self.cellModels lastObject];
            model1.data = @[lang(@"previous week")];
            model2.data = @[lang(@"next week")];
            [funcVc.tableView reloadRowsAtIndexPaths:@[indexPath1,indexPath2] withRowAnimation:UITableViewRowAnimationNone];
        }
            break;
        case 3:
        {
            FuncViewController * funcVc = (FuncViewController *)[IDODemoUtility getCurrentVC];
            NSIndexPath * indexPath1 = [NSIndexPath indexPathForRow:1 inSection:0];
            NSIndexPath * indexPath2 = [NSIndexPath indexPathForRow:2 inSection:0];
            FuncCellModel * model1 = [self.cellModels objectAtIndex:1];
            FuncCellModel * model2 = [self.cellModels lastObject];
            model1.data = @[lang(@"previous day")];
            model2.data = @[lang(@"next day")];
            [funcVc.tableView reloadRowsAtIndexPaths:@[indexPath1,indexPath2] withRowAnimation:UITableViewRowAnimationNone];
        }
            break;
        case 4:
        {
            FuncViewController * funcVc = (FuncViewController *)[IDODemoUtility getCurrentVC];
            TextViewCellModel * model1 = [self.cellModels firstObject];
            FuncCellModel * model2 = [self.cellModels objectAtIndex:1];
            model2.data = @[lang(@"query all data")];
            self.cellModels = @[model1,model2];
            [funcVc.tableView reloadData];
        }
            break;
        default:
            break;
    }
}

- (void)getTextViewCallback
{
    __weak typeof(self) weakSelf = self;
    self.textViewCallback = ^(UITextView *textView) {
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.textView = textView;
    };
}


- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVc = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVc.tableView indexPathForCell:tableViewCell];
        FuncCellModel * funcModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
        if (funcModel.index == 0) {
            if (strongSelf.timeType == 0) {//上一年
                strongSelf.year --;
                if (strongSelf.dataType == 0) {//步数
                   [strongSelf querySportsYearDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 1) {//心率
                   [strongSelf queryHrsYearDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 2) {//血压
                   [strongSelf queryBpsYearDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 3) {//睡眠
                   [strongSelf querySleepsYearDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 4) {//血氧
                   [strongSelf queryBopsYearDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 5) {//压力
                   [strongSelf queryPressuresYearDataWtithVc:funcVc];
                }
            }else if (strongSelf.timeType == 1) {//上一月
                strongSelf.month --;
                if (strongSelf.month == 0) {
                    strongSelf.month = 12;
                    strongSelf.year --;
                }
                if (strongSelf.dataType == 0) {//步数
                    [strongSelf querySportsMonthDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 1) {//心率
                    [strongSelf queryHrsMonthDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 2) {//血压
                    [strongSelf queryBpsMonthDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 3) {//睡眠
                    [strongSelf querySleepsMonthDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 4) {//血氧
                    [strongSelf queryBopsMonthDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 5) {//压力
                    [strongSelf queryPressuresMonthDataWtithVc:funcVc];
                }
            }else if (strongSelf.timeType == 2) {//上一周
                strongSelf.week ++;
                if (strongSelf.dataType == 0) {//步数
                    [strongSelf querySportsWeekDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 1) {//心率
                    [strongSelf querySportsWeekDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 2) {//血压
                    [strongSelf queryBpsWeekDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 3) {//睡眠
                    [strongSelf querySportsWeekDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 4) {//血氧
                    [strongSelf queryBopsWeekDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 5) {//压力
                    [strongSelf queryPressuresWeekDataWtithVc:funcVc];
                }
            }else if (strongSelf.timeType == 3) {//上一日
                strongSelf.day --;
                if (strongSelf.day == 0) {
                    strongSelf.month --;
                    strongSelf.day = [IDODemoUtility getDaysInMonthWithYear:strongSelf.year month:strongSelf.month];
                    if (strongSelf.month == 0) {
                        strongSelf.month = 12;
                        strongSelf.year --;
                    }
                }
                if (strongSelf.dataType == 0) {//步数
                    [strongSelf querySportsDayDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 1) {//心率
                    [strongSelf queryHrsDayDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 2) {//血压
                    [strongSelf queryBpsDayDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 3) {//睡眠
                    [strongSelf querySleepsDayDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 4) {//血氧
                    [strongSelf queryBopsDayDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 5) {//压力
                    [strongSelf queryPressuresDayDataWtithVc:funcVc];
                }
            }else if (strongSelf.timeType == 4) {//所有数据
                if (strongSelf.dataType == 0) {//步数
                    [strongSelf queryAllSportsDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 1) {//心率
                    [strongSelf queryAllHrsDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 2) {//血压
                    [strongSelf queryAllBpsDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 3) {//睡眠
                    [strongSelf queryAllSleepcsDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 4) {//血氧
                    [strongSelf queryAllBopsDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 5) {//压力
                    [strongSelf queryAllPressuresDataWtithVc:funcVc];
                }
            }
        }else {
            if (strongSelf.timeType == 0) {//下一年
                strongSelf.year ++;
                if (strongSelf.dataType == 0) {//步数
                    [strongSelf querySportsYearDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 1) {//心率
                    [strongSelf queryHrsYearDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 2) {//血压
                    [strongSelf queryBpsYearDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 3) {//睡眠
                    [strongSelf querySleepsYearDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 4) {//血氧
                    [strongSelf queryBopsYearDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 5) {//压力
                    [strongSelf queryPressuresYearDataWtithVc:funcVc];
                }
            }else if (strongSelf.timeType == 1) {//下一月
                strongSelf.month ++;
                if (strongSelf.month > 12) {
                    strongSelf.month = 1;
                    strongSelf.year ++;
                }
                if (strongSelf.dataType == 0) {//步数
                    [strongSelf querySportsMonthDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 1) {//心率
                    [strongSelf queryHrsMonthDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 2) {//血压
                    [strongSelf queryBpsMonthDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 3) {//睡眠
                    [strongSelf querySleepsMonthDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 4) {//血氧
                    [strongSelf queryBopsMonthDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 5) {//压力
                    [strongSelf queryPressuresMonthDataWtithVc:funcVc];
                }
            }else if (strongSelf.timeType == 2) {//下一周
                strongSelf.week --;
                if (strongSelf.dataType == 0) {//步数
                    [strongSelf querySportsWeekDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 1) {//心率
                    [strongSelf querySportsWeekDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 2) {//血压
                    [strongSelf queryBpsWeekDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 3) {//睡眠
                    [strongSelf querySportsWeekDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 4) {//血氧
                    [strongSelf queryBopsWeekDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 5) {//压力
                    [strongSelf queryPressuresWeekDataWtithVc:funcVc];
                }
            }else if (strongSelf.timeType == 3) {//下一日
                strongSelf.day ++;
                NSInteger day = [IDODemoUtility getDaysInMonthWithYear:strongSelf.year month:strongSelf.month];
                if (strongSelf.day > day) {
                    strongSelf.month --;
                    strongSelf.day = [IDODemoUtility getDaysInMonthWithYear:strongSelf.year month:strongSelf.month];
                    if (strongSelf.month == 0) {
                        strongSelf.month = 12;
                        strongSelf.year --;
                    }
                }
                if (strongSelf.dataType == 0) {//步数
                    [strongSelf querySportsDayDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 1) {//心率
                    [strongSelf queryHrsDayDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 2) {//血压
                    [strongSelf queryBpsDayDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 3) {//睡眠
                    [strongSelf querySleepsDayDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 4) {//血氧
                    [strongSelf queryBopsDayDataWtithVc:funcVc];
                }else if (strongSelf.dataType == 5) {//压力
                    [strongSelf queryPressuresDayDataWtithVc:funcVc];
                }
            }
        }
    };
}

/*****************************步数**************************************/
- (void)querySportsYearDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * array = [IDOSyncSportDataInfoBluetoothModel queryOneYearSportsWithYear:self.year
                                                                             macAddr:self.macAddr
                                                                        isQueryItems:NO];
    if (array.count == 0) {
        self.textView.text = lang(@"current year no data");
        [funcVc showToastWithText:lang(@"current year no data")];
    }else {
        NSMutableArray * oneYearSports = [NSMutableArray array];
        for (NSArray * oneMonthSports in array) {
            for (IDOSyncSportDataInfoBluetoothModel * oneDaySport in oneMonthSports) {
                NSDictionary * dic = oneDaySport.dicFromObject;
                [oneYearSports addObject:dic];
            }
        }
        IDOCalculateSportBluetoothModel * sport = [IDOCalculateSportBluetoothModel calculateOneYearSportDataWithSportModels:array];
        self.textView.text = [NSString stringWithFormat:@"%ld\n%@\n%@",(long)self.year,sport.dicFromObject,oneYearSports.count > 0 ? oneYearSports : lang(@"no data")];
    }
}

- (void)querySportsMonthDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * days = nil;
    NSArray * array = [IDOSyncSportDataInfoBluetoothModel queryOneMonthSportsWithYear:self.year
                                                                                month:self.month
                                                                              macAddr:self.macAddr
                                                                         datesOfMonth:&days
                                                                         isQueryItems:NO];
    if (array.count == 0) {
        self.textView.text = lang(@"current month no data");
        [funcVc showToastWithText:lang(@"current month no data")];
    }else {
        NSMutableArray * oneMonthSports = [NSMutableArray array];
        for (IDOSyncSportDataInfoBluetoothModel * oneDaySport in array) {
            NSDictionary * dic = oneDaySport.dicFromObject;
            [oneMonthSports addObject:dic];
        }
        IDOCalculateSportBluetoothModel * sport = [IDOCalculateSportBluetoothModel calculateOneMonthOrWeekSportDataWithSportModels:array];
        self.textView.text = [NSString stringWithFormat:@"%@-%@\n%@\n%@",[days firstObject],[days lastObject],sport.dicFromObject,oneMonthSports.count > 0 ? oneMonthSports : lang(@"no data")];
    }
}

- (void)querySportsWeekDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * days = nil;
    NSArray * array = [IDOSyncSportDataInfoBluetoothModel queryOneWeekSportsWithWeekIndex:self.week
                                                                             weekStartDay:0
                                                                                  macAddr:self.macAddr
                                                                              datesOfWeek:&days
                                                                             isQueryItems:NO];
    if (array.count == 0) {
        self.textView.text = lang(@"current week no data");
        [funcVc showToastWithText:lang(@"current week no data")];
    }else {
        NSMutableArray * oneWeekSports = [NSMutableArray array];
        for (IDOSyncSportDataInfoBluetoothModel * oneDaySport in array) {
            NSDictionary * dic = oneDaySport.dicFromObject;
            [oneWeekSports addObject:dic];
        }
        IDOCalculateSportBluetoothModel * sport = [IDOCalculateSportBluetoothModel calculateOneMonthOrWeekSportDataWithSportModels:array];
        self.textView.text = [NSString stringWithFormat:@"%@-%@\n%@\n%@",[days firstObject],[days lastObject],sport.dicFromObject,oneWeekSports.count > 0 ? oneWeekSports : lang(@"no data")];
    }
}

- (void)querySportsDayDataWtithVc:(FuncViewController *)funcVc
{
    IDOSyncSportDataInfoBluetoothModel * model = [IDOSyncSportDataInfoBluetoothModel queryOneDaySportDetailWithMac:self.macAddr
                                                                                                              year:self.year
                                                                                                             month:self.month
                                                                                                               day:self.day];
    if (!model) {
        self.textView.text = lang(@"current day no data");
        [funcVc showToastWithText:lang(@"current day no data")];
    }else {
        self.textView.text = [NSString stringWithFormat:@"%ld-%ld-%ld\n%@",(long)self.year,(long)self.month,(long)self.day,model ? model.dicFromObject : lang(@"no data")];
    }
}


- (void)queryAllSportsDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * array = [IDOSyncSportDataInfoBluetoothModel queryAllSportsWithMac:self.macAddr];
    if (!array || array.count == 0) {
        self.textView.text = lang(@"no data");
        [funcVc showToastWithText:lang(@"no data")];
    }else {
        self.textView.text = [NSString stringWithFormat:@"%@:%ld\n%@",lang(@"data count"),(long)array.count,array.count > 0 ? array : lang(@"no data")];
    }
}

/*****************************心率**************************************/
- (void)queryHrsYearDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * array = [IDOSyncHrDataInfoBluetoothModel queryOneYearHearRatesWithYear:self.year
                                                                             macAddr:self.macAddr
                                                                        isQueryItems:NO];
    if (array.count == 0) {
        self.textView.text = lang(@"current year no data");
        [funcVc showToastWithText:lang(@"current year no data")];
    }else {
        NSMutableArray * oneYearHrs = [NSMutableArray array];
        for (NSArray * oneMonthHrs in array) {
            for (IDOSyncHrDataInfoBluetoothModel * oneDayHr in oneMonthHrs) {
                NSDictionary * dic = oneDayHr.dicFromObject;
                [oneYearHrs addObject:dic];
            }
        }
        IDOCalculateHrBluetoothModel * hr = [IDOCalculateHrBluetoothModel calculateOneYearHrDataWithHrModels:array];
        self.textView.text = [NSString stringWithFormat:@"%ld\n%@\n%@",(long)self.year,hr.dicFromObject,oneYearHrs.count > 0 ? oneYearHrs : lang(@"no data")];
    }
}

- (void)queryHrsMonthDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * days = nil;
    NSArray * array = [IDOSyncHrDataInfoBluetoothModel queryOneMonthHearRatesWithYear:self.year
                                                                                month:self.month
                                                                              macAddr:self.macAddr
                                                                         datesOfMonth:&days
                                                                         isQueryItems:NO];
    if (array.count == 0) {
        self.textView.text = lang(@"current month no data");
        [funcVc showToastWithText:lang(@"current month no data")];
    }else {
        NSMutableArray * oneMonthHrs = [NSMutableArray array];
        for (IDOSyncHrDataInfoBluetoothModel * oneDayHr in array) {
            NSDictionary * dic = oneDayHr.dicFromObject;
            [oneMonthHrs addObject:dic];
        }
        IDOCalculateHrBluetoothModel * hr = [IDOCalculateHrBluetoothModel calculateOneMonthOrWeekHrDataWithHrModels:array];
        self.textView.text = [NSString stringWithFormat:@"%@-%@\n%@\n%@",[days firstObject],[days lastObject],hr.dicFromObject,oneMonthHrs.count > 0 ? oneMonthHrs : lang(@"no data")];
    }
}

- (void)queryHrsWeekDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * days = nil;
    NSArray * array = [IDOSyncHrDataInfoBluetoothModel queryOneWeekHearRatesWithWeekIndex:self.week
                                                                             weekStartDay:0
                                                                                  macAddr:self.macAddr
                                                                              datesOfWeek:&days
                                                                             isQueryItems:NO];
    if (array.count == 0) {
        self.textView.text = lang(@"current week no data");
        [funcVc showToastWithText:lang(@"current week no data")];
    }else {
        NSMutableArray * oneWeekHrs = [NSMutableArray array];
        for (IDOSyncHrDataInfoBluetoothModel * oneDayHr in array) {
            NSDictionary * dic = oneDayHr.dicFromObject;
            [oneWeekHrs addObject:dic];
        }
        IDOCalculateHrBluetoothModel * hr = [IDOCalculateHrBluetoothModel calculateOneMonthOrWeekHrDataWithHrModels:array];
        self.textView.text = [NSString stringWithFormat:@"%@-%@\n%@\n%@",[days firstObject],[days lastObject],hr.dicFromObject,oneWeekHrs.count > 0 ? oneWeekHrs : lang(@"no data")];
    }
}

- (void)queryHrsDayDataWtithVc:(FuncViewController *)funcVc
{
    IDOSyncHrDataInfoBluetoothModel * model = [IDOSyncHrDataInfoBluetoothModel queryOneDayHearRatesDetailWithMac:self.macAddr
                                                                                                            year:self.year
                                                                                                           month:self.month
                                                                                                             day:self.day];
    if (!model) {
        self.textView.text = lang(@"current day no data");
        [funcVc showToastWithText:lang(@"current day no data")];
    }else {
        self.textView.text = [NSString stringWithFormat:@"%ld-%ld-%ld\n%@",(long)self.year,(long)self.month,(long)self.day,model ? model.dicFromObject : lang(@"no data")];
    }
}

- (void)queryAllHrsDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * array = [IDOSyncHrDataInfoBluetoothModel queryAllHearRatesWithMac:self.macAddr];
    if (!array || array.count == 0) {
        self.textView.text = lang(@"no data");
        [funcVc showToastWithText:lang(@"no data")];
    }else {
        self.textView.text = [NSString stringWithFormat:@"%@:%ld\n%@",lang(@"data count"),(long)array.count,array.count > 0 ? array : lang(@"no data")];
    }
}

/*****************************血压**************************************/
- (void)queryBpsYearDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * array = [IDOSyncBpDataInfoBluetoothModel queryOneYearBloodPressuresWithYear:self.year
                                                                                  macAddr:self.macAddr
                                                                             isQueryItems:NO];
    if (array.count == 0) {
        self.textView.text = lang(@"current year no data");
        [funcVc showToastWithText:lang(@"current year no data")];
    }else {
        NSMutableArray * oneYearBps = [NSMutableArray array];
        for (NSArray * oneMonthBps in array) {
            for (IDOSyncBpDataInfoBluetoothModel * oneDayBp in oneMonthBps) {
                NSDictionary * dic = oneDayBp.dicFromObject;
                [oneYearBps addObject:dic];
            }
        }
        self.textView.text = [NSString stringWithFormat:@"%ld\n%@",(long)self.year,oneYearBps.count > 0 ? oneYearBps : lang(@"no data")];
    }
}

- (void)queryBpsMonthDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * days = nil;
    NSArray * array = [IDOSyncBpDataInfoBluetoothModel queryOneMonthBloodPressuresWithYear:self.year
                                                                                     month:self.month
                                                                                   macAddr:self.macAddr
                                                                              datesOfMonth:&days
                                                                              isQueryItems:NO];
    if (array.count == 0) {
        self.textView.text = lang(@"current month no data");
        [funcVc showToastWithText:lang(@"current month no data")];
    }else {
        NSMutableArray * oneMonthBps = [NSMutableArray array];
        for (IDOSyncSportDataInfoBluetoothModel * oneDayBp in array) {
            NSDictionary * dic = oneDayBp.dicFromObject;
            [oneMonthBps addObject:dic];
        }
        IDOCalculateBpBluetoothModel * bp = [IDOCalculateBpBluetoothModel calculateOneMonthOrWeekBpDataWithBpModels:array allDayCalculateBpModels:nil];
        self.textView.text = [NSString stringWithFormat:@"%@-%@\n%@\n%@",[days firstObject],[days lastObject],bp.dicFromObject,oneMonthBps.count > 0 ? oneMonthBps : lang(@"no data")];
    }
}

- (void)queryBpsWeekDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * days = nil;
    NSArray * array = [IDOSyncBpDataInfoBluetoothModel queryOneWeekBloodPressuresWithWeekIndex:self.week
                                                                                  weekStartDay:0
                                                                                       macAddr:self.macAddr
                                                                                   datesOfWeek:&days
                                                                                  isQueryItems:NO];
    if (array.count == 0) {
        self.textView.text = lang(@"current week no data");
        [funcVc showToastWithText:lang(@"current week no data")];
    }else {
        NSMutableArray * oneWeekBps = [NSMutableArray array];
        for (IDOSyncBpDataInfoBluetoothModel * oneDayBp in array) {
            NSDictionary * dic = oneDayBp.dicFromObject;
            [oneWeekBps addObject:dic];
        }
        self.textView.text = [NSString stringWithFormat:@"%@-%@\n%@",[days firstObject],[days lastObject],oneWeekBps.count > 0 ? oneWeekBps : lang(@"no data")];
    }
}

- (void)queryBpsDayDataWtithVc:(FuncViewController *)funcVc
{
    IDOSyncBpDataInfoBluetoothModel * model = [IDOSyncBpDataInfoBluetoothModel queryOneDayBloodPressureDetailWithMac:self.macAddr
                                                                                                                year:self.year
                                                                                                               month:self.month
                                                                                                                 day:self.day];
    if (!model) {
        self.textView.text = lang(@"current day no data");
        [funcVc showToastWithText:lang(@"current day no data")];
    }else {
        self.textView.text = [NSString stringWithFormat:@"%ld-%ld-%ld\n%@",(long)self.year,(long)self.month,(long)self.day,model ? model.dicFromObject : lang(@"no data")];
    }
}

- (void)queryAllBpsDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * array = [IDOSyncBpDataInfoBluetoothModel queryAllBloodPressuresWithMac:self.macAddr];
    if (!array || array.count == 0) {
        self.textView.text = lang(@"no data");
        [funcVc showToastWithText:lang(@"no data")];
    }else {
        self.textView.text = [NSString stringWithFormat:@"%@:%ld\n%@",lang(@"data count"),(long)array.count,array.count > 0 ? array : lang(@"no data")];
    }
}

/*****************************睡眠**************************************/
- (void)querySleepsYearDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * array = [IDOSyncSleepDataInfoBluetoothModel queryOneYearSleepsWithYear:self.year
                                                                             macAddr:self.macAddr
                                                                        isQueryItems:NO];
    if (array.count == 0) {
        self.textView.text = lang(@"current year no data");
        [funcVc showToastWithText:lang(@"current year no data")];
    }else {
        NSMutableArray * oneYearSleeps = [NSMutableArray array];
        for (NSArray * oneMonthSleeps in array) {
            for (IDOCalculateSleepBluetoothModel * oneDaySleep in oneMonthSleeps) {
                NSDictionary * dic = oneDaySleep.dicFromObject;
                [oneYearSleeps addObject:dic];
            }
        }
        IDOCalculateSleepBluetoothModel * sleep = [IDOCalculateSleepBluetoothModel calculateOneYearSleepDataWithSleepModels:array];
        self.textView.text = [NSString stringWithFormat:@"%ld\n%@\n%@",(long)self.year,sleep.dicFromObject,oneYearSleeps.count > 0 ? oneYearSleeps : lang(@"no data")];
    }
}

- (void)querySleepsMonthDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * days = nil;
    NSArray * array = [IDOSyncSleepDataInfoBluetoothModel queryOneMonthSleepsWithYear:self.year
                                                                                month:self.month
                                                                              macAddr:self.macAddr
                                                                         datesOfMonth:&days
                                                                         isQueryItems:NO];
    if (array.count == 0) {
        self.textView.text = lang(@"current month no data");
        [funcVc showToastWithText:lang(@"current month no data")];
    }else {
        NSMutableArray * oneMonthSleeps = [NSMutableArray array];
        for (IDOSyncSleepDataInfoBluetoothModel * oneDaySleep in array) {
            NSDictionary * dic = oneDaySleep.dicFromObject;
            [oneMonthSleeps addObject:dic];
        }
        IDOCalculateSleepBluetoothModel * sleep = [IDOCalculateSleepBluetoothModel calculateOneMonthOrWeekSleepDataWithSleepModels:array];
        self.textView.text = [NSString stringWithFormat:@"%@-%@\n%@\n%@",[days firstObject],[days lastObject],sleep.dicFromObject,oneMonthSleeps.count > 0 ? oneMonthSleeps : lang(@"no data")];
    }
}

- (void)querySleepsWeekDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * days = nil;
    NSArray * array = [IDOSyncSleepDataInfoBluetoothModel queryOneWeekSleepsWithWeekIndex:self.week
                                                                             weekStartDay:0
                                                                                  macAddr:self.macAddr
                                                                              datesOfWeek:&days
                                                                             isQueryItems:NO];
    if (array.count == 0) {
        self.textView.text = lang(@"current week no data");
        [funcVc showToastWithText:lang(@"current week no data")];
    }else {
        NSMutableArray * oneWeekSleeps = [NSMutableArray array];
        for (IDOSyncSleepDataInfoBluetoothModel * oneDaySleep in array) {
            NSDictionary * dic = oneDaySleep.dicFromObject;
            [oneWeekSleeps addObject:dic];
        }
        IDOCalculateSleepBluetoothModel * sleep = [IDOCalculateSleepBluetoothModel calculateOneMonthOrWeekSleepDataWithSleepModels:array];
        self.textView.text = [NSString stringWithFormat:@"%@-%@\n%@\n%@",[days firstObject],[days lastObject],sleep.dicFromObject,oneWeekSleeps.dicFromObject];
    }
}

- (void)querySleepsDayDataWtithVc:(FuncViewController *)funcVc
{
    IDOSyncSleepDataInfoBluetoothModel * model = [IDOSyncSleepDataInfoBluetoothModel queryOneDaySleepsDetailWithMac:self.macAddr
                                                                                                               year:self.year
                                                                                                              month:self.month
                                                                                                                day:self.day];
    if (!model) {
        self.textView.text = lang(@"current day no data");
        [funcVc showToastWithText:lang(@"current day no data")];
    }else {
        self.textView.text = [NSString stringWithFormat:@"%ld-%ld-%ld\n%@",(long)self.year,(long)self.month,(long)self.day,model ? model.dicFromObject : lang(@"no data")];
    }
}

- (void)queryAllSleepcsDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * array = [IDOSyncSleepDataInfoBluetoothModel queryAllSleepsWithMac:self.macAddr];
    if (!array || array.count == 0) {
        self.textView.text = lang(@"no data");
        [funcVc showToastWithText:lang(@"no data")];
    }else {
        self.textView.text = [NSString stringWithFormat:@"%@:%ld\n%@",lang(@"data count"),(long)array.count,array.count > 0 ? array : lang(@"no data")];
    }
}


/*****************************血氧**************************************/
- (void)queryBopsYearDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * array = [IDOSyncBloodOxygenDataInfoBluetoothModel queryOneYearBloodOxygenWithYear:self.year
                                                                                        macAddr:self.macAddr
                                                                                   isQueryItems:NO];
    if (array.count == 0) {
        self.textView.text = lang(@"current year no data");
        [funcVc showToastWithText:lang(@"current year no data")];
    }else {
        NSMutableArray * oneYearBops = [NSMutableArray array];
        for (NSArray * oneMonthBops in array) {
            for (IDOSyncBloodOxygenDataInfoBluetoothModel * oneDayBop in oneMonthBops) {
                NSDictionary * dic = oneDayBop.dicFromObject;
                [oneYearBops addObject:dic];
            }
        }
        self.textView.text = [NSString stringWithFormat:@"%ld\n%@",(long)self.year,oneYearBops.count > 0 ? oneYearBops : lang(@"no data")];
    }
}

- (void)queryBopsMonthDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * days = nil;
    NSArray * array = [IDOSyncBloodOxygenDataInfoBluetoothModel queryOneMonthBloodOxygenWithYear:self.year
                                                                                           month:self.month
                                                                                         macAddr:self.macAddr
                                                                                    datesOfMonth:&days
                                                                                    isQueryItems:NO];
    if (array.count == 0) {
        self.textView.text = lang(@"current month no data");
        [funcVc showToastWithText:lang(@"current month no data")];
    }else {
        NSMutableArray * oneMonthBops = [NSMutableArray array];
        for (IDOSyncBloodOxygenDataInfoBluetoothModel * oneDayBop in array) {
            NSDictionary * dic = oneDayBop.dicFromObject;
            [oneMonthBops addObject:dic];
        }
        self.textView.text = [NSString stringWithFormat:@"%@-%@\n%@",[days firstObject],[days lastObject],oneMonthBops.count > 0 ? oneMonthBops : lang(@"no data")];
    }
}

- (void)queryBopsWeekDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * days = nil;
    NSArray * array = [IDOSyncBloodOxygenDataInfoBluetoothModel queryOneWeekBloodOxygenWithWeekIndex:self.week
                                                                                        weekStartDay:0
                                                                                             macAddr:self.macAddr
                                                                                         datesOfWeek:&days
                                                                                        isQueryItems:NO];
    if (array.count == 0) {
        self.textView.text = lang(@"current week no data");
        [funcVc showToastWithText:lang(@"current week no data")];
    }else {
        NSMutableArray * oneWeekBops = [NSMutableArray array];
        for (IDOSyncBloodOxygenDataInfoBluetoothModel * oneDayBop in array) {
            NSDictionary * dic = oneDayBop.dicFromObject;
            [oneWeekBops addObject:dic];
        }
        self.textView.text = [NSString stringWithFormat:@"%@-%@\n%@",[days firstObject],[days lastObject],oneWeekBops.count > 0 ? oneWeekBops : lang(@"no data")];
    }
}

- (void)queryBopsDayDataWtithVc:(FuncViewController *)funcVc
{
    IDOSyncBloodOxygenDataInfoBluetoothModel * model = [IDOSyncBloodOxygenDataInfoBluetoothModel queryOneDayBloodOxygenDetailWithMac:self.macAddr
                                                                                                                             year:self.year
                                                                                                                            month:self.month
                                                                                                                              day:self.day];
    if (!model) {
        self.textView.text = lang(@"current day no data");
        [funcVc showToastWithText:lang(@"current day no data")];
    }else {
        self.textView.text = [NSString stringWithFormat:@"%ld-%ld-%ld\n%@",(long)self.year,(long)self.month,(long)self.day,model ? model.dicFromObject : lang(@"no data")];
    }
}

- (void)queryAllBopsDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * array = [IDOSyncBloodOxygenDataInfoBluetoothModel queryAllBloodOxygensWithMac:self.macAddr];
    if (!array || array.count == 0) {
        self.textView.text = lang(@"no data");
        [funcVc showToastWithText:lang(@"no data")];
    }else {
        self.textView.text = [NSString stringWithFormat:@"%@:%ld\n%@",lang(@"data count"),(long)array.count,array.count > 0 ? array : lang(@"no data")];
    }
}


/*****************************压力**************************************/
- (void)queryPressuresYearDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * array = [IDOSyncPressureDataInfoBluetoothModel queryOneYearPressureWithYear:self.year
                                                                                  macAddr:self.macAddr
                                                                             isQueryItems:NO];
    if (array.count == 0) {
        self.textView.text = lang(@"current year no data");
        [funcVc showToastWithText:lang(@"current year no data")];
    }else {
        NSMutableArray * oneYearPressures = [NSMutableArray array];
        for (NSArray * oneMonthPressures in array) {
            for (IDOSyncPressureDataInfoBluetoothModel * oneDayPressure in oneMonthPressures) {
                NSDictionary * dic = oneDayPressure.dicFromObject;
                [oneYearPressures addObject:dic];
            }
        }
        self.textView.text = [NSString stringWithFormat:@"%ld\n%@",(long)self.year,oneYearPressures.count > 0 ? oneYearPressures : lang(@"no data")];
    }
}

- (void)queryPressuresMonthDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * days = nil;
    NSArray * array = [IDOSyncPressureDataInfoBluetoothModel queryOneMonthPressureWithYear:self.year
                                                                                     month:self.month
                                                                                   macAddr:self.macAddr
                                                                              datesOfMonth:&days
                                                                              isQueryItems:NO];
    if (array.count == 0) {
        self.textView.text = lang(@"current month no data");
        [funcVc showToastWithText:lang(@"current month no data")];
    }else {
        NSMutableArray * oneMonthPressures = [NSMutableArray array];
        for (IDOSyncPressureDataInfoBluetoothModel * oneDayPressure in array) {
            NSDictionary * dic = oneDayPressure.dicFromObject;
            [oneMonthPressures addObject:dic];
        }
        self.textView.text = [NSString stringWithFormat:@"%@-%@\n%@",[days firstObject],[days lastObject],oneMonthPressures.count > 0 ? oneMonthPressures : lang(@"no data")];
    }
}

- (void)queryPressuresWeekDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * days = nil;
    NSArray * array = [IDOSyncPressureDataInfoBluetoothModel queryOneWeekPressureWithWeekIndex:self.week
                                                                                  weekStartDay:0
                                                                                       macAddr:self.macAddr
                                                                                   datesOfWeek:&days
                                                                                  isQueryItems:NO];
    if (array.count == 0) {
        self.textView.text = lang(@"current week no data");
        [funcVc showToastWithText:lang(@"current week no data")];
    }else {
        NSMutableArray * oneWeekPressures = [NSMutableArray array];
        for (IDOSyncPressureDataInfoBluetoothModel * oneDayPressure in array) {
            NSDictionary * dic = oneDayPressure.dicFromObject;
            [oneWeekPressures addObject:dic];
        }
        self.textView.text = [NSString stringWithFormat:@"%@-%@\n%@",[days firstObject],[days lastObject],oneWeekPressures.count > 0 ? oneWeekPressures : lang(@"no data")];
    }
}

- (void)queryPressuresDayDataWtithVc:(FuncViewController *)funcVc
{
    IDOSyncPressureDataInfoBluetoothModel * model = [IDOSyncPressureDataInfoBluetoothModel queryOneDayPressureDetailWithMac:self.macAddr
                                                                                                                       Year:self.year
                                                                                                                      month:self.month
                                                                                                                        day:self.day];
    if (!model) {
        self.textView.text = lang(@"current day no data");
        [funcVc showToastWithText:lang(@"current day no data")];
    }else {
        self.textView.text = [NSString stringWithFormat:@"%ld-%ld-%ld\n%@",(long)self.year,(long)self.month,(long)self.day,model ? model.dicFromObject : lang(@"no data")];
    }
}

- (void)queryAllPressuresDataWtithVc:(FuncViewController *)funcVc
{
    NSArray * array = [IDOSyncPressureDataInfoBluetoothModel queryAllPressuresWithMac:self.macAddr];
    if (!array || array.count == 0) {
        self.textView.text = lang(@"no data");
        [funcVc showToastWithText:lang(@"no data")];
    }else {
        self.textView.text = [NSString stringWithFormat:@"%@:%ld\n%@",lang(@"data count"),(long)array.count,array.count > 0 ? array : lang(@"no data")];
    }
}


@end
