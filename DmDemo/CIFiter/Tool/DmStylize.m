//
//  DmStylize.m
//  iOSCamera
//
//  Created by 李达志 on 2018/5/5.
//  Copyright © 2018年 LDZ. All rights reserved.
//

#import "DmStylize.h"
/**

 */
@implementation DmStylize
+(UIImage *)dmCIBlendWithAlphaMaskInputImage:(UIImage *)inputImage inputBackgroundImage:(UIImage *)inputBackgroundImage inputMaskImage:(UIImage *)inputMaskImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:inputImage];
    CIFilter* filter = [CIFilter filterWithName:@"CIBlendWithAlphaMask"];
    [filter setValue:oldImg forKey:@"inputImage"];
    CIImage* inputBackImage = [[CIImage alloc] initWithImage:inputBackgroundImage];
    CIImage* inputMaskImag = [[CIImage alloc] initWithImage:inputMaskImage];
    [filter setValue:inputMaskImag forKey:@"inputMaskImage"];
    [filter setValue:inputBackImage forKey:@"inputBackgroundImage"];
    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
    
}
+(UIImage *)dmCIBlendWithMaskInputImage:(UIImage *)inputImage inputBackgroundImage:(UIImage *)inputBackgroundImage inputMaskImage:(UIImage *)inputMaskImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:inputImage];
    CIFilter* filter = [CIFilter filterWithName:@"CIBlendWithMask"];
    [filter setValue:oldImg forKey:@"inputImage"];
    CIImage* inputBackImage = [[CIImage alloc] initWithImage:inputBackgroundImage];
    CIImage* inputMaskImag = [[CIImage alloc] initWithImage:inputMaskImage];
    [filter setValue:inputMaskImag forKey:@"inputMaskImage"];
    [filter setValue:inputBackImage forKey:@"inputBackgroundImage"];
    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}
+(UIImage *)dmCIBloomInputImage:(UIImage *)inputImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:inputImage];
    CIFilter* filter = [CIFilter filterWithName:@"CIBloom"];
    [filter setValue:oldImg forKey:@"inputImage"];
    [filter setValue:@(15.00) forKey:@"inputRadius"];
    [filter setValue:@(0.6) forKey:@"inputIntensity"];
    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}
+(UIImage *)dmCIComicEffectInputImage:(UIImage *)inputImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:inputImage];
    CIFilter* filter = [CIFilter filterWithName:@"CIComicEffect"];
    [filter setValue:oldImg forKey:@"inputImage"];
    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}
+(UIImage *)dmCIConvolution3X3InputImage:(UIImage *)inputImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:inputImage];
    CIFilter* filter = [CIFilter filterWithName:@"CIConvolution3X3"];
    [filter setValue:oldImg forKey:@"inputImage"];
//    [filter setDefaults];
    [filter setValue:@(0.00) forKey:@"inputBias"];//这个属性设置没有效果 具体原因未知 只好用默认值
    CGFloat vetor [9]={//矩阵 具体也不知道计算原理
        0.0,0.5,0.0,
        0.0,1.0,0.0,
        0.0,0.0,0.0
    };
    [filter setValue:[CIVector vectorWithValues:vetor count:9] forKey:@"inputWeights"];

    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}
+(UIImage *)dmCIConvolution5X5InputImage:(UIImage *)inputImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:inputImage];
    CIFilter* filter = [CIFilter filterWithName:@"CIConvolution5X5"];
    [filter setValue:oldImg forKey:@"inputImage"];
        //    [filter setDefaults];
    [filter setValue:@(0.00) forKey:@"inputBias"];//这个属性设置没有效果 具体原因未知 只好用默认值
    CGFloat vetor [25]={//矩阵 具体也不知道计算原理
        0.5,0.0,0.0,0.0,0.0,
        0.0,1.0,0.0,0.0,0.0,
        0.0,0.0,0.0,0.0,0.0,
        0.0,0.0,0.0,0.0,0.0,
        0.0,0.0,0.0,0.1,0.0,
    };
    [filter setValue:[CIVector vectorWithValues:vetor count:25] forKey:@"inputWeights"];

    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}
