//
//  FilterResultController.m
//  iOSCamera
//
//  Created by 李达志 on 2018/4/28.
//  Copyright © 2018年 LDZ. All rights reserved.
//

#import "FilterResultController.h"

@interface FilterResultController ()
/** 原图 */
@property (nonatomic,strong) UIImageView * originImageView;
/** 添加滤镜后的图片 */
@property (nonatomic,strong) UIImageView * nowImageView;
@end

@implementation FilterResultController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title=self.filterStr;
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.originImageView];
    [self.originImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@64);
        make.left.right.equalTo(@0);
        make.height.equalTo(@((kScreenHeight-64)/2));
    }];
    [self.view addSubview:self.nowImageView];
    [self.nowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.left.right.equalTo(@0);
        make.height.equalTo(@((kScreenHeight-64)/2));
    }];
    [self setTwoNowimageMethod];
    CIFilter *filter = [CIFilter filterWithName:@"CIConvolution3X3"];
    //是获取该滤镜下面的属性
    NSLog(@"%@",filter.attributes);


}
//设置图片的image 方法1
-(void)setNowImageViewImage{
        //1、先想办法弄到一个图像（CIImage*）
    CIImage* oldImg = [[CIImage alloc] initWithImage:self.originImageView.image];
        //2、创建一个CIFilter*对象
    CIFilter* filter = [CIFilter filterWithName:@"CIBoxBlur"];
        //如果用下面这个方法初始化，3、4、5都可以省略
    //CIFilter* filter = [CIFilter filterWithName:@"CICircularWrap" keysAndValues:@"inputImage",oldImg, nil];
        //3、设置默认参数
//    [filter setDefaults];

    /** 参数

     */
    [filter setValue:@(80.0) forKey:@"inputRadius"];
        //4、设置要处理的图像
    [filter setValue:oldImg forKey:@"inputImage"];
        //5、得到处理后的图像
    UIImage* newImg = [UIImage imageWithCIImage:[filter outputImage]];
        //6、显示出来
    self.nowImageView.image = newImg;
}
-(void)setTwoNowimageMethod{
    /*CIContext上下文可以是基于CPU的，也可以是基于GPU的。
    基于CPU：处理图片时CPU占用率很高，但是会采用GCD来对图像进行渲染，保证了CPU渲染在大部分情况下更可靠，他可以在后台实现渲染过程；
    基于GPU：使用OpenES来渲染图像，CPU完全没有负担，应用程序的运行循环不会受到图像渲染的影响，而且他渲染比CPU渲染更快但是GPU渲染无法在后台运行。无法跨应用访问，例如直UIImagePickerController的完成方法中调用上下文处理就会自动降级为CPU渲染
    上面的例子中使用imageWithCIImage:，默认使用的是CPU。
    CIContext可以被重用，所以不用每次都创建一个
     */

//    创建OpenGL优化过的图像上下文

//    EAGLContext *eaglContext=[[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
//    context=[CIContext contextWithEAGLContext:eaglContext];
   CIContext* context=[CIContext contextWithOptions:nil];
    CIImage* oldImg = [[CIImage alloc] initWithImage:self.originImageView.image];
    CIFilter* filter = [CIFilter filterWithName:@"CIColorControls"];
    [filter setValue:oldImg forKey:@"inputImage"];
    [filter setValue:@(1) forKey:@"inputSaturation"];
     [filter setValue:@(1) forKey:@"inputBrightness"];
     [filter setValue:@(1.5) forKey:@"inputContrast"];
    CIImage* newImg = [filter outputImage];
        //获取图片时要设置上下文
    
    CGImageRef tempImg=[context createCGImage:newImg fromRect:newImg.extent];
    self.nowImageView.image = [UIImage imageWithCGImage:tempImg];
    CGImageRelease(tempImg);
}
-(UIImageView *)originImageView{

    if (!_originImageView) {
        _originImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"i10"]];
        _originImageView.contentMode=UIViewContentModeScaleAspectFit;
    }return _originImageView;
}

-(UIImageView *)nowImageView{
    if (!_nowImageView) {
        _nowImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"i10"]];
        _nowImageView.contentMode=UIViewContentModeScaleAspectFit;
    }return _nowImageView;
}


@end
