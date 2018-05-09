//
//  DmBlur.m
//  iOSCamera
//
//  Created by 李达志 on 2018/5/7.
//  Copyright © 2018年 LDZ. All rights reserved.
//

#import "DmBlur.h"

@implementation DmBlur

+(UIImage *)dmCIBoxBlurInputImage:(UIImage *)inputImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:inputImage];
    CIFilter* filter = [CIFilter filterWithName:@"CIBoxBlur"];
    [filter setValue:oldImg forKey:@"inputImage"];
    [filter setValue:@(15.00) forKey:@"inputRadius"];
    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}
+(UIImage *)dmCIDiscBlurInputImage:(UIImage *)inputImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:inputImage];
    CIFilter* filter = [CIFilter filterWithName:@"CIDiscBlur"];
    [filter setValue:oldImg forKey:@"inputImage"];
    [filter setValue:@(15.00) forKey:@"inputRadius"];
    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}
+(UIImage *)dmCIGaussianBlurInputImage:(UIImage *)inputImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:inputImage];
    CIFilter* filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:oldImg forKey:@"inputImage"];
    [filter setValue:@(15.00) forKey:@"inputRadius"];
    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}
+(UIImage *)dmCIMaskedVariableBlurInputImage:(UIImage *)inputImage inputMask:(UIImage*)inputMask{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:inputImage];
    CIFilter* filter = [CIFilter filterWithName:@"CIMaskedVariableBlur"];
    [filter setValue:oldImg forKey:@"inputImage"];
    [filter setValue:@(15.00) forKey:@"inputRadius"];
    [filter setValue:[[CIImage alloc] initWithImage:inputMask] forKey:@"inputMask"];
    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}
+(UIImage *)dmCIMedianFilterInputImage:(UIImage *)inputImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:inputImage];
    CIFilter* filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:oldImg forKey:@"inputImage"];
    
    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}
+(UIImage *)dmCIMotionBlurInputImage:(UIImage *)inputImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:inputImage];
    CIFilter* filter = [CIFilter filterWithName:@"CIMotionBlur"];
    [filter setValue:oldImg forKey:@"inputImage"];
    [filter setValue:@(20.00) forKey:@"inputRadius"];
    [filter setValue:@(0.5) forKey:@"inputAngle"];
    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}
+(UIImage *)dmCINoiseReductionInputImage:(UIImage *)inputImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:inputImage];
    CIFilter* filter = [CIFilter filterWithName:@"CINoiseReduction"];
    [filter setValue:oldImg forKey:@"inputImage"];
    [filter setValue:@(0.20) forKey:@"inputNoiseLevel"];
    [filter setValue:@(0.40) forKey:@"inputSharpness"];
    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}
+(UIImage *)dmCIZoomBlurInputImage:(UIImage *)inputImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:inputImage];
    CIFilter* filter = [CIFilter filterWithName:@"CIZoomBlur"];
    [filter setValue:oldImg forKey:@"inputImage"];
    [filter setValue:[CIVector vectorWithX:20 Y:100] forKey:@"inputCenter"];
    [filter setValue:@(20.40) forKey:@"inputAmount"];
    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}
@end