+(UIImage *)dmCIConvolution7X7InputImage:(UIImage *)inputImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:inputImage];
    CIFilter* filter = [CIFilter filterWithName:@"CIConvolution7X7"];
    [filter setValue:oldImg forKey:@"inputImage"];
        //    [filter setDefaults];
    [filter setValue:@(0.00) forKey:@"inputBias"];//这个属性设置没有效果 具体原因未知 只好用默认值
    CGFloat vetor [49]={//矩阵 具体也不知道计算原理
        0.5,0.0,0.0,0.0,0.0,0.0,0.0,
        0.0,1.0,0.0,0.0,0.0,0.0,0.0,
        0.0,0.0,0.0,0.0,0.0,0.0,0.0,
        0.0,0.0,0.0,0.0,0.0,0.0,0.0,
        0.0,0.0,0.0,0.1,0.0,0.0,0.0,
        0.0,0.0,0.0,0.1,0.0,0.0,0.0,
        0.0,0.0,0.0,0.1,0.0,0.0,0.0
    };
    [filter setValue:[CIVector vectorWithValues:vetor count:49] forKey:@"inputWeights"];

    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}
+(UIImage *)dmCIConvolution9HorizontalInputImage:(UIImage *)inputImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:inputImage];
    CIFilter* filter = [CIFilter filterWithName:@"CIConvolution9Horizontal"];
    [filter setValue:oldImg forKey:@"inputImage"];
        //    [filter setDefaults];
    [filter setValue:@(0.00) forKey:@"inputBias"];//这个属性设置没有效果 具体原因未知 只好用默认值
    CGFloat vetor [9]={//矩阵 具体也不知道计算原理
        1.0,-1.0,1.0,0.0,1.0,0.0,-1.0,1.0,-1.0
    };
    [filter setValue:[CIVector vectorWithValues:vetor count:9] forKey:@"inputWeights"];

    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}
+(UIImage *)dmCICrystallizeInputImage:(UIImage *)inputImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:inputImage];
    CIFilter* filter = [CIFilter filterWithName:@"CICrystallize"];
    [filter setValue:oldImg forKey:@"inputImage"];
        //    [filter setDefaults];
    [filter setValue:@(20.00) forKey:@"inputRadius"];
    [filter setValue:[CIVector vectorWithX:150 Y:150] forKey:@"inputCenter"];
    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}

+(UIImage *)dmCIDepthOfFieldInputImage:(UIImage *)inputImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:inputImage];
    CIFilter* filter = [CIFilter filterWithName:@"CIDepthOfField"];
    [filter setValue:oldImg forKey:@"inputImage"];
        //    [filter setDefaults];
    [filter setValue:[CIVector vectorWithCGPoint:CGPointMake(20, 40)] forKey:@"inputPoint0"];
    [filter setValue:[CIVector vectorWithX:150 Y:150] forKey:@"inputPoint1"];
    [filter setValue:@(12) forKey:@"inputSaturation"];
    [filter setValue:@(5) forKey:@"inputUnsharpMaskRadius"];
    [filter setValue:@(10) forKey:@"inputUnsharpMaskIntensity"];
    [filter setValue:@(10) forKey:@"inputRadius"];
    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}
+(UIImage *)dmCIEdgesInputImage:(UIImage *)inputImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:inputImage];
    CIFilter* filter = [CIFilter filterWithName:@"CIEdges"];
    [filter setValue:oldImg forKey:@"inputImage"];
        //    [filter setDefaults];

    [filter setValue:@(1.0) forKey:@"inputIntensity"];
    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;

}
+(UIImage *)dmCIEdgeWorkInputImage:(UIImage *)inputImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:inputImage];
    CIFilter* filter = [CIFilter filterWithName:@"CIEdgeWork"];
    [filter setValue:oldImg forKey:@"inputImage"];
        //    [filter setDefaults];

    [filter setValue:@(4.0) forKey:@"inputRadius"];
    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}
+(UIImage *)dmCIGloomInputImage:(UIImage *)inputImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:inputImage];
    CIFilter* filter = [CIFilter filterWithName:@"CIGloom"];
    [filter setValue:oldImg forKey:@"inputImage"];
        //    [filter setDefaults];

    [filter setValue:@(0.5) forKey:@"inputIntensity"];
    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}
+(UIImage *)dmCIHeightFieldFromMaskInputImage:(UIImage *)inputImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:inputImage];
    CIFilter* filter = [CIFilter filterWithName:@"CIHeightFieldFromMask"];
    [filter setValue:oldImg forKey:@"inputImage"];
        //    [filter setDefaults];

    [filter setValue:@(14.0) forKey:@"inputRadius"];
    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}
+(UIImage *)dmCIHexagonalPixellateInputImage:(UIImage *)inputImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:inputImage];
    CIFilter* filter = [CIFilter filterWithName:@"CIHexagonalPixellate"];
    [filter setValue:oldImg forKey:@"inputImage"];
        //    [filter setDefaults];

    [filter setValue:[CIVector vectorWithX:150 Y:150] forKey:@"inputCenter"];
    [filter setValue:@(8.00) forKey:@"inputScale"];
    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}
