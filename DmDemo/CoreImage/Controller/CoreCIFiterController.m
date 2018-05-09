//
//  CoreCIFiterController.m
//  iOSCamera
//
//  Created by 李达志 on 2018/4/27.
//  Copyright © 2018年 LDZ. All rights reserved.
//

#import "CoreCIFiterController.h"
#import "CoreImageCategoryCell.h"
#import "FilterResultController.h"
@interface CoreCIFiterController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSArray * categoryItems;

@end

@implementation CoreCIFiterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    if ([self.categotyStr isEqualToString:@"kCICategoryDistortionEffect"]) {
         self.categoryItems=[CIFilter filterNamesInCategory:kCICategoryDistortionEffect];
    }else if ([self.categotyStr isEqualToString:@"kCICategoryGeometryAdjustment"]){
        self.categoryItems=[CIFilter filterNamesInCategory:kCICategoryGeometryAdjustment];
    }else if ([self.categotyStr isEqualToString:@"kCICategoryCompositeOperation"]){
        self.categoryItems=[CIFilter filterNamesInCategory:kCICategoryCompositeOperation];
    }else if ([self.categotyStr isEqualToString:@"kCICategoryHalftoneEffect"]){
         self.categoryItems=[CIFilter filterNamesInCategory:kCICategoryHalftoneEffect];
    }else if ([self.categotyStr isEqualToString:@"kCICategoryColorAdjustment"]){
        self.categoryItems=[CIFilter filterNamesInCategory:kCICategoryColorAdjustment];
    }else if ([self.categotyStr isEqualToString:@"kCICategoryColorEffect"]){
        self.categoryItems=[CIFilter filterNamesInCategory:kCICategoryColorEffect];
    }else if ([self.categotyStr isEqualToString:@"kCICategoryTransition"]){
        self.categoryItems=[CIFilter filterNamesInCategory:kCICategoryTransition];
    }else if ([self.categotyStr isEqualToString:@"kCICategoryTileEffect"]){
        self.categoryItems=[CIFilter filterNamesInCategory:kCICategoryTileEffect];
    }else if ([self.categotyStr isEqualToString:@"kCICategoryGenerator"]){
        self.categoryItems=[CIFilter filterNamesInCategory:kCICategoryGenerator];
    }else if ([self.categotyStr isEqualToString:@"kCICategoryGradient"]){
        self.categoryItems=[CIFilter filterNamesInCategory:kCICategoryGradient];
    }else if ([self.categotyStr isEqualToString:@"kCICategoryStylize"]){
        self.categoryItems=[CIFilter filterNamesInCategory:kCICategoryStylize];
    }else if ([self.categotyStr isEqualToString:@"kCICategorySharpen"]){
        self.categoryItems=[CIFilter filterNamesInCategory:kCICategorySharpen];
    }else if ([self.categotyStr isEqualToString:@"kCICategoryBlur"]){
        self.categoryItems=[CIFilter filterNamesInCategory:kCICategoryBlur];
    }else if ([self.categotyStr isEqualToString:@"kCICategoryStillImage"]){
        self.categoryItems=[CIFilter filterNamesInCategory:kCICategoryStillImage];
    }else if ([self.categotyStr isEqualToString:@"kCICategoryVideo"]){
        self.categoryItems=[CIFilter filterNamesInCategory:kCICategoryVideo];
    }else if ([self.categotyStr isEqualToString:@"kCICategoryInterlaced"]){
        self.categoryItems=[CIFilter filterNamesInCategory:kCICategoryInterlaced];
    }else if ([self.categotyStr isEqualToString:@"kCICategoryNonSquarePixels"]){
        self.categoryItems=[CIFilter filterNamesInCategory:kCICategoryNonSquarePixels];
    }else if ([self.categotyStr isEqualToString:@"kCICategoryHighDynamicRange"]){
        self.categoryItems=[CIFilter filterNamesInCategory:kCICategoryHighDynamicRange];
    }

    [self.tableView reloadData];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    self.title=self.categotyStr;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"CoreImageCategoryCell" bundle:nil] forCellReuseIdentifier:KIDCoreImageCategoryCell];
    }return _tableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.categoryItems.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    CGRect rect=[NSString dm_heightStr:[self.categoryItems objectAtIndex:indexPath.row] width:kScreenWidth-40 height:1000 sizefont:15];
    if (rect.size.height+10<=50) {
        return 50;
    }
    return rect.size.height+10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CoreImageCategoryCell*cell=[tableView dequeueReusableCellWithIdentifier:KIDCoreImageCategoryCell];
    cell.titleLabel.text=[self.categoryItems objectAtIndex:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FilterResultController*vc=[FilterResultController new];
    vc.title=[self.categoryItems objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
