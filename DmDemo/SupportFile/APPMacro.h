//
//  APPMacro.h
//  iOSCamera
//
//  Created by 李达志 on 2018/4/24.
//  Copyright © 2018年 LDZ. All rights reserved.
//

#ifndef APPMacro_h
#define APPMacro_h
/** RGB创建Color */
#define RGBColor(r,g,b) ([UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0])
#define RGBAColor(r,g,b,a) ([UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a])
/** 16进制色值创建Color  十六进制格式:0xFFFFFF*/
#define HexColor(hex) ([UIColor colorWithRed:((CGFloat)((hex & 0xFF0000) >> 16))/255.0 green:((CGFloat)((hex & 0xFF00)>>8))/255.0 blue:((CGFloat)(hex & 0xFF))/255.0 alpha:1.0])
#define kScreenWidth    [[UIScreen mainScreen] bounds].size.width   // 屏幕宽
#define kScreenHeight   [[UIScreen mainScreen] bounds].size.height  // 屏幕高
#define KQRBGCOLOR RGBAColor(0,0,0,0.8)
#endif /* APPMacro_h */
