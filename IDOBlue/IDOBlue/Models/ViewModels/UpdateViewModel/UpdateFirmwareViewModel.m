//
//  UpdateViewModel.m
//  IDOBluetoothDemo
//
//  Created by apple on 2018/9/16.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "UpdateFirmwareViewModel.h"
#import "FileViewModel.h"
#import "TabCellModel.h"
#import "LabelCellModel.h"
#import "TextViewCellModel.h"
#import "FuncViewController.h"
#import "OneLabelTableViewCell.h"
#import "ThreeButtonTableViewCell.h"
#import "OneTextViewTableViewCell.h"
#import "ScanViewController.h"
#import "FirmwareTypeViewModel.h"
#import "OneLabelTableViewCell.h"

@interface UpdateFirmwareViewModel()<IDOUpdateManagerDelegate>
@property (nonatomic,copy) NSString * logStr;
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,strong) NSString * filePath;
@property (nonatomic,assign) BOOL updating;
@property (nonatomic,copy)void(^textViewCallback)(UITextView * textView);
@property (nonatomic,copy)void(^labelSelectCallback)(UIViewController * viewController,UITableViewCell * tableViewCell);
@property (nonatomic,copy)void(^threeButtonCallback)(NSInteger index,UITableViewCell * tableViewCell);;
@end

@implementation UpdateFirmwareViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.updating = NO;
        self.rightButtonTitle = lang(@"selected firmware");
        self.isRightButton = YES;
        self.rightButton   = @selector(actionButton:);
        [self getButtonCallback];
        [self getLabelSelectCallback];
        [self getTextViewCallback];
        [self getCellModels];
        [IDOUpdateFirmwareManager shareInstance].delegate = self;
    }
    return self;
}

- (void)actionButton:(UIButton *)sender
{
    FuncViewController * vc = [[FuncViewController alloc]init];
    FileViewModel * fileModel = [FileViewModel new];
    fileModel.type = 0;
    __weak typeof(self) weakSelf = self;
    fileModel.viewWillDisappearCallback = ^(UIViewController *viewController) {
        __strong typeof(self) strongSelf = weakSelf;
        NSString * filePath = [[NSUserDefaults standardUserDefaults]objectForKey:FIRMWARE_FILE_PATH_KEY];
        NSString * infoStr = [strongSelf getCuttentFirmwareFileInfo:filePath];
        [strongSelf addMessageText:infoStr];
    };
    vc.model = fileModel;
    vc.title = lang(@"selected firmware");
    [[IDODemoUtility getCurrentVC].navigationController pushViewController:vc animated:YES];
}

- (void)getCellModels
{
    NSString * filePath = [[NSUserDefaults standardUserDefaults]objectForKey:FIRMWARE_FILE_PATH_KEY];
    self.logStr = [self getCuttentFirmwareFileInfo:filePath];
    
    NSString * fileType = [[NSUserDefaults standardUserDefaults]objectForKey:FIRMWARE_FILE_TYPE_KEY];
    if (!fileType) fileType = @"Application";
    
    TabCellModel * model1 = [[TabCellModel alloc]init];
    model1.typeStr = @"threeButton";
    model1.data = @[lang(@"exit update"),lang(@"reconnect"),lang(@"firmware update")];
    model1.selectIndexs = @[[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES]];
    model1.cellHeight = 70.0f;
    model1.isShowLine = YES;
    model1.cellClass = [ThreeButtonTableViewCell class];
    model1.modelClass = [NSNull class];
    model1.threeButtonCallback = self.threeButtonCallback;

    LabelCellModel * model2 = [[LabelCellModel alloc]init];
    model2.typeStr = @"oneLabel";
    model2.data    = @[[NSString stringWithFormat:@"Type : %@",fileType]];
    model2.cellHeight = 45.0f;
    model2.isShowLine = YES;
    model2.labelSelectCallback = self.labelSelectCallback;
    model2.cellClass  = [OneLabelTableViewCell class];
    model2.modelClass = [NSNull class];
    
    TextViewCellModel * model3 = [[TextViewCellModel alloc]init];
    model3.typeStr = @"oneTextView";
    model3.data    = @[self.logStr ?: @""];
    model3.textViewCallback = self.textViewCallback;
    model3.isShowLine = YES;
    model3.cellHeight = [UIScreen mainScreen].bounds.size.height / 2 - 20;
    model3.cellClass  = [OneTextViewTableViewCell class];
    
    self.cellModels = @[model2,model1,model3];
}

