//
//  DmEffectItem.h
//  iOSCamera
//
//  Created by 李达志 on 2018/5/5.
//  Copyright © 2018年 LDZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DmEffectItem : NSObject
/** 滤镜后的图片 */
@property (nonatomic,strong) UIImage * effctImage;
/** 滤镜名字 (个人崴脚翻译) */
@property (nonatomic,copy) NSString * effctStr;
/** 是否选中当前 */
@property (nonatomic,assign) BOOL isSelected;
+(instancetype)dmEffectItem:(UIImage*)effctImage effctStr:(NSString*)effctStr;
@end
