//
//  FiterImageCollectCell.m
//  iOSCamera
//
//  Created by 李达志 on 2018/5/5.
//  Copyright © 2018年 LDZ. All rights reserved.
//

#import "FiterImageCollectCell.h"
@interface FiterImageCollectCell ()
@property (weak, nonatomic) IBOutlet UIImageView *effectImageView;
@property (weak, nonatomic) IBOutlet UILabel *filterLabel;

@end
@implementation FiterImageCollectCell

- (void)awakeFromNib {
    [super awakeFromNib];

}
-(void)setItem:(DmEffectItem *)item{
    self.effectImageView.image=item.effctImage;
    self.filterLabel.text=item.effctStr;
}
@end
