//
//  MainDialViewModel.m
//  IDOBlue
//
//  Created by 何东阳 on 2019/8/28.
//  Copyright © 2019 hedongyang. All rights reserved.
//

#import "MainDialViewModel.h"
#import "FuncCellModel.h"
#import "OneButtonTableViewCell.h"
#import "FuncViewController.h"
#import "GetWatchScreenInfoViewModel.h"
#import "GetWatchDialListViewModel.h"
#import "TranWatchDialViewModel.h"
#import "SetWatchDialViewModel.h"
#import "SetWallpaperViewModel.h"
#import "GetWatchDialNameViewModel.h"
#import "SetWallpaperCloudViewModel.h"
#import "SetWallpaperCloudView2Model.h"

#import "IDOBlue-Swift.h"



@interface MainDialViewModel ()
@property (nonatomic,strong) NSArray * buttonTitles;
@property (nonatomic,strong) NSArray * modelClasss;
@property (nonatomic,copy)void(^buttconCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@end

@implementation MainDialViewModel

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
        _buttonTitles = @[@[lang(@"get watch screen info")],@[lang(@"get watch dial list info")],@[lang(@"set current dial info")],@[lang(@"transfer dial file")],@[lang(@"custom wallpaper dial")],@[lang(@"get watch dial name")], @[lang(@"SiChe photo cloud dial")], @[lang(@"JieLi wallpaper dial")],@[lang(@"custom photo cloud dial")],@[lang(@"Actions custom photo cloud dial")]];
    }
    return _buttonTitles;
}

- (NSArray *)modelClasss
{
    if (!_modelClasss) {
        _modelClasss = @[[GetWatchScreenInfoViewModel class],[GetWatchDialListViewModel class],[SetWatchDialViewModel class],[TranWatchDialViewModel class],[SetWallpaperViewModel class],[GetWatchDialNameViewModel class], [GetWatchDialNameViewModel class], [GetWatchDialNameViewModel class],[SetWallpaperCloudViewModel class],[SetWallpaperCloudView2Model class]];
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
        if ([[model.data firstObject]  isEqual: lang(@"SiChe photo cloud dial")]) {
            UIViewController * vc = [SiCeDailViewController new];
            [funcVc.navigationController pushViewController: vc animated:true];
            return;
        } else if ([[model.data firstObject]  isEqual: lang(@"JieLi wallpaper dial")]) {
            UIViewController * vc = [RWDailViewController new];
            [funcVc.navigationController pushViewController: vc animated:true];
            return;
        }
        FuncViewController * newFuncVc = [FuncViewController new];
        newFuncVc.model = [model.modelClass new];
        newFuncVc.title = [model.data firstObject];
        [funcVc.navigationController pushViewController:newFuncVc animated:YES];
    };
}
@end