- (void)getButtonCallback
{
    __weak typeof(self) weakself = self;
    self.threeButtonCallback = ^(NSInteger index, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakself;
      FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
        if (index == 0) {
            [funcVC showLoadingWithMessage:lang(@"exit update...")];
            [IDOFoundationCommand mandatoryUnbindingCommand:^(int errorCode) {
                if (errorCode == 0) {
                    [funcVC showToastWithText:lang(@"exit success")];
                    ScanViewController * scanVC  = [[ScanViewController alloc]init];
                    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:scanVC];
                    [UIApplication sharedApplication].delegate.window.rootViewController = nav;
                    for (UIView * view in [UIApplication sharedApplication].keyWindow.subviews) {
                        if ([NSStringFromClass([view class]) isEqualToString:@"UITransitionView"]) {
                            [view removeFromSuperview];
                        }
                    }
                }else {
                    [funcVC showToastWithText:lang(@"exit failed")];
                }
            }];
        }else if (index == 1) {
            if (strongSelf.updating)return;
            if (IDO_BLUE_ENGINE.managerEngine.isConnected) {
                 [funcVC showToastWithText:lang(@"device connected not need reconnected")];
                return;
            }
            [IDOBluetoothManager startScan];
        }else if (index == 2) {
            if (strongSelf.updating)return;
            if (!IDO_BLUE_ENGINE.managerEngine.isConnected)return;
            [funcVC showLoadingWithMessage:lang(@"enter update...")];
            [IDOUpdateFirmwareManager startUpdate];
        }
    };
}

- (void)getLabelSelectCallback
{
    __weak typeof(self) weakSelf = self;
    self.labelSelectCallback = ^(UIViewController *viewController, UITableViewCell *tableViewCell) {
        __strong typeof(self) strongSelf = weakSelf;
        FuncViewController * funcVc = [[FuncViewController alloc]init];
        FirmwareTypeViewModel * typeModel = [FirmwareTypeViewModel new];
        typeModel.viewWillDisappearCallback = ^(UIViewController *viewController) {
            OneLabelTableViewCell * cell = (OneLabelTableViewCell *)tableViewCell;
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            LabelCellModel * labelModel = [strongSelf.cellModels objectAtIndex:indexPath.row];
            NSString * fileType = [[NSUserDefaults standardUserDefaults]objectForKey:FIRMWARE_FILE_TYPE_KEY];
            if (!fileType) fileType = @"Application";
            labelModel.data = @[[NSString stringWithFormat:@"Type : %@",fileType]];
            cell.title.text = [NSString stringWithFormat:@"Type : %@",fileType];
        };
        funcVc.model = typeModel;
        funcVc.title = lang(@"firmware type");
        [viewController.navigationController pushViewController:funcVc animated:YES];
    };
}

- (void)getTextViewCallback
{
    __weak typeof(self) weakSelf = self;
    self.textViewCallback = ^(UITextView *textView) {
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.textView = textView;
    };
}

