//
//  CollectionViewCell.m
//  DQMoveCollectionView
//
//  Created by 邓琪 dengqi on 2016/12/16.
//  Copyright © 2016年 邓琪 dengqi. All rights reserved.
//

#import "CollectionViewCell.h"
#import "DQModel.h"


@interface CollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *backImg;

@property (weak, nonatomic) IBOutlet UIImageView *TitleImg;


@end

@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)SetDataFromModel:(DQModel *)model{

    self.TitleImg.image = [UIImage imageNamed:model.image];
    self.title.text = model.title;

}

@end
