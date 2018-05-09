//
//  3DViewController.m
//  iOSCamera
//
//  Created by 李达志 on 2018/5/7.
//  Copyright © 2018年 LDZ. All rights reserved.
//

#import "CATransform3DViewController.h"
#define DEGREES_TO_RADIANS(d) ((d) * M_PI / 180)

@interface CATransform3DViewController (){
    float rotateX;
    float rotateY;
    float dist;

}
@property (nonatomic,strong) CAShapeLayer *shapeLayer;
@property (nonatomic,strong) UIBezierPath *beizer;
@property (nonatomic,assign) CGPoint startPoint;
@property (nonatomic,assign) CGPoint movePoint;
@property (nonatomic,strong) CAShapeLayer *shapelayer;

@property (nonatomic,strong) UIView *topView;
@end

@implementation CATransform3DViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.topView=[[UIView alloc]initWithFrame:CGRectMake(20, 20, kScreenWidth-20, 100)];
    self.topView.backgroundColor=[UIColor orangeColor];
    [self.view addSubview:self.topView];
    UIPanGestureRecognizer *gPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    UIPinchGestureRecognizer *gPinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    [self.topView addGestureRecognizer:gPan];
    [self.topView addGestureRecognizer:gPinch];
    [self drawingAtScreen];

}
-(void)drawingAtScreen{

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panTouch:)];
    [self.view addGestureRecognizer:pan];
    self.beizer = [UIBezierPath bezierPath];
    
    [self initCAShaper];

}

-(void)initCAShaper{

    self.shapeLayer = [[CAShapeLayer alloc] init];
    self.shapeLayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view. frame.size.height);
    self.shapeLayer.fillColor = nil;
    self.shapeLayer.lineCap = kCALineCapRound;
    self.shapeLayer.strokeColor = [UIColor cyanColor].CGColor;
    self.shapeLayer.lineWidth = 2;
    

    [self.view.layer addSublayer:self.shapeLayer];

}

-(void)panTouch:(UIPanGestureRecognizer *)sender{

    _startPoint = [sender locationInView:self.view];
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self.beizer moveToPoint:_startPoint];
    }
    if (sender.state == UIGestureRecognizerStateChanged) {
        _movePoint = [sender locationInView:self.view];

        [_beizer addLineToPoint:_movePoint];
        self.shapeLayer.path = _beizer.CGPath;

    }


}
- (void)pan:(UIPanGestureRecognizer *)gestureRecognizer {
    static CGPoint oldPan;
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        oldPan = CGPointMake(rotateY, -rotateX);
    }
    CGPoint change = [gestureRecognizer translationInView:self.view];
    rotateY =  oldPan.x + change.x;
    rotateX = -oldPan.y - change.y;
    [self anime:0.1];
}

- (void)pinch:(UIPinchGestureRecognizer *)gestureRecognizer {
    static float oldDist;
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        oldDist = dist;
    }
    dist = oldDist + (gestureRecognizer.scale - 1);
    dist = dist < -5 ? -5 : dist > 0.5 ? 0.5 : dist;
    [self anime:0.1];
}
- (void)anime:(float)time {
    CATransform3D trans = CATransform3DIdentity;
    CATransform3D t = CATransform3DIdentity;
    t.m34 = -0.001;
    trans = CATransform3DMakeTranslation(0, 0, dist * 1000);
    trans = CATransform3DConcat(CATransform3DMakeRotation(DEGREES_TO_RADIANS(rotateX), 1, 0, 0), trans);
    trans = CATransform3DConcat(CATransform3DMakeRotation(DEGREES_TO_RADIANS(rotateY), 0, 1, 0), trans);
    trans = CATransform3DConcat(CATransform3DMakeRotation(DEGREES_TO_RADIANS(0), 0, 0, 1), trans);
    trans = CATransform3DConcat(trans, t);

    self.topView.layer.transform=trans;
}

@end
