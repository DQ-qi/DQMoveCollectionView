//
//  ViewController.m
//  DQCanMoveCollectionView
//
//  Created by 邓琪 dengqi on 2016/12/16.
//  Copyright © 2016年 邓琪 dengqi. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import "DQTool.h"

#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height
//每个格子的高度
#define GridHeight 122
//每行显示格子的列数
#define PerRowGridCount 3
//每个格子的宽度
#define GridWidth (KScreenWidth/PerRowGridCount-4)
static NSString *DQCell = @"DQCell";
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation ViewController

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 1;
        layout.itemSize = CGSizeMake(GridWidth, GridHeight);
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        UILongPressGestureRecognizer *DQlongGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(DQhandlelongGesture:)];
        [_collectionView addGestureRecognizer:DQlongGesture];
        _collectionView.userInteractionEnabled = YES;
    }
    
    return _collectionView;
}
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:DQCell];
    NSArray *Arr = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];//假如 这是后台返回 要显示的内容 控制显示的内容
    
    NSArray *array = [DQTool InitializeDateFunction:Arr];
    self.dataArr = [array mutableCopy];
    
    [self.collectionView reloadData];
    
}
- (void)DQhandlelongGesture:(UILongPressGestureRecognizer *)longGesture{
    //判断手势状态
    switch (longGesture.state) {
        case UIGestureRecognizerStateBegan:{
            //判断手势落点位置是否在路径上
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[longGesture locationInView:self.collectionView]];
            if (indexPath == nil) {
                break;
            }
            //在路径上则开始移动该路径上的cell
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
        }
            break;
        case UIGestureRecognizerStateChanged:
            
            //移动过程当中随时更新cell位置
            [self.collectionView updateInteractiveMovementTargetPosition:[longGesture locationInView:self.collectionView]];
            break;
        case UIGestureRecognizerStateEnded:
            
            //移动结束后 关闭cell移动
            [self.collectionView endInteractiveMovement];
            
            break;
        default://其他状态取消移动
            [self.collectionView cancelInteractiveMovement];
            break;
    }
}
- (NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DQCell forIndexPath:indexPath];
    [cell SetDataFromModel:self.dataArr[indexPath.row]];
    return cell;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(GridWidth, GridHeight);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 1, 1, 1);
}
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    //从数组中取出 起始位置的数据
    id objc = [self.dataArr objectAtIndex:sourceIndexPath.row];
    //从数组中移除该数据
    [self.dataArr removeObject:objc];
    //将该数据插入到资源数组中的移动后的位置上
    [self.dataArr insertObject:objc atIndex:destinationIndexPath.row];
    //移动结束 保存到本地数据
    [DQTool SaveUserDefaultsDataFunction:self.dataArr];
}


@end
