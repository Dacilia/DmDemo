//
//  DmColorAdjustmentFiter.h
//  iOSCamera
//
//  Created by 李达志 on 2018/5/5.
//  Copyright © 2018年 LDZ. All rights reserved.
//  CICategoryColorAdjustment 色彩调整，比如伽马调整、白点调整、曝光 的一个封装

#import <Foundation/Foundation.h>

@interface DmColorAdjustmentFiter : NSObject
/** CIColorClamp 滤镜
 Modifies color values to keep them within a specified range.
 修改颜色值以使其保持在指定范围内。
 */
+(UIImage*)dmClolorClamp:(UIImage*)originImage;
/**CIColorControls 滤镜
 Adjusts saturation, brightness, and contrast values.
 调整饱和度，亮度和对比度值。
 */
+(UIImage*)dmColorControls:(UIImage*)originImage;
/** CIColorMatrix
 Multiplies source color values and adds a bias factor to each color component.
复制源颜色值，并为每个颜色组件添加一个偏置因子。
 */
+(UIImage*)dmColorMatrix:(UIImage*)originImage;

/** CIColorPolynomial
 Modifies the pixel values in an image by applying a set of cubic polynomials.
通过应用一组三次多项式来修改图像中的像素值。
 */
+(UIImage*)dmColorPolynomial:(UIImage*)originImage;

/** CIExposureAdjust
 Adjusts the exposure setting for an image similar to the way you control exposure for a camera when you change the F-stop.
 调整一个图像的曝光设置，就像你改变F-stop时控制相机曝光的方式一样。
 */
+(UIImage*)dmCIExposureAdjust:(UIImage*)originImage;

/** CIGammaAdjust
 调整midtone亮度。
 */
+(UIImage*)dmCIGammaAdjust:(UIImage*)originImage;

/** CIHueAdjust
 色度 调整
 */
+(UIImage*)dmCIHueAdjust:(UIImage*)originImage;

/** CILinearToSRGBToneCurve
 Maps color intensity from a linear gamma curve to the sRGB color space.
从线性伽马曲线到sRGB颜色空间的地图颜色强度。
 */
+(UIImage*)dmCILinearToSRGBToneCurve:(UIImage*)originImage;

/** CISRGBToneCurveToLinear
 Maps color intensity from the sRGB color space to a linear gamma curve.
从sRGB颜色空间到线性伽马曲线的颜色强度。
 */
+(UIImage*)dmCISRGBToneCurveToLinear:(UIImage*)originImage;

/** CITemperatureAndTint
 Adapts the reference white point for an image.
为图像调整引用白点。
 */
+(UIImage*)dmCITemperatureAndTint:(UIImage*)originImage;

/** CIToneCurve
 调整图像的R、G和B通道的音调响应。
 */
+(UIImage*)dmCIToneCurve:(UIImage*)originImage;

/** CIVibrance
 Adjusts the saturation of an image while keeping pleasing skin tones.

调整图像的饱和度，同时保持愉悦的肤色。
 */
+(UIImage*)dmCIVibrance:(UIImage*)originImage;

/** CIWhitePointAdjust
 Adjusts the reference white point for an image and maps all colors in the source using the new reference.
调整一个图像的引用白点，并使用新的引用映射源中的所有颜色。

 */
+(UIImage*)dmCIWhitePointAdjust:(UIImage*)originImage;

@end
