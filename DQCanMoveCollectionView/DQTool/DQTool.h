//
//  DQTool.h
//  DQMoveCollectionView
//
//  Created by 邓琪 dengqi on 2016/12/16.
//  Copyright © 2016年 邓琪 dengqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DQTool : NSObject

//已下三个方法 为预留的方法借口
/** 本地UserDefaults的数据是否有数据 **/
+ (BOOL)isExistUserDefaultsDateFunction;

/** 按条件加载数据 根据下标加载数据 **/
+ (NSArray *)AccordingToRequirementsLoadData:(NSArray *)RequirementsArr;

/** 加载所有的数据 **/
+ (NSArray *)LoadAllDataFromInitializeFunction;


//用以下三个方法即可
/** 初始化调用该方法即可 **/
+ (NSArray *)InitializeDateFunction:(NSArray *)RequirementsArr;

/** 保存数据到UserDefaults **/
+ (void)SaveUserDefaultsDataFunction:(NSArray *)ChangeArr;

/** 读取UserDefaults本地数据 **/
+ (NSArray *)ReadeUserDefaultsDataFunction;

@end
