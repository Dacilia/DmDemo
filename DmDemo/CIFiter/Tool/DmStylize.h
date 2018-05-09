//
//  DmStylize.h
//  iOSCamera
//
//  Created by 李达志 on 2018/5/5.
//  Copyright © 2018年 LDZ. All rights reserved.
//  "kCICategoryStylize_风格化，比如像素化、水晶化

#import <Foundation/Foundation.h>

@interface DmStylize : NSObject

/** CIBlendWithAlphaMask
 Uses alpha values from a mask to interpolate between an image and the background.
 使用来自掩码的alpha值在图像和背景之间进行插值。
 */
+(UIImage*)dmCIBlendWithAlphaMaskInputImage:(UIImage*)inputImage inputBackgroundImage:(UIImage*)inputBackgroundImage inputMaskImage:(UIImage*)inputMaskImage;
/**
 CIBlendWithMask
 Uses values from a grayscale mask to interpolate between an image and the background.
利用灰度掩码中的值在图像和背景之间进行插值。
 */
+(UIImage*)dmCIBlendWithMaskInputImage:(UIImage*)inputImage inputBackgroundImage:(UIImage*)inputBackgroundImage inputMaskImage:(UIImage*)inputMaskImage;
/**
 CIBloom
 Softens edges and applies a pleasant glow to an image.
软化边缘，并将愉快的辉光应用于图像。
 */
+(UIImage*)dmCIBloomInputImage:(UIImage*)inputImage;
/**
 CIComicEffect
 Simulates a comic book drawing by outlining edges and applying a color halftone effect.
通过概述边缘并应用彩色半色调效果来模拟漫画书的绘制。
 */
+(UIImage*)dmCIComicEffectInputImage:(UIImage*)inputImage;
/**
 CIConvolution3X3
 Modifies pixel values by performing a 3x3 matrix convolution.
 通过执行一个3x3矩阵卷积来修改像素值。
*/
+(UIImage*)dmCIConvolution3X3InputImage:(UIImage*)inputImage;
/**
 CIConvolution5X5
 */
+(UIImage*)dmCIConvolution5X5InputImage:(UIImage*)inputImage;
/**

 CIConvolution7X7
 */
+(UIImage*)dmCIConvolution7X7InputImage:(UIImage*)inputImage;
/**
 CIConvolution9Horizontal
 Modifies pixel values by performing a 9-element horizontal convolution.
通过执行9元的水平卷积来修改像素值。
 */
+(UIImage*)dmCIConvolution9HorizontalInputImage:(UIImage*)inputImage;
/**
 CICrystallize
 Creates polygon-shaped color blocks by aggregating source pixel-color values.
通过聚合源像素颜色值创建多边形形状的颜色块。
 */
+(UIImage*)dmCICrystallizeInputImage:(UIImage*)inputImage;
/**
 CIDepthOfField
 模拟景深效果。
 */
+(UIImage*)dmCIDepthOfFieldInputImage:(UIImage*)inputImage;
/**
 CIEdges
 查找图像中的所有边缘并将其显示为颜色。
 */
+(UIImage*)dmCIEdgesInputImage:(UIImage*)inputImage;
/**
 CIEdgeWork
 产生一种程式化的黑白再现图像，看起来类似于一个木块的断片。
 */
+(UIImage*)dmCIEdgeWorkInputImage:(UIImage*)inputImage;
/**
 CIGloom
 使图像的高光变暗。
 */
+(UIImage*)dmCIGloomInputImage:(UIImage*)inputImage;
/**
 CIHeightFieldFromMask
 从灰度掩模中产生一个连续的三维的、高水平的高度场。
 */
+(UIImage*)dmCIHeightFieldFromMaskInputImage:(UIImage*)inputImage;
/**
 CIHexagonalPixellate
将图像映射为彩色的六边形，其颜色由替换的像素定义。
 */
+(UIImage*)dmCIHexagonalPixellateInputImage:(UIImage*)inputImage;
/**
 CIHighlightShadowAdjust
 调整图像的色调映射，同时保留空间细节。
 */
+(UIImage*)dmCIHighlightShadowAdjustInputImage:(UIImage*)inputImage;
/**
 CILineOverlay
 创建一个轮廓线，轮廓线的边缘轮廓在黑色。
 */
+(UIImage*)dmCILineOverlayInputImage:(UIImage*)inputImage;

/**
 CIPixellate
 通过将图像映射到颜色由被替换的像素定义的彩色方块，从而形成一个图像块。
 */
+(UIImage*)dmCIPixellateInputImage:(UIImage*)inputImage;
/**
 CIPointillize
 以点的方式呈现源图像。
 */
+(UIImage*)dmCIPointillizeInputImage:(UIImage*)inputImage;
/**
 CIShadedMaterial
 从高度字段生成阴影图像。
 */
+(UIImage*)dmCIShadedMaterialInputImage:(UIImage*)inputImage inputShadingImage:(UIImage*)inputShadingImage;
/**
 CISpotColor
 用专色代替一个或多个颜色范围。
 */
+(UIImage*)dmCISpotColorInputImage:(UIImage*)inputImage;
/**
 CISpotLight
 将定向聚光灯效应应用于图像。
 */
+(UIImage*)dmCISpotLightInputImage:(UIImage*)inputImage;

@end
