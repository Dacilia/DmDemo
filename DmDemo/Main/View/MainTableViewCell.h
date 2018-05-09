//
//  MainTableViewCell.h
//  iOSCamera
//
//  Created by 李达志 on 2018/4/7.
//  Copyright © 2018年 LDZ. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const KIDMainTableViewCell=@"KIDMainTableViewCell";
static CGFloat const KHeightMainTableViewCell=50;
@interface MainTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;

@end
