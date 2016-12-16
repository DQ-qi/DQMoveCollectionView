//
//  DQTool.m
//  DQMoveCollectionView
//
//  Created by 邓琪 dengqi on 2016/12/16.
//  Copyright © 2016年 邓琪 dengqi. All rights reserved.
//

#import "DQTool.h"
#import "DQModel.h"

static NSString *KDQUserDefauls = @"KDQUserDefauls";

@implementation DQTool

+ (BOOL)isExistUserDefaultsDateFunction{

    BOOL ret = NO;
    NSUserDefaults *userDefaluts = [NSUserDefaults standardUserDefaults];
    NSArray *arr = [userDefaluts objectForKey:KDQUserDefauls];
    if (arr) {
        ret = YES;
        
    }
    return ret;
}


+ (NSArray *)AccordingToRequirementsLoadData:(NSArray *)RequirementsArr{
    
    NSArray *allArr = [self LoadAllDataFromInitializeFunction];
    if (RequirementsArr.count>allArr.count) {
        NSLog(@"传入的数据有误!");
    }
    
    
    NSMutableArray *dataArr = [NSMutableArray new];
    for (NSInteger i=0; i<RequirementsArr.count; i++) {
        NSInteger index = [RequirementsArr[i] intValue];
        if (index>=allArr.count) {
            NSLog(@"传入的数据有误!");
        }else{
            DQModel *model = allArr[index];
            [dataArr addObject:model];
        
        }
    }
    return dataArr;
}


+ (NSArray *)LoadAllDataFromInitializeFunction{
    
    NSArray *titleArr =  @[@"系统管理",@"人力资源管理",@"考勤管理", @"PM管理", @"财务管理",@"行政管理",@"信息门户", @"我的待办", @"请假申请", @"分配任务"];
    NSArray *imageArr = @[@"administrative.png",@"door.png", @"money.png",@"administrative.png",@"door.png", @"money.png",@"administrative.png",@"door.png", @"money.png",@"administrative.png"];
    
    NSMutableArray *muArr = [NSMutableArray new];
    for (NSInteger i=0; i<titleArr.count; i++) {
        DQModel *model = [DQModel new];
        model.title = titleArr[i];
        model.image = imageArr[i];
        [muArr addObject:model];
    }
    
    return muArr;
}


+ (void)SaveUserDefaultsDataFunction:(NSArray *)ChangeArr{
    
    NSMutableArray *muArr = [NSMutableArray new];
    for (NSInteger i=0; i<ChangeArr.count; i++) {
        DQModel *model = ChangeArr[i];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model] ;
        [muArr addObject:data];
    }
    [[NSUserDefaults standardUserDefaults] setObject:muArr forKey:KDQUserDefauls];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


+ (NSArray *)ReadeUserDefaultsDataFunction{
    NSUserDefaults *userDefaluts = [NSUserDefaults standardUserDefaults];
    NSArray *arr = [userDefaluts objectForKey:KDQUserDefauls];
    NSMutableArray *muArr = [NSMutableArray new];
    
    for (NSInteger i=0; i<arr.count; i++) {
        NSData *data = arr[i];
        DQModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [muArr addObject:model];
    }
    return muArr;
}

+ (NSArray *)InitializeDateFunction:(NSArray *)RequirementsArr{

    BOOL ret = [self isExistUserDefaultsDateFunction];
    NSArray *Arr = [self AccordingToRequirementsLoadData:RequirementsArr];
    
    if (ret == NO) {//本地没有数据
        
        [self SaveUserDefaultsDataFunction:Arr];
        return Arr;
        
    }else{//本地有数据
        
        NSArray *UserArr = [self ReadeUserDefaultsDataFunction];
        // 对比数组
        NSMutableString * defaString = [[NSMutableString alloc]init];
        NSMutableString * localString = [[NSMutableString alloc]init];
        NSMutableArray *AllArr = [NSMutableArray arrayWithArray:Arr];
        NSMutableArray *AllArr1 = [NSMutableArray arrayWithArray:UserArr];
        
        //将数组排序 主要是判断 两个数组的内容一样 但是排序不一样
        for (NSInteger i=0; i<AllArr.count; i++) {
            for (NSInteger j=i+1; j<AllArr.count; j++) {
                DQModel *model1 = AllArr[i];
                DQModel *model2 = AllArr[j];
                if ([model1.title  compare:model2.title]==NSOrderedAscending) {
                    [AllArr exchangeObjectAtIndex:i withObjectAtIndex:j];
                }
                
            }
        }
        
        for (NSInteger i=0; i<AllArr1 .count; i++) {
            for (NSInteger j=i+1; j<AllArr1.count; j++) {
                DQModel *model1 = AllArr1[i];
                DQModel *model2 = AllArr1[j];
                if ([model1.title  compare:model2.title]==NSOrderedAscending) {
                    [AllArr1 exchangeObjectAtIndex:i withObjectAtIndex:j];
                }
                
            }
        }
        for (DQModel *objc in AllArr) {
            [defaString appendString:objc.title];
        }
        for (DQModel *objc in AllArr1) {
            [localString appendString:objc.title];
        }
        
        
        // 要显示的数据和本地数组有改变 用显示数据
        if (![localString isEqualToString:defaString] && localString.length>2) {//重新赋值
            
            [self SaveUserDefaultsDataFunction:Arr];
            return Arr;
        }else{//取本地
        
            return UserArr;
        }
    }

}
@end
