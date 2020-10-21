//
//  SyncConfigViewModel.m
//  IDOBlue
//
//  Created by apple on 2018/10/4.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "SyncConfigViewModel.h"
#import "FuncCellModel.h"
#import "TextViewCellModel.h"
#import "OneButtonTableViewCell.h"
#import "OneTextViewTableViewCell.h"
#import "FuncViewController.h"
#import "IDODemoUtility.h"
#import "NSObject+DemoToDic.h"

@interface SyncConfigViewModel()
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation SyncConfigViewModel

- (void)dealloc
{
    
}

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
        [funcVC showLoadingWithMessage:lang(@"sync config data...")];       
        initSyncManager().wantToSyncType = IDO_WANT_TO_SYNC_CONFIG_ITEM_TYPE;
        initSyncManager().addSyncComplete(^(IDO_SYNC_COMPLETE_STATUS stateCode) {
            if (stateCode == IDO_SYNC_GLOBAL_COMPLETE) {
                [funcVC showToastWithText:lang(@"sync data complete")];
            }
        }).addSyncProgess(^(IDO_CURRENT_SYNC_TYPE type, float progress) {
            [funcVC showSyncProgress:progress];
        }).addSyncFailed(^(int errorCode) {
             NSString * newLogStr = [NSString stringWithFormat:@"%@\n\n%@",strongSelf.textView.text,[IDOErrorCodeToStr errorCodeToStr:errorCode]];
             TextViewCellModel * model = [strongSelf.cellModels firstObject];
             model.data = @[newLogStr?:@""];
             strongSelf.textView.text = newLogStr;
            [funcVC showToastWithText:lang(@"sync data failed")];
        }).addSyncConfig(^(NSString * logStr){
            NSString * newLogStr = [NSString stringWithFormat:@"%@\n%@",strongSelf.textView.text,logStr];
            TextViewCellModel * model = [strongSelf.cellModels firstObject];
            model.data = @[newLogStr?:@""];
            strongSelf.textView.text = newLogStr;
        }).addSyncConfigInitData(^NSArray <IDOBluetoothBaseModel *>* (IDO_SYNC_CONFIG_DATA_TYPE type){
            NSLog(@"type == %ld\n",type);
            return [NSArray array];
        }).mandatorySyncConfig(YES);
        [IDOSyncManager startSync];
    };
}

- (void)getCellModels
{
    NSMutableArray * cellModels = [NSMutableArray array];
    FuncCellModel * model = [[FuncCellModel alloc]init];
    model.typeStr = @"oneButton";
    model.data = @[lang(@"config data sync")];
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
