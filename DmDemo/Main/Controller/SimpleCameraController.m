//
//  SimpleCameraController.m
//  iOSCamera
//
//  Created by 李达志 on 2018/4/7.
//  Copyright © 2018年 LDZ. All rights reserved.
//

#import "SimpleCameraController.h"
#import <AVFoundation/AVFoundation.h>
#import <Masonry.h>
@interface SimpleCameraController ()<AVCapturePhotoCaptureDelegate>
//捕获设备，通常是前置摄像头，后置摄像头，麦克风（音频输入）
@property (nonatomic, strong) AVCaptureDevice *device;

//AVCaptureDeviceInput 代表输入设备，他使用AVCaptureDevice 来初始化
@property (nonatomic, strong) AVCaptureDeviceInput *input;

//输出图片
@property (nonatomic ,strong) AVCapturePhotoOutput *imageOutput;
@property (nonatomic,strong)  AVCapturePhotoSettings * photoSettings;

//session：由他把输入输出结合在一起，并开始启动捕获设备（摄像头）
@property (nonatomic, strong) AVCaptureSession *session;

//图像预览层，实时显示捕获的图像
@property (nonatomic ,strong) AVCaptureVideoPreviewLayer *previewLayer;
//闪光灯设置
@property (nonatomic, assign) AVCaptureFlashMode mode;
//前置或者后置摄像头
@property (nonatomic, assign) AVCaptureDevicePosition position;

@property (nonatomic,strong) UIButton * cameraButton;
@property (nonatomic,strong) UIButton * lightButton;
@property (nonatomic,strong) UIButton * changButton;
@property (nonatomic,strong) UIView * focusView;
@end

@implementation SimpleCameraController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCamera];

    self.cameraButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [self.cameraButton addTarget:self action:@selector(photoBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    self.cameraButton.frame=CGRectMake(0, self.view.frame.size.height-50, 200, 50);
    [self.cameraButton setBackgroundColor:[UIColor colorWithRed:70 green:80 blue:80 alpha:0.5]];
    [self.view addSubview:self.cameraButton];
    self.cameraButton.layer.cornerRadius=30;
    [self.cameraButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@60);
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(@-50);
    }];
    self.lightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.lightButton setTitle:@"闪光灯" forState:UIControlStateNormal];
    [self.lightButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.lightButton setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [self.lightButton addTarget:self action:@selector(lightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.lightButton];
    [self.lightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.width.equalTo(@60);
        make.height.equalTo(@30);
        make.bottom.equalTo(@-50);
    }];
    self.changButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.changButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.changButton setTitle:@"后置" forState:UIControlStateNormal];
    [ self.changButton setTitle:@"前置" forState:UIControlStateSelected];
    [self.view addSubview:self.changButton];
    [self.changButton addTarget:self action:@selector(changButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.changButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.width.height.equalTo(@50);
        make.bottom.equalTo(@-150);
    }];
    self.focusView=[[UIView alloc]initWithFrame:CGRectMake(0, 50, 50, 50)];
    self.focusView.layer.cornerRadius=5;
    self.focusView.layer.masksToBounds=YES;
    self.focusView.layer.borderColor=[UIColor redColor].CGColor;
    self.focusView.layer.borderWidth=1.5;
    [self.view addSubview:self.focusView];
    self.focusView.hidden=YES;



}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self focusAtPoint:[touches.anyObject locationInView:self.view]];
}
    //AVCaptureFlashMode  闪光灯
    //AVCaptureFocusMode  对焦
    //AVCaptureExposureMode  曝光
    //AVCaptureWhiteBalanceMode  白平衡
    //闪光灯和白平衡可以在生成相机时候设置
    //曝光要根据对焦点的光线状况而决定,所以和对焦一块写
    //point为点击的位置
- (void)focusAtPoint:(CGPoint)point{
    CGSize size = self.view.bounds.size;
    CGPoint focusPoint = CGPointMake( point.y /size.height ,1-point.x/size.width );
    NSError *error;
    if ([self.device lockForConfiguration:&error]) {
            //对焦模式和对焦点
        if ([self.device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
            [self.device setFocusPointOfInterest:focusPoint];
            [self.device setFocusMode:AVCaptureFocusModeAutoFocus];
        }
            //曝光模式和曝光点
        if ([self.device isExposureModeSupported:AVCaptureExposureModeAutoExpose ]) {
            [self.device setExposurePointOfInterest:focusPoint];
            [self.device setExposureMode:AVCaptureExposureModeAutoExpose];
        }

        [self.device unlockForConfiguration];
            //设置对焦动画
        _focusView.center = point;
        _focusView.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            _focusView.transform = CGAffineTransformMakeScale(1.25, 1.25);
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                _focusView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                _focusView.hidden = YES;
            }];
        }];
    }

}


