//
//  StyleCollectionCell.h
//  iOSCamera
//
//  Created by 李达志 on 2018/5/7.
//  Copyright © 2018年 LDZ. All rights reserved.
//  滤镜页面的的风格cell

#import <UIKit/UIKit.h>
static NSString * const KIDStyleCollectionCell=@"KIDStyleCollectionCell";
@interface StyleCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *styleLabel;

@end
