//
//  CoreImageController.m
//  iOSCamera
//
//  Created by 李达志 on 2018/4/27.
//  Copyright © 2018年 LDZ. All rights reserved.
//

#import "CoreImageController.h"
#import "APPMacro.h"
@interface CoreImageController ()
/** 原图 */
@property (nonatomic,strong) UIImageView * originImageView;
/** 添加滤镜后的图片 */
@property (nonatomic,strong) UIImageView * nowImageView;
@property (nonatomic,strong) UIButton * cISepiaToneButton;
@property (nonatomic,strong) UIButton * CIColorMonochrome;
@end



@implementation CoreImageController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    [self.view addSubview:self.cISepiaToneButton];
    [self.cISepiaToneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@70);
        make.left.equalTo(@0);
        make.height.equalTo(@40);
        make.width.equalTo(@100);
    }];
    [self.view addSubview:self.CIColorMonochrome];
    [self.CIColorMonochrome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@70);
        make.left.equalTo(@120);
        make.height.equalTo(@40);
        make.width.equalTo(@100);
    }];
    [self getFilter];
}
-(void)getFilter{
    NSLog(@"kCICategoryBuiltIn类别下的滤镜=%@",[CIFilter filterNamesInCategory:kCICategoryBuiltIn]);
}
-(UIButton *)cISepiaToneButton{
    if (!_cISepiaToneButton) {
        _cISepiaToneButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_cISepiaToneButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_cISepiaToneButton setTitle:@"cISepiaToneButton" forState:UIControlStateNormal];
        _cISepiaToneButton.tag=0;
        [_cISepiaToneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _cISepiaToneButton;
}
-(UIButton *)CIColorMonochrome{
    if (!_CIColorMonochrome) {
        _CIColorMonochrome=[UIButton buttonWithType:UIButtonTypeCustom];
        [_CIColorMonochrome addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_CIColorMonochrome setTitle:@"cISepiaToneButton" forState:UIControlStateNormal];
        _CIColorMonochrome.tag=1;
        [_CIColorMonochrome setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _CIColorMonochrome;
}
-(void)buttonAction:(UIButton*)button{

    if (button.tag==0) {
            //    1.源图
            //    1.源图
        CIImage *inputImage = [CIImage imageWithCGImage:self.nowImageView.image.CGImage];
            //    2.滤镜
        CIFilter *filter = [CIFilter filterWithName:@"CIColorMonochrome"];
            //    NSLog(@"%@",[CIFilter filterNamesInCategory:kCICategoryColorEffect]);//注意此处两个输出语句的重要作用
        NSLog(@"%@",filter.attributes);

        [filter setValue:inputImage forKey:kCIInputImageKey];

        [filter setValue:[CIColor colorWithRed:1.000 green:0.165 blue:0.176 alpha:1.000] forKey:kCIInputColorKey];
        CIImage *outImage = filter.outputImage;
        [self addFilterLinkerWithImage:outImage];


    }



}
    //再次添加滤镜  形成滤镜链
- (void)addFilterLinkerWithImage:(CIImage *)image{

    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"];
    [filter setValue:image forKey:kCIInputImageKey];
    [filter setValue:@(0.5) forKey:kCIInputIntensityKey];

        //    在这里创建上下文  把滤镜和图片进行合并
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef resultImage = [context createCGImage:filter.outputImage fromRect:filter.outputImage.extent];
    self.nowImageView.image = [UIImage imageWithCGImage:resultImage];

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
