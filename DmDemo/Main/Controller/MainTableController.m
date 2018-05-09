//
//  MainTableController.m
//  iOSCamera
//
//  Created by 李达志 on 2018/4/7.
//  Copyright © 2018年 LDZ. All rights reserved.
//

#import "MainTableController.h"
#import "MainTableViewCell.h"
#import <AVFoundation/AVFoundation.h>
#import "SimpleCameraController.h"
#import "IDCardViewController.h"
#import "NSString+DMExtension.h"
#import "IDAuthViewController.h"
#import "CoreImageController.h"
#import "YYViewHierarchy3D.h"

@interface MainTableController ()
@property (nonatomic,strong) NSArray * titleArray;

@end

@implementation MainTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    [YYViewHierarchy3D show];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"iOSCamera";
    [self.tableView registerNib:[UINib nibWithNibName:@"MainTableViewCell" bundle:nil ] forCellReuseIdentifier:@"cell"];
    self.titleArray=@[@"普通的拍照功能SimpleCameraController,只是普通的拍照和保存在本地相册的Demo没有其他深入的详解",@"包含身份证识别Demo",@"仿微信二维码扫描",@"iOS相关滤镜处理",@"CIFiterController滤镜运用",@"3DView"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.titleArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.leftLabel.text=self.titleArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGRect rect=[NSString dm_heightStr:self.titleArray[indexPath.row] width:self.view.frame.size.width-20 height:1000 sizefont:17];
    return rect.size.height>50?rect.size.height:50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
             [self.navigationController pushViewController:[SimpleCameraController new] animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:[IDAuthViewController new] animated:YES];

            break;
        case 2:
            [self.navigationController pushViewController: [NSClassFromString(@"QRCodeController") new] animated:YES];
            break;
        case 3:

            [self.navigationController pushViewController: [NSClassFromString(@"CoreImageCategotyController") new] animated:YES];
            break;
        case 4:

            [self.navigationController pushViewController: [NSClassFromString(@"CIFiterController") new] animated:YES];
            break;
        case 5:{
            
            [self.navigationController pushViewController: [NSClassFromString(@"CATransform3DViewController") new] animated:YES];
        }
            break;
        default:

            break;
    }







}
@end
