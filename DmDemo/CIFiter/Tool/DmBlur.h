//
//  DmBlur.h
//  iOSCamera
//
//  Created by 李达志 on 2018/5/7.
//  Copyright © 2018年 LDZ. All rights reserved.
//  kCICategoryBlur_模糊，比如高斯模糊、焦点模糊、运动模糊

#import <Foundation/Foundation.h>

@interface DmBlur : NSObject
/**
 CIBoxBlur
 用盒形卷积核模糊图像。
 */
+(UIImage*)dmCIBoxBlurInputImage:(UIImage*)inputImage;
/**
 CIDiscBlur
 Blurs an image using a disc-shaped convolution kernel.
用圆盘状的卷积核来模糊图像。
 */
+(UIImage*)dmCIDiscBlurInputImage:(UIImage*)inputImage;
/**
 CIGaussianBlur
 按高斯分布指定的数量传播源像素。
 */
+(UIImage*)dmCIGaussianBlurInputImage:(UIImage*)inputImage;

/**
 CIMaskedVariableBlur
 根据掩模图像中的亮度等级模糊源图像。
 */
+(UIImage*)dmCIMaskedVariableBlurInputImage:(UIImage*)inputImage inputMask:(UIImage*)inputMask;
/**
 CIMedianFilter
 */
+(UIImage*)dmCIMedianFilterInputImage:(UIImage*)inputImage;
/**
 CIMotionBlur
 模糊图像，以模拟使用相机在捕捉图像时移动指定角度和距离的效果。
 */
+(UIImage*)dmCIMotionBlurInputImage:(UIImage*)inputImage;
/**
 CINoiseReduction
 使用阈值来降低噪声，以定义什么是噪声。
 */
+(UIImage*)dmCINoiseReductionInputImage:(UIImage*)inputImage;
/**
 CIZoomBlur
 在捕捉图像的同时模拟了放大摄像头的效果。
 */
+(UIImage*)dmCIZoomBlurInputImage:(UIImage*)inputImage;

@end
