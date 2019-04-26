//
//  SyncActivityViewModel.m
//  IDOBlue
//
//  Created by apple on 2018/10/4.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "SyncActivityViewModel.h"
#import "FuncCellModel.h"
#import "TextViewCellModel.h"
#import "OneButtonTableViewCell.h"
#import "OneTextViewTableViewCell.h"
#import "FuncViewController.h"
#import "IDODemoUtility.h"
#import "NSObject+DemoToDic.h"

@interface SyncActivityViewModel()
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation SyncActivityViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getButtonCallback];
        [self getTextViewCallback];
        [self getCellModels];
    }
    return self;
}

- (void)getTextViewCallback
{
    __weak typeof(self) weakSelf = self;
    self.textViewCallback = ^(UITextView *textView) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
        funcVC.tableView.scrollEnabled = NO;
        strongSelf.textView = textView;
    };
}

- (void)getButtonCallback
{
    __weak typeof(self) weakSelf = self;
    self.buttconCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVC = (FuncViewController *)viewController;
        [funcVC showLoadingWithMessage:lang(@"sync activity data...")];
        [IDOFoundationCommand getActivityCountCommand:^(int errorCode,
                                                        IDOGetActivityCountBluetoothModel * _Nullable data) {
            if (errorCode == 0) {
                if (data.activityCount > 0) {
                    //活动同步日志
                    [IDOSyncActivity syncActivityDataCallback:^(NSString * _Nullable jsonStr) {
                        if (![IDOConsoleBoard borad].isShow) {
                            NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,jsonStr];
                            TextViewCellModel * model = [strongSelf.cellModels firstObject];
                            model.data = @[newLogStr?:@""];
                            strongSelf.textView.text = newLogStr;
                        }
                        // [strongSelf.textView scrollRangeToVisible:NSMakeRange(strongSelf.textView.text.length, 1)];
                    }];
                    //活动同步进度
                    [IDOSyncActivity syncAcitvityDataProgressCallback:^(int progress) {
                        if (![IDOConsoleBoard borad].isShow) {
                            NSString * activityStr = [NSString stringWithFormat:@"%@...%d",@"SYNC_ACTIVITY_PROGRESS",progress];
                            NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,activityStr];
                            TextViewCellModel * model = [strongSelf.cellModels firstObject];
                            model.data = @[newLogStr?:@""];
                            strongSelf.textView.text = newLogStr;
                            //[strongSelf.textView scrollRangeToVisible:NSMakeRange(strongSelf.textView.text.length, 1)];
                            [funcVC showSyncProgress:progress/100.0f];
                        }
                    }];
                    //活动同步完成
                    [IDOSyncActivity syncAcitvityDataCompleteCallback:^(int errorCode) {
                        if (![IDOConsoleBoard borad].isShow) {
                            NSString * errorStr = [IDOErrorCodeToStr errorCodeToStr:errorCode];
                            NSString * activityStr = [NSString stringWithFormat:@"%@ ERROR_CODE = %@",@"SYNC_ACTIVITY_COMPLETE",errorStr];
                            NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,activityStr];
                            TextViewCellModel * model = [strongSelf.cellModels firstObject];
                            model.data = @[newLogStr?:@""];
                            strongSelf.textView.text = newLogStr;
                        }
                     //   [strongSelf.textView scrollRangeToVisible:NSMakeRange(strongSelf.textView.text.length, 1)];
                        [funcVC showToastWithText:lang(@"sync activity data complete")];
                    }];
                    //活动同步开始
                    [IDOSyncActivity startSync];
                }else {
                    if (![IDOConsoleBoard borad].isShow) {
                        NSString * activityStr = [NSString stringWithFormat:@"%@...%d",@"SYNC_ACTIVITY_COUNT",0];
                        NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,activityStr];
                        TextViewCellModel * model = [strongSelf.cellModels firstObject];
                        model.data = @[newLogStr?:@""];
                        strongSelf.textView.text = newLogStr;
                    }
                   // [strongSelf.textView scrollRangeToVisible:NSMakeRange(strongSelf.textView.text.length, 1)];
                    [funcVC showToastWithText:lang(@"no activity data sync")];
                }
            }else {
                [funcVC showToastWithText:lang(@"get activity count failed")];
            }
        }];
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    FuncCellModel * model = [[FuncCellModel alloc]init];
    model.typeStr = @"oneButton";
    model.data = @[lang(@"activity data sync")];
    model.cellHeight = 70.0f;
    model.cellClass = [OneButtonTableViewCell class];
    model.modelClass = [NSNull class];
    model.isShowLine = YES;
    model.buttconCallback = self.buttconCallback;
    [cellModels addObject:model];
    
    TextViewCellModel * model2 = [[TextViewCellModel alloc]init];
    model2.typeStr = @"oneTextView";
    model2.cellHeight = [IDODemoUtility getCurrentVC].view.bounds.size.height-110;
    model2.cellClass  = [OneTextViewTableViewCell class];
    model2.textViewCallback = self.textViewCallback;
    [cellModels addObject:model2];
    
    self.cellModels = cellModels;
}

@end
