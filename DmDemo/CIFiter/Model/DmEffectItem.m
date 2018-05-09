//
//  DmEffectItem.m
//  iOSCamera
//
//  Created by 李达志 on 2018/5/5.
//  Copyright © 2018年 LDZ. All rights reserved.
//

#import "DmEffectItem.h"

@implementation DmEffectItem
+(instancetype)dmEffectItem:(UIImage *)effctImage effctStr:(NSString *)effctStr{
    DmEffectItem*item=[[DmEffectItem alloc]init];
    item.effctImage=effctImage;
    item.effctStr=effctStr;
    return item;
}
@end