+(UIImage *)dmCIHighlightShadowAdjustInputImage:(UIImage *)inputImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:inputImage];
    CIFilter* filter = [CIFilter filterWithName:@"CIHighlightShadowAdjust"];
    [filter setValue:oldImg forKey:@"inputImage"];
        //    [filter setDefaults];

    [filter setValue:@(0.00)forKey:@"inputShadowAmount"];
    [filter setValue:@(1.00) forKey:@"inputHighlightAmount"];
    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}
+(UIImage *)dmCILineOverlayInputImage:(UIImage *)inputImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:inputImage];
    CIFilter* filter = [CIFilter filterWithName:@"CILineOverlay"];
    [filter setValue:oldImg forKey:@"inputImage"];
        //    [filter setDefaults];

    [filter setValue:@(0.07)forKey:@"inputNRNoiseLevel"];
    [filter setValue:@(0.71) forKey:@"inputNRSharpness"];
    [filter setValue:@(1.00)forKey:@"inputEdgeIntensity"];
    [filter setValue:@(0.10) forKey:@"inputThreshold"];
    [filter setValue:@(50.00)forKey:@"inputContrast"];
    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}
+(UIImage *)dmCIPixellateInputImage:(UIImage *)inputImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:inputImage];
    CIFilter* filter = [CIFilter filterWithName:@"CIPixellate"];
    [filter setValue:oldImg forKey:@"inputImage"];
        //    [filter setDefaults];

    [filter setValue:@(8.07)forKey:@"inputScale"];
    [filter setValue:[CIVector vectorWithX:150 Y:150] forKey:@"inputCenter"];

    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}
+(UIImage *)dmCIPointillizeInputImage:(UIImage *)inputImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:inputImage];
    CIFilter* filter = [CIFilter filterWithName:@"CIPointillize"];
    [filter setValue:oldImg forKey:@"inputImage"];
        //    [filter setDefaults];

    [filter setValue:@(20.00)forKey:@"inputRadius"];
    [filter setValue:[CIVector vectorWithX:150 Y:150] forKey:@"inputCenter"];

    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}
+(UIImage *)dmCIShadedMaterialInputImage:(UIImage *)inputImage inputShadingImage:(UIImage*)inputShadingImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:inputImage];
    CIFilter* filter = [CIFilter filterWithName:@"CIShadedMaterial"];
    [filter setValue:oldImg forKey:@"inputImage"];
        //    [filter setDefaults];

    [filter setValue:@(20.00)forKey:@"inputScale"];
    [filter setValue:[[CIImage alloc] initWithImage:inputShadingImage] forKey:@"inputShadingImage"];

    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}
+(UIImage *)dmCISpotColorInputImage:(UIImage *)inputImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:inputImage];
    CIFilter* filter = [CIFilter filterWithName:@"CISpotColor"];
    [filter setValue:oldImg forKey:@"inputImage"];
        //    [filter setDefaults];

    [filter setValue:[CIColor blueColor] forKey:@"inputCenterColor1"];
    [filter setValue:[CIColor blueColor] forKey:@"inputReplacementColor1"];
    [filter setValue:@(0.22) forKey:@"inputCloseness1"];
    [filter setValue:@(0.98) forKey:@"inputContrast1"];
    [filter setValue:[CIColor blueColor] forKey:@"inputCenterColor2"];
    [filter setValue:[CIColor blueColor] forKey:@"inputReplacementColor2"];
    [filter setValue:@(0.15) forKey:@"inputCloseness2"];
    [filter setValue:@(0.98) forKey:@"inputContrast2"];
    [filter setValue:[CIColor blueColor] forKey:@"inputCenterColor3"];
    [filter setValue:[CIColor blueColor] forKey:@"inputReplacementColor3"];
    [filter setValue:@(0.50) forKey:@"inputCloseness3"];
    [filter setValue:@(0.99) forKey:@"inputContrast3"];


    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}
+(UIImage*)dmCISpotLightInputImage:(UIImage*)inputImage{
    CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:inputImage];
    CIFilter* filter = [CIFilter filterWithName:@"CISpotLight"];
    [filter setValue:oldImg forKey:@"inputImage"];
        //    [filter setDefaults];

    [filter setValue:[CIVector vectorWithX:400 Y:600 Z:150] forKey:@"inputLightPosition"];

    [filter setValue:[CIVector vectorWithX:200 Y:200 Z:0] forKey:@"inputLightPointsAt"];
    [filter setValue:@(3.50) forKey:@"inputBrightness"];
    [filter setValue:@(0.10) forKey:@"inputConcentration"];
    [filter setValue:[CIColor redColor] forKey:@"inputColor"];

    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    UIImage * effectImg=[UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
    return effectImg;
}

@end
