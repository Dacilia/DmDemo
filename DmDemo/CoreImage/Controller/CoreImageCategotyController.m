//
//  CoreImageCategotyController.m
//  iOSCamera
//
//  Created by 李达志 on 2018/4/27.
//  Copyright © 2018年 LDZ. All rights reserved.
//

#import "CoreImageCategotyController.h"
#import "NSString+DMExtension.h"
#import "CoreImageCategoryCell.h"
#import "CoreCIFiterController.h"
@interface CoreImageCategotyController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSArray * categoryItems;
@end

@implementation CoreImageCategotyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"iOSCoreImage类";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];

}
-(NSArray *)categoryItems{
    if (!_categoryItems) {
        _categoryItems=@[@"kCICategoryDistortionEffect_扭曲效果，比如bump、旋转、hole",@"kCICategoryGeometryAdjustment_几何开着调整，比如仿射变换、平切、透视转换",@"kCICategoryCompositeOperation_合并，比如源覆盖（source over）、最小化、源在顶（source atop）、色彩混合模式",@"kCICategoryHalftoneEffect_Halftone效果，比如screen、line screen、hatched",@"kCICategoryColorAdjustment_色彩调整，比如伽马调整、白点调整、曝光",@"kCICategoryColorEffect_色彩效果，比如色调调整、posterize",@"kCICategoryTransition_图像间转换，比如dissolve、disintegrate with mask、swipe",@"kCICategoryTileEffect_瓦片效果，比如parallelogram、triangle",@"kCICategoryGenerator_图像生成器，比如stripes、constant color、checkerboard",@"kCICategoryGradient_渐变，比如轴向渐变、仿射渐变、高斯渐变",@"kCICategoryStylize_风格化，比如像素化、水晶化",@"kCICategorySharpen_锐化、发光",@"kCICategoryBlur_模糊，比如高斯模糊、焦点模糊、运动模糊",@"kCICategoryStillImage_用于静态图像",@"kCICategoryVideo_用于视频",@"kCICategoryInterlaced_用于交错图像",@"kCICategoryNonSquarePixels_用于非矩形像素",@"kCICategoryHighDynamicRange_用于HDR"];
    }return _categoryItems;
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
    NSString*str=[self.categoryItems objectAtIndex:indexPath.row];
    NSRange rang=[str rangeOfString:@"_"];
    CoreCIFiterController*vc=[[CoreCIFiterController alloc]init];
    vc.categotyStr=[str substringToIndex:rang.location];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
