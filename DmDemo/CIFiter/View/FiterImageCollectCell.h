//
//  FiterImageCollectCell.h
//  iOSCamera
//
//  Created by 李达志 on 2018/5/5.
//  Copyright © 2018年 LDZ. All rights reserved.
//  装载效果图的cell

#import <UIKit/UIKit.h>
#import "DmEffectItem.h"
static NSString* const KIDFiterImageCollectCell=@"KIDFiterImageCollectCell";
@interface FiterImageCollectCell : UICollectionViewCell
@property (nonatomic,strong) DmEffectItem * item;
@end
