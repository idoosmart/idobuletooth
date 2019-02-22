//
//  IDORecordDeviceLog.h
//  IDOBluetooth
//
//  Created by hedongyang on 2018/9/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDORecordDeviceLog : NSObject

/**
 * @brief 获取设备日志信息 （在设备连接，并不在ota模式下使用获取设备重启日志）
 * Obtain device log information (When the device is connected, it is not used in the ota mode to get the device restart log)
 * @param callback 日志信息获取完成回调 | Log information acquisition completion callback
 */
+ (void)getDeviceLogWithCallback:(void(^)(BOOL isComplete))callback;

/**
 * @brief 设备重启日志路径 | Device restart log path
 * @return 日志存储目录 目录下可能有多个日志文件 日志文件是按日期生成的
 * Log Storage Directory There may be multiple log files under the directory. The log files are generated by date.
 */
+ (NSString *)rebootLogFloderPath;

/**
 * @brief 命令执行记录日志路径 | Command execution logging path
 * @return 日志存储目录 目录下可能有多个日志文件 日志文件是按日期生成的
 * Log Storage Directory There may be multiple log files under the directory. The log files are generated by date.
 */
+ (NSString *)recordLogFloaderPath;

@end
