//
//  QueryMainViewModel.m
//  IDOBlue
//
//  Created by hedongyang on 2018/10/13.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "QueryViewModel.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "FuncViewController.h"
#import "GetFuncTableViewModel.h"
#import "GetActivityViewModel.h"
#import "GetGpsInfoViewModel.h"
#import "GetNotifyStateViewModel.h"
#import "QuerySportsViewModel.h"
#import "QuerySleepViewModel.h"
#import "QueryHrViewModel.h"
#import "QueryActivityViewModel.h"
#import "QueryBpViewModel.h"
#import "QueryBopViewModel.h"
#import "QueryPressureViewModel.h"
#import "QueryGpsViewModel.h"
#import "QueryNoiseViewModel.h"
#import "QueryTemperatureViewModel.h"
#import "QueryBodyPowerViewModel.h"
#import "QueryBreathRateViewModel.h"
#import "QuerySwimViewModel.h"

@interface QueryViewModel()
@property (nonatomic,strong) NSArray * buttonTitles;
@property (nonatomic,strong) NSArray * modelClasss;
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation QueryViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getButtonCallback];
        [self getCellModels];
    }
    return self;
}

- (NSArray *)buttonTitles
{
    if (!_buttonTitles) {
        _buttonTitles = @[@[lang(@"step data query")],@[lang(@"sleep data query")],
                          @[lang(@"heart rate data query")],@[lang(@"blood pressure data query")],
                          @[lang(@"blood oxygen data query")],@[lang(@"pressure data query")],
                          @[lang(@"noise data query")],@[lang(@"temperature data query")],
                          @[lang(@"breath rate data query")],@[lang(@"body power data query")],
                          @[lang(@"activity data query")],@[lang(@"GPS data query")],@[lang(@"swim data query")]];
    }
    return _buttonTitles;
}

- (NSArray *)modelClasss
{
    if (!_modelClasss) {
        _modelClasss = @[[QuerySportsViewModel class],[QuerySleepViewModel class],[QueryHrViewModel class],
                         [QueryBpViewModel class],[QueryBopViewModel class],[QueryPressureViewModel class],
                         [QueryNoiseViewModel class],[QueryTemperatureViewModel class],[QueryBreathRateViewModel class],
                         [QueryBodyPowerViewModel class],[QueryActivityViewModel class],[QueryGpsViewModel class],
                         [QuerySwimViewModel class]];
    }
    return _modelClasss;
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    for (int i = 0; i < self.buttonTitles.count; i++) {
        NSArray * data = [self.buttonTitles objectAtIndex:i];
        FuncCellModel * model = [[FuncCellModel alloc]init];
        model.typeStr = @"oneButton";
        model.data    = data;
        model.cellHeight = 70.0f;
        model.cellClass  = [OneButtonTableViewCell class];
        model.modelClass = self.modelClasss[i];
        model.buttconCallback = self.buttconCallback;
        [cellModels addObject:model];
    }
    self.cellModels = cellModels;
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVc = (FuncViewController *)viewController;
        NSIndexPath * indexPath = [funcVc.tableView indexPathForCell:tableViewCell];
        BaseCellModel * model = [strongSelf.cellModels objectAtIndex:indexPath.row];
        if ([NSStringFromClass(model.modelClass)isEqualToString:@"NSNull"])return;
        FuncViewController * newFuncVc = [FuncViewController new];
        newFuncVc.model = [model.modelClass new];
        newFuncVc.title = [model.data firstObject];
        [funcVc.navigationController pushViewController:newFuncVc animated:YES];
    };
}
@end
