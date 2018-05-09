//
//  DmColorAdjustmentFiter.m
//  iOSCamera
//
//  Created by 李达志 on 2018/5/5.
//  Copyright © 2018年 LDZ. All rights reserved.
//

#import "DmColorAdjustmentFiter.h"

@implementation DmColorAdjustmentFiter
+(UIImage *)dmClolorClamp:(UIImage *)originImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:originImage];
    CIFilter* filter = [CIFilter filterWithName:@"CIColorClamp"];
    [filter setValue:oldImg forKey:@"inputImage"];
//    [filter setDefaults];
    [filter setValue:[CIVector vectorWithX:0 Y:0 Z:0 W:0] forKey:@"inputMinComponents"];
    [filter setValue:[CIVector vectorWithX:0.5 Y:0.5 Z:0.5 W:0.5] forKey:@"inputMaxComponents"];
    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}
+(UIImage *)dmColorControls:(UIImage *)originImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:originImage];
    CIFilter* filter = [CIFilter filterWithName:@"CIColorControls"];
    [filter setValue:oldImg forKey:@"inputImage"];
    [filter setValue:@(1) forKey:@"inputSaturation"];
    [filter setValue:@(1) forKey:@"inputBrightness"];
    [filter setValue:@(1.5) forKey:@"inputContrast"];
    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}
+(UIImage *)dmColorMatrix:(UIImage *)originImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:originImage];
    CIFilter* filter = [CIFilter filterWithName:@"CIColorMatrix"];
    [filter setValue:oldImg forKey:@"inputImage"];
    [filter setValue:[CIVector vectorWithX:0 Y:1 Z:0 W:0] forKey:@"inputRVector"];
    [filter setValue:[CIVector vectorWithX:0 Y:1 Z:0 W:0] forKey:@"inputGVector"];
    [filter setValue:[CIVector vectorWithX:0 Y:1 Z:0 W:0] forKey:@"inputBVector"];
    [filter setValue:[CIVector vectorWithX:0 Y:1 Z:0 W:0] forKey:@"inputAVector"];
    [filter setValue:[CIVector vectorWithX:0 Y:1 Z:0 W:0] forKey:@"inputBiasVector"];

    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}
+(UIImage *)dmColorPolynomial:(UIImage *)originImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:originImage];
    CIFilter* filter = [CIFilter filterWithName:@"CIColorPolynomial"];
    [filter setValue:oldImg forKey:@"inputImage"];
    [filter setValue:[CIVector vectorWithX:0 Y:0 Z:0 W:0.4] forKey:@"inputRedCoefficients"];
    [filter setValue:[CIVector vectorWithX:0 Y:0 Z:0.5 W:0.8] forKey:@"inputGreenCoefficients"];
    [filter setValue:[CIVector vectorWithX:0 Y:0 Z:0.5 W:1] forKey:@"inputBlueCoefficients"];
    [filter setValue:[CIVector vectorWithX:0 Y:1 Z:1 W:1] forKey:@"inputAlphaCoefficients"];

    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}
+(UIImage *)dmCIExposureAdjust:(UIImage *)originImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:originImage];
    CIFilter* filter = [CIFilter filterWithName:@"CIExposureAdjust"];
    [filter setValue:oldImg forKey:@"inputImage"];
    [filter setValue:@(0.5)forKey:@"inputEV"];
    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}
+(UIImage *)dmCIGammaAdjust:(UIImage *)originImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:originImage];
    CIFilter* filter = [CIFilter filterWithName:@"CIGammaAdjust"];
    [filter setValue:oldImg forKey:@"inputImage"];
    [filter setValue:@(0.5)forKey:@"inputPower"];
    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}
+(UIImage *)dmCIHueAdjust:(UIImage *)originImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:originImage];
    CIFilter* filter = [CIFilter filterWithName:@"CIHueAdjust"];
    [filter setValue:oldImg forKey:@"inputImage"];
    [filter setValue:@(0.3)forKey:@"inputAngle"];
    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}
+(UIImage *)dmCILinearToSRGBToneCurve:(UIImage *)originImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:originImage];
    CIFilter* filter = [CIFilter filterWithName:@"CILinearToSRGBToneCurve"];
    [filter setValue:oldImg forKey:@"inputImage"];
//    [filter setValue:@(0.3)forKey:@"inputAngle"];
    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}
+(UIImage *)dmCISRGBToneCurveToLinear:(UIImage *)originImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:originImage];
    CIFilter* filter = [CIFilter filterWithName:@"CISRGBToneCurveToLinear"];
    [filter setValue:oldImg forKey:@"inputImage"];
        //    [filter setValue:@(0.3)forKey:@"inputAngle"];
    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}
+(UIImage *)dmCITemperatureAndTint:(UIImage *)originImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:originImage];
    CIFilter* filter = [CIFilter filterWithName:@"CITemperatureAndTint"];
    [filter setValue:oldImg forKey:@"inputImage"];
    [filter setValue:[ CIVector vectorWithX:9500 Y:1] forKey:@"inputNeutral"];
    [filter setValue:[ CIVector vectorWithX:9500 Y:1] forKey:@"inputTargetNeutral"];

    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}
+(UIImage *)dmCIToneCurve:(UIImage *)originImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:originImage];
    CIFilter* filter = [CIFilter filterWithName:@"CIToneCurve"];
    [filter setValue:oldImg forKey:@"inputImage"];
    [filter setValue:[ CIVector vectorWithX:0 Y:0] forKey:@"inputPoint0"];
    [filter setValue:[ CIVector vectorWithX:0.15 Y:0.15] forKey:@"inputPoint1"];
    [filter setValue:[ CIVector vectorWithX:0.25 Y:0.25] forKey:@"inputPoint2"];
    [filter setValue:[ CIVector vectorWithX:0.95 Y:0.95] forKey:@"inputPoint3"];
    [filter setValue:[ CIVector vectorWithX:1 Y:1] forKey:@"inputPoint4"];
    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}
+(UIImage *)dmCIVibrance:(UIImage *)originImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:originImage];
    CIFilter* filter = [CIFilter filterWithName:@"CIVibrance"];
    [filter setValue:oldImg forKey:@"inputImage"];
    [filter setValue:@(2) forKey:@"inputAmount"];

    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}
+(UIImage *)dmCIWhitePointAdjust:(UIImage *)originImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:originImage];
    CIFilter* filter = [CIFilter filterWithName:@"CIWhitePointAdjust"];
    [filter setValue:oldImg forKey:@"inputImage"];
    [filter setValue:[CIColor grayColor] forKey:@"inputColor"];

    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}
@end
