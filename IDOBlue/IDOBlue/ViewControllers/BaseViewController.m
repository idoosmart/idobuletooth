//
//  ViewController.m
//  IDOBluetoothDemo
//
//  Created by hedongyang on 2018/8/31.
//  Copyright © 2018年 hedongyang. All rights reserved.
//

#import "BaseViewController.h"
#import "TipPoweredOffView.h"

@interface BaseViewController ()
@end

@implementation BaseViewController

- (void)dealloc
{
    if (IDO_BLUE_ENGINE.managerEngine) {
        [IDO_BLUE_ENGINE.managerEngine removeObserver:self forKeyPath:@"idoManager.state"];
        [IDO_BLUE_ENGINE.managerEngine removeObserver:self forKeyPath:@"idoManager.errorCode"];
        [IDO_BLUE_ENGINE.managerEngine removeObserver:self forKeyPath:@"idoManager.manualConnectTotalTime"];
        [IDO_BLUE_ENGINE.managerEngine removeObserver:self forKeyPath:@"idoManager.autoConnectTotalTime"];
    }
}

- (UILabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc]initWithFrame:CGRectMake(16,0,(self.view.frame.size.width - 32)/2,40)];
        _statusLabel.textColor = [UIColor blackColor];
        _statusLabel.textAlignment = NSTextAlignmentLeft;
        _statusLabel.font = [UIFont boldSystemFontOfSize:16];
        _statusLabel.backgroundColor = [UIColor clearColor];
    }
    _statusLabel.text = IDO_BLUE_ENGINE.managerEngine.isConnected ? lang(@"connected") : IDO_BLUE_ENGINE.managerEngine.isConnecting ? lang(@"connecting") : lang(@"scanning");
    return _statusLabel;
}

- (UILabel *)timerLabel
{
    if (!_timerLabel) {
        _timerLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2,0,(self.view.frame.size.width - 32)/2,40)];
        _timerLabel.textColor = [UIColor blackColor];
        _timerLabel.textAlignment = NSTextAlignmentCenter;
        _timerLabel.font = [UIFont boldSystemFontOfSize:16];
        _timerLabel.backgroundColor = [UIColor clearColor];
    }
    return _timerLabel;
}

- (void)showLoadingWithMessage:(NSString *)message
{
    self.progressHUD.mode = MBProgressHUDModeIndeterminate;
    self.progressHUD.label.text = message;
    [self.progressHUD showAnimated:YES];
}

- (void)showToastWithText:(NSString *)message
{
    self.progressHUD.mode = MBProgressHUDModeText;
    self.progressHUD.label.text = message;
    [self.progressHUD showAnimated:YES];
    [self.progressHUD hideAnimated:YES afterDelay:2];
}

- (void)showUpdateProgress:(float)progress
{
    self.progressHUD.mode = MBProgressHUDModeDeterminateHorizontalBar;
    self.progressHUD.label.text = [NSString stringWithFormat:@"%@%.2f%@",lang(@"file update"),progress*100.0f,@"%"];
    self.progressHUD.progress = progress;
    [self.progressHUD showAnimated:YES];
}

- (void)showSyncProgress:(float)progress
{
    self.progressHUD.mode = MBProgressHUDModeDeterminateHorizontalBar;
    self.progressHUD.label.text = [NSString stringWithFormat:@"%@%.2f%@",lang(@"sync data"),progress*100.0f,@"%"];
    self.progressHUD.progress = progress;
    [self.progressHUD showAnimated:YES];
}

