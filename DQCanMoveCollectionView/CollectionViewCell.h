//
//  CollectionViewCell.h
//  DQMoveCollectionView
//
//  Created by 邓琪 dengqi on 2016/12/16.
//  Copyright © 2016年 邓琪 dengqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DQModel;
@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;

- (void)SetDataFromModel:(DQModel *)model;

@end
