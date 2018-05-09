//
//  QRCodeController.m
//  iOSCamera
//
//  Created by 李达志 on 2018/4/24.
//  Copyright © 2018年 LDZ. All rights reserved.
//

#import "QRCodeController.h"
#import <AVFoundation/AVFoundation.h>
#import "APPMacro.h"
#import <Masonry.h>
#define  SCANIMAGEVIEWWH  kScreenWidth-100//扫描框的宽高
#define MaginTB  (kScreenHeight-(SCANIMAGEVIEWWH)-64)/2
#define ScanLineViewMaxTop kScreenHeight-((kScreenHeight-(SCANIMAGEVIEWWH)-64)/2)-2 //扫描线距离顶部的高度
@interface QRCodeController ()<AVCaptureMetadataOutputObjectsDelegate>{

}
//输入设备
@property (nonatomic,strong) AVCaptureDeviceInput * aVCaptureDeviceInput;
// 输出元数据
@property (nonatomic,strong) AVCaptureMetadataOutput * metadataOutput;
//中间链接器 用来链接输入和输出
@property (nonatomic,strong) AVCaptureSession * session;
@property (nonatomic,strong)  AVCaptureDevice *device;
// 预览图层
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic,strong) UIView * topView;
@property (nonatomic,strong) UIView * leftView;
@property (nonatomic,strong) UIView * rightView;
@property (nonatomic,strong) UIView * bottomView;
//扫描边框
@property (nonatomic,strong) UIImageView * scanImageView;
//扫描线
@property (nonatomic,strong) UIView * scanLineView;
@property (nonatomic,strong) UIButton * openButton;
/** 扫描线距离顶部的距离 */
@property (nonatomic,assign) CGFloat scanLineTopMargin;
@property (strong, nonatomic) UIImageView *focusCursor; //聚焦光标
                                                        //是否在对焦
@property (assign, nonatomic) BOOL isFocus;
@end

@implementation QRCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"二维码扫描";
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:90 green:255 blue:60 alpha:0.5];
    [self setUpView];
    [self setUpScanning];
    self.navigationController.navigationBar.translucent=YES;
    self.focusCursor=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_focus"]];
    self.focusCursor.hidden=YES;
    self.focusCursor.frame=CGRectMake(0, 0, 60, 60 );
    self.focusCursor.center=self.view.center;
    [self.view addSubview:self.focusCursor];
    [self addGenstureRecognizer];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self stratRuning];

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self stopRruning];
}
-(void)stratRuning{
    [self.session startRunning];
    CABasicAnimation * lineAnimation = [self animationWith:@(0) toValue:@(kScreenWidth-100-2) repCount:MAXFLOAT duration:1.5f];
    [self.scanLineView.layer addAnimation:lineAnimation forKey:@"scningLineView"];

}
-(void)stopRruning{
    [self.session stopRunning];
    [self.scanLineView.layer removeAllAnimations];
}
-(void)setUpView{

    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.height.equalTo(@(MaginTB+64));
    }];
    [self.view addSubview:self.leftView];
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@(MaginTB+64));
        make.bottom.equalTo(@(-MaginTB));
        make.width.equalTo(@50);

    }];
    [self.view addSubview:self.rightView];
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.top.equalTo(@(MaginTB+64));
        make.bottom.equalTo(@(-MaginTB));
         make.width.equalTo(@50);
    }];
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(@(MaginTB));
    }];
    [self.view addSubview:self.scanImageView];
    [self.scanImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(SCANIMAGEVIEWWH));
        make.top.equalTo(@(MaginTB+64));
        make.height.equalTo(@(SCANIMAGEVIEWWH));
        make.left.equalTo(@50);

    }];
    [self.view addSubview:self.scanLineView];
    [self.view addSubview:self.openButton];
    [self.openButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.equalTo(@80);
        make.width.equalTo(@(56));
        make.bottom.equalTo(@-50);
    }];

}



#pragma mark - 扫码line滑动动画
- (CABasicAnimation*)animationWith:(id)fromValue toValue:(id)toValue repCount:(CGFloat)repCount duration:(CGFloat)duration{

    CABasicAnimation *lineAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    lineAnimation.fromValue = fromValue;
    lineAnimation.toValue = toValue;
    lineAnimation.repeatCount = repCount;
    lineAnimation.duration = duration;
    lineAnimation.fillMode = kCAFillModeForwards;
    lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return lineAnimation;
}
//设置扫描输入输出
-(void)setUpScanning{

     //设置高质量采集
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    // 1.判断是否能够将输入添加到会话中
    if (![self.session canAddInput:self.aVCaptureDeviceInput]) {
        return;
    }

        // 2.判断是否能够将输出添加到会话中
    if (![self.session canAddOutput:self.metadataOutput]) {
        return;
    }

    [self.metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];

        // 3.将输入和输出都添加到会话中
    [self.session addInput:self.aVCaptureDeviceInput];

    [self.session addOutput:self.metadataOutput];

        // 4.设置输出能够解析的数据类型
        // 注意: 设置能够解析的数据类型, 一定要在输出对象添加到会员之后设置, 否则会报错
    self.metadataOutput.metadataObjectTypes =  @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
   // 经实践发现  (0,0,,1,1)这个写法有点坑   实际为(y,x,h,w)  即坐标y,x  尺寸高,宽(h,w)
    //rectOfInterest 的是比例来的
    [self.metadataOutput setRectOfInterest : CGRectMake (( MaginTB+64 )/ kScreenHeight ,(50)/ kScreenWidth , SCANIMAGEVIEWWH / kScreenHeight , SCANIMAGEVIEWWH / kScreenWidth)];

        // 5.添加预览图层
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];

        // 6.告诉session开始扫描
    [self.session startRunning];
}
/**
 *  当从二维码中获取到信息时，就会调用下面的方法
 *
 *  @param captureOutput   输出对象
 *  @param metadataObjects 信息
 */
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{


    if (metadataObjects.count == 0 || metadataObjects == nil) {
        return;
    }


        // 1.获取扫描到的数据
        // 注意: 要使用stringValue
        //判断是否有数据
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects lastObject];

        NSLog(@"码数据:%@",metadataObj.stringValue);
        NSLog(@"码类型:%@",metadataObj.type);
        //判断回传的数据类型
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode] && [metadataObj isKindOfClass:[AVMetadataMachineReadableCodeObject class]]) {
            [self.session stopRunning];
            UIAlertController*vc=  [UIAlertController alertControllerWithTitle:[metadataObjects.lastObject stringValue] message:nil preferredStyle:UIAlertControllerStyleAlert];
            [vc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.session startRunning];
            }]];
            [vc addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }]];
            [self presentViewController:vc animated:YES completion:nil];
            NSLog(@"%@",[metadataObjects.lastObject stringValue]);

        }
    }



}