- (NSString *)getCuttentFirmwareFileInfo:(NSString *)filePath
{
    if (filePath.length == 0) return @"";
    NSURL * fileUrl = [NSURL URLWithString:filePath];
    NSInteger type = [[NSUserDefaults standardUserDefaults]integerForKey:PRODUCTION_MODE_KEY];
    NSString * path = nil;
    if(type == 0) {
        NSString * docsdir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject];
        path = [docsdir stringByAppendingPathComponent:@"Firmwares"];
    }else {
        NSString * filePath = [NSBundle mainBundle].bundlePath;
        path = [filePath stringByAppendingPathComponent:@"Firmwares"];
    }
    filePath = [path stringByAppendingPathComponent:fileUrl.lastPathComponent];
    self.filePath = filePath;
    
    NSData * data = [NSData dataWithContentsOfFile:filePath];
    NSString * dataSize = [NSString stringWithFormat:@"%ld bytes",(long)data.length];
    NSString * nameStr = [@"Name : "stringByAppendingString:fileUrl.lastPathComponent];
    NSString * sizeStr = [@"Size : "stringByAppendingString:dataSize];
    NSString * fileType = [[NSUserDefaults standardUserDefaults]objectForKey:FIRMWARE_FILE_TYPE_KEY];
    if (!fileType) fileType = @"Application";
    NSString * typeStr = [@"Type : "stringByAppendingString:fileType];
    NSString * fileStr = [NSString stringWithFormat:@"%@\n%@\n%@",nameStr,sizeStr,typeStr];
    return fileStr;
}

- (void)addMessageText:(NSString *)message
{
    self.logStr = [NSString stringWithFormat:@"%@\n\n%@",self.textView.text,message];
    self.textView.text = self.logStr;
    [self.textView scrollRangeToVisible:NSMakeRange(self.textView.text.length, 1)];
}

#pragma mark ======================== IDOUpdateMangerDelegate===================================
- (NSString *)currentPackagePathWithUpdateManager:(IDOUpdateFirmwareManager *)manager
{
    return self.filePath;
}

- (void)updateManager:(IDOUpdateFirmwareManager *)manager
                state:(IDO_UPDATE_STATE)state
{
    FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
    if (state == IDO_UPDATE_COMPLETED) {
        self.updating = NO;
        funcVC.statusLabel.text = lang(@"update success");
        [funcVC showToastWithText:lang(@"update success")];
        if (!__IDO_BIND__) {
            [IDOFoundationCommand mandatoryUnbindingCommand:^(int errorCode) {
                if (errorCode == 0) {
                    ScanViewController * scanVC  = [[ScanViewController alloc]init];
                    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:scanVC];
                    [UIApplication sharedApplication].delegate.window.rootViewController = nav;
                }
            }];
        }
    }else {
       self.updating = YES;
       funcVC.statusLabel.text = lang(@"update...");
    }
}

- (void)updateManager:(IDOUpdateFirmwareManager *)manager updateError:(NSError *)error
{
    FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
    funcVC.statusLabel.text = lang(@"update failed");
    [funcVC showToastWithText:lang(@"update failed")];
    self.updating = NO;
    NSString * errorStr = [NSString stringWithFormat:@"%@\n",error.domain];
    [self addMessageText:errorStr];
}

- (void)updateManager:(IDOUpdateFirmwareManager *)manager
             progress:(float)progress
              message:(NSString *)message
{
    if (progress > 0) {
        FuncViewController * funcVC = (FuncViewController *)[IDODemoUtility getCurrentVC];
        [funcVC showUpdateProgress:progress];
    }else {
        [self addMessageText:message?:@""];
    }
}

/********此方法可以忽略*********/
- (IDO_UPDATE_DFU_FIRMWARE_TYPE)selectDfuFirmwareTypeWithUpdateManager:(IDOUpdateFirmwareManager * _Nullable)manager {
    NSString * fileType = [[NSUserDefaults standardUserDefaults]objectForKey:FIRMWARE_FILE_TYPE_KEY];
    if (!fileType) fileType = @"Application";
    IDO_UPDATE_DFU_FIRMWARE_TYPE type = IDO_DFU_FIRMWARE_APPLICATION_TYPE;
    if (![fileType isEqualToString:@"Application"]) {
        type = [self.pickerDataModel.firmwareTypes indexOfObject:fileType] + 1;
    }
    return type;
}


@end