- (MBProgressHUD *)progressHUD
{
    if (!_progressHUD) {
        _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:_progressHUD];
    }
    return _progressHUD;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self modificationNavigationBarStyle];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent=NO;
    self.view.backgroundColor = [UIColor whiteColor];
    if (IDO_BLUE_ENGINE.managerEngine) {
        [IDO_BLUE_ENGINE.managerEngine addObserver:self forKeyPath:@"idoManager.state" options:NSKeyValueObservingOptionNew context:nil];
        [IDO_BLUE_ENGINE.managerEngine addObserver:self forKeyPath:@"idoManager.errorCode" options:NSKeyValueObservingOptionNew context:nil];
        [IDO_BLUE_ENGINE.managerEngine addObserver:self forKeyPath:@"idoManager.manualConnectTotalTime" options:NSKeyValueObservingOptionNew context:nil];
        [IDO_BLUE_ENGINE.managerEngine addObserver:self forKeyPath:@"idoManager.autoConnectTotalTime" options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"idoManager.state"]) {
        IDO_BLUETOOTH_MANAGER_STATE state = (IDO_BLUETOOTH_MANAGER_STATE)[change[NSKeyValueChangeNewKey] integerValue];
        if (state == IDO_MANAGER_STATE_DID_CONNECT) {
            self.statusLabel.text = lang(@"connected");
            [self showToastWithText:lang(@"connected")];
        }
        else if(state == IDO_MANAGER_STATE_CONNECT_FAILED) {
            self.statusLabel.text = lang(@"disconnected");
            [self showToastWithText:lang(@"device disconnected")];
        }else if((   state == IDO_MANAGER_STATE_AUTO_OTA_CONNECT
                 || state == IDO_MANAGER_STATE_AUTO_CONNECT
                 || state == IDO_MANAGER_STATE_MANUAL_OTA_CONNECT
                 || state == IDO_MANAGER_STATE_MANUAL_CONNECT )
                 && (__IDO_BIND__ || __IDO_OTA__)){
            self.statusLabel.text = lang(@"connecting");
            [self showLoadingWithMessage:lang(@"connecting")];
        }else if (state == IDO_MANAGER_STATE_AUTO_SCANING) {
            self.statusLabel.text = lang(@"scanning");
            [self showLoadingWithMessage:lang(@"scanning")];
        }else if (state == IDO_MANAGER_STATE_SCAN_STOP) {
            self.statusLabel.text = lang(@"suspend scan");
            [self showToastWithText: lang(@"device suspend scan")];
        }else if (state == IDO_MANAGER_STATE_POWEREDOFF) {
            self.statusLabel.text = lang(@"disconnected");
            [self showToastWithText:lang(@"device disconnected")];
            [TipPoweredOffView show];
        }else if (state == IDO_MANAGER_STATE_POWEREDON) {
            [TipPoweredOffView hidView];
        }
    }else if ([keyPath isEqualToString:@"idoManager.manualConnectTotalTime"]) {
        NSInteger totalTime = [change[NSKeyValueChangeNewKey] integerValue];
        if (totalTime <= 0)return;
        self.timerLabel.text = [NSString stringWithFormat:@"%@ %ld",lang(@"manual connect time"),(long)totalTime];
    }else if ([keyPath isEqualToString:@"idoManager.autoConnectTotalTime"]) {
        NSInteger totalTime = [change[NSKeyValueChangeNewKey] integerValue];
        if (totalTime <= 0)return;
        self.timerLabel.text = [NSString stringWithFormat:@"%@ %ld",lang(@"auto connect time"),(long)totalTime];
    }
}

- (void)modificationNavigationBarStyle
{
    UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] init];
    backButtonItem.style = UIBarButtonItemStyleDone;
    backButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = backButtonItem;
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
}

- (BasePickerView *)pickerView
{
    if (!_pickerView) {
        _pickerView = [[BasePickerView alloc]init];
        [self.view addSubview:_pickerView];
        [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.top.equalTo(self.view.mas_bottom);
            make.height.equalTo(@216);
        }];
    }
    return _pickerView;
}

- (BaseDatePickerView *)datePickerView
{
    if (!_datePickerView) {
        _datePickerView = [[BaseDatePickerView alloc]init];
        [self.view addSubview:_datePickerView];
        [_datePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.top.equalTo(self.view.mas_bottom);
            make.height.equalTo(@216);
        }];
    }
    return _datePickerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