-(void)lightButtonAction{
    self.lightButton.selected=!self.lightButton.selected;
    if (self.mode == AVCaptureFlashModeOn) {
        [self setMode:AVCaptureFlashModeOff];
    } else {
        [self setMode:AVCaptureFlashModeOn];
    }

}
-(void)changButtonAction{
    self.changButton.selected=!self.changButton.selected;
    self.position=self.changButton.isSelected? AVCaptureDevicePositionFront:AVCaptureDevicePositionBack;
    if (@available(iOS 10.0, *)) {
        AVCaptureDevice * device =  [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera mediaType:AVMediaTypeVideo position:self.position];
        if (device) {
            self.device = device;
            AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
            [self.session beginConfiguration];
            [self.session removeInput:self.input];
            if ([self.session canAddInput:input]) {
                [self.session addInput:input];
                self.input = input;
                [self.session commitConfiguration];
            }
        }
    } else {

    }
}
-(void)initCamera{
    self.mode=AVCaptureFlashModeAuto;
    self.position = AVCaptureDevicePositionBack;
    self.device=[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];

    self.input=[[AVCaptureDeviceInput alloc]initWithDevice:self.device error:nil];
    self.session=[[AVCaptureSession alloc]init];
    if (@available(iOS 10.0, *)) {
        self.imageOutput=[[AVCapturePhotoOutput alloc]init];
    } else {
            // Fallback on earlier versions
    }
    //    AVCaptureSessionPreset320x240
    //    AVCaptureSessionPreset352x288
    //    AVCaptureSessionPreset640x480
    //    AVCaptureSessionPreset960x540
    //    AVCaptureSessionPreset1280x720
    //    AVCaptureSessionPreset1920x1080
    //    AVCaptureSessionPreset3840x2160
    self.session.sessionPreset=AVCaptureSessionPreset1280x720;
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    if ([self.session canAddOutput:self.imageOutput]) {
        [self.session addOutput:self.imageOutput];
    }
    self.previewLayer=[[AVCaptureVideoPreviewLayer alloc]initWithSession:self.session];
    self.previewLayer.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view.layer addSublayer:self.previewLayer];
    [self.session startRunning];
}

- (void)photoBtnDidClick
{
    if (@available(iOS 10.0, *)) {
        self.photoSettings = [AVCapturePhotoSettings photoSettingsWithFormat:@{AVVideoCodecKey:AVVideoCodecTypeJPEG}];
    } else {
            // Fallback on earlier versions
    }

    [self.photoSettings setFlashMode:self.mode];
    [self.imageOutput capturePhotoWithSettings:self.photoSettings delegate:self];
}
-(void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhotoSampleBuffer:(CMSampleBufferRef)photoSampleBuffer previewPhotoSampleBuffer:(CMSampleBufferRef)previewPhotoSampleBuffer resolvedSettings:(AVCaptureResolvedPhotoSettings *)resolvedSettings bracketSettings:(AVCaptureBracketedStillImageSettings *)bracketSettings error:(NSError *)error{

    if (@available(iOS 10.0, *)) {
        NSData *imageData = [AVCapturePhotoOutput JPEGPhotoDataRepresentationForJPEGSampleBuffer:photoSampleBuffer previewPhotoSampleBuffer:previewPhotoSampleBuffer];
        UIImage *image = [UIImage imageWithData:imageData];
            // 播放一下“拍照”的声音，模拟拍照
        AudioServicesPlaySystemSound(1108);
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    } else {
            // Fallback on earlier versions
    }


}
    // 指定回调方法

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo

{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    UIAlertController*alertVc=[UIAlertController alertControllerWithTitle:@"保存图片结果" message:msg preferredStyle:UIAlertControllerStyleAlert];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

    }]];
    [self presentViewController:alertVc animated:YES completion:nil];
}

@end