#pragma mark 懒加载
    // 会话
- (AVCaptureSession *)session
{
    if (_session == nil) {
        _session = [[AVCaptureSession alloc] init];
    }
    return _session;
}
-(AVCaptureDeviceInput *)aVCaptureDeviceInput{
    if (!_aVCaptureDeviceInput) {
         self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        _aVCaptureDeviceInput=[[AVCaptureDeviceInput alloc]initWithDevice:self.device error:nil];
    }
    return _aVCaptureDeviceInput;
}
-(AVCaptureMetadataOutput *)metadataOutput{
    if (!_metadataOutput) {
        _metadataOutput=[[AVCaptureMetadataOutput alloc]init];
    }
    return _metadataOutput;
}
-(AVCaptureVideoPreviewLayer *)previewLayer{
    if (!_previewLayer) {
        _previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
        _previewLayer.frame = [UIScreen mainScreen].bounds;
    }
    return _previewLayer;
}
-(UIView *)leftView{
    if (!_leftView) {
        _leftView=[[UIView alloc]init];
        _leftView.backgroundColor=KQRBGCOLOR;
    }return _leftView;
}
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView=[[UIView alloc]init];
        _bottomView.backgroundColor=KQRBGCOLOR;
    }return _bottomView;
}
-(UIView *)rightView{
    if (!_rightView) {
        _rightView=[[UIView alloc]init];
        _rightView.backgroundColor=KQRBGCOLOR;
    }return _rightView;
}
-(UIView *)topView{
    if (!_topView) {
        _topView=[[UIView alloc]init];
        _topView.backgroundColor=KQRBGCOLOR;
    }return _topView;
}
-(UIImageView *)scanImageView{
    if (!_scanImageView) {
        _scanImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"qrcode_border_new"]];
    }return _scanImageView;
}
-(UIView *)scanLineView{
    if (!_scanLineView) {
        _scanLineView=[[UIView alloc]initWithFrame:CGRectMake(52, MaginTB+64, kScreenWidth-104, 2)];
        _scanLineView.backgroundColor=[UIColor greenColor];
    }
    return _scanLineView;
}
-(UIButton *)openButton{
    if (!_openButton) {
        _openButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_openButton setImage:[UIImage imageNamed:@"qrcode_torch"] forState:UIControlStateNormal];
        [_openButton setImage:[UIImage imageNamed:@"qrcode_torch_h"] forState:UIControlStateSelected];
        [_openButton addTarget:self action:@selector(openButtonAction) forControlEvents:UIControlEventTouchUpInside];


    }
    return _openButton;
}
-(void)openButtonAction{
    self.openButton.selected=!self.openButton.selected;
    if ([self.device hasTorch]) {
        //2.锁定当前设备为使用者
        [self.device lockForConfiguration:nil];
        [self.device setTorchMode:self.openButton.isSelected?AVCaptureTorchModeOn:AVCaptureTorchModeOff];
            //4.使用完成后解锁
        [self.device unlockForConfiguration];
    }
}
/**
 *  添加点按手势，点按时聚焦
 */
-(void)addGenstureRecognizer{
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapScreen:)];
    [self.view addGestureRecognizer:tapGesture];
}

-(void)tapScreen:(UITapGestureRecognizer *)tapGesture{
    self.focusCursor.hidden=NO;
    if ([self.session isRunning]) {
        CGPoint point= [tapGesture locationInView:self.view];
            //将UI坐标转化为摄像头坐标
            //        CGPoint cameraPoint= [self.previewLayer captureDevicePointOfInterestForPoint:point];
        [self.device lockForConfiguration:nil];
        if ([self.device isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]) {
            [self.device setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
        }
        [self.device unlockForConfiguration];
        [self setFocusCursorWithPoint:point];

    }
}

/**
 *  设置聚焦光标位置
 *
 *  @param point 光标位置
 */
-(void)setFocusCursorWithPoint:(CGPoint)point{

    self.focusCursor.center=point;
    self.focusCursor.transform = CGAffineTransformMakeScale(1.25, 1.25);
    self.focusCursor.alpha = 1.0;
    [UIView animateWithDuration:0.5 animations:^{
        self.focusCursor.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self performSelector:@selector(onHiddenFocusCurSorAction) withObject:nil afterDelay:0.5];
    }];

}
-(void)onHiddenFocusCurSorAction{
    self.focusCursor.hidden=YES;
}
@end
