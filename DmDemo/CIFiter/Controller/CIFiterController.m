//
//  CIFiterController.m
//  iOSCamera
//
//  Created by 李达志 on 2018/5/5.
//  Copyright © 2018年 LDZ. All rights reserved.
//

#import "CIFiterController.h"
#import "FiterImageCollectCell.h"
#import "StyleCollectionCell.h"
#import "DmColorAdjustmentFiter.h"
#import "DmEffectItem.h"
#import "DmStylize.h"
#import "DmBlur.h"
@class FilterModel;
@interface CIFiterController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) UIImageView * currentImageView;
@property (nonatomic,strong) UIImage * originImage;

@property (nonatomic,strong) NSMutableArray *styleItems;
@property (nonatomic,strong) NSMutableArray*stylizeItems;
@property (nonatomic,strong) NSMutableArray * blurItems;
@property (nonatomic,strong) NSMutableArray * filterItems;
@property (nonatomic,strong) UICollectionView * styleCollectionView;
@property (nonatomic,strong) FilterModel * selectFilterModel;
@end

@interface FilterModel:NSObject//本页面使用到
@property (nonatomic,copy) NSString * styleStr;
@property (nonatomic,strong) NSArray * filterItems;
@end
@implementation FilterModel
+(instancetype)filterModelStyleStr:(NSString*)styleStr filterItems:(NSArray*)filterItems{
    FilterModel*model=[[FilterModel alloc]init];
    model.styleStr=styleStr;
    model.filterItems=[NSArray arrayWithArray:filterItems];
    return model;
}
@end
@implementation CIFiterController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.hidden=YES;
    self.originImage=[UIImage imageNamed:@"i17"];
    [self.view addSubview:self.currentImageView];
    [self.currentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(@(kScreenHeight-190));
        make.top.equalTo(@10);
    }];
    [self.view addSubview:self.styleCollectionView];
    [self.styleCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@-150);
        make.height.equalTo(@30);
    }];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(@140);
    }];
}
-(NSMutableArray *)styleItems{
    if (!_styleItems) {
        _styleItems=[NSMutableArray array];
        [_styleItems addObject:[FilterModel filterModelStyleStr:@"CICategoryColorAdjustment 色彩调整，比如伽马调整、白点调整、曝光 的一个封装" filterItems:self.filterItems]];
        [_styleItems addObject:[FilterModel filterModelStyleStr:@"kCICategoryBlur_模糊，比如高斯模糊、焦点模糊、运动模糊" filterItems:self.blurItems]];
        [_styleItems addObject:[FilterModel filterModelStyleStr:@"kCICategoryStylize_风格化，比如像素化、水晶化" filterItems:self.stylizeItems]];
        self.selectFilterModel=[_stylizeItems objectAtIndex:0];

    }return _styleItems;
}
-(NSMutableArray *)blurItems{
    if (!_blurItems) {
        _blurItems=[NSMutableArray array];
        [_blurItems addObject:[DmEffectItem dmEffectItem:self.originImage effctStr:@"原图"]];
        [_blurItems addObject:[DmEffectItem dmEffectItem:[DmBlur dmCIBoxBlurInputImage:self.originImage] effctStr:@"CIBoxBlur"]];
        [_blurItems addObject:[DmEffectItem dmEffectItem:[DmBlur dmCIDiscBlurInputImage:self.originImage] effctStr:@"CIDiscBlur"]];
        [_blurItems addObject:[DmEffectItem dmEffectItem:[DmBlur dmCIGaussianBlurInputImage:self.originImage] effctStr:@"CIGaussianBlur"]];
        [_blurItems addObject:[DmEffectItem dmEffectItem:[DmBlur dmCIMaskedVariableBlurInputImage:self.originImage inputMask:self.originImage] effctStr:@"CIMaskedVariableBlur" ]];
        [_blurItems addObject:[DmEffectItem dmEffectItem:[DmBlur dmCIMedianFilterInputImage:self.originImage] effctStr:@"CIMedianFilter"]];

        [_blurItems addObject:[DmEffectItem dmEffectItem:[DmBlur dmCIMotionBlurInputImage:self.originImage] effctStr:@"CIMotionBlur"]];
        [_blurItems addObject:[DmEffectItem dmEffectItem:[DmBlur dmCINoiseReductionInputImage:self.originImage] effctStr:@"CINoiseReduction"]];
        [_blurItems addObject:[DmEffectItem dmEffectItem:[DmBlur dmCIZoomBlurInputImage:self.originImage] effctStr:@"CIZoomBlurInput"]];
       

    }return _blurItems;
}
-(NSMutableArray *)stylizeItems{
    if (!_stylizeItems) {
        _stylizeItems=[NSMutableArray array];
        [_stylizeItems addObject:[DmEffectItem dmEffectItem:self.originImage effctStr:@"原图"]];
        [_stylizeItems addObject:[DmEffectItem dmEffectItem:[DmStylize dmCIBlendWithAlphaMaskInputImage:self.originImage inputBackgroundImage:self.originImage inputMaskImage:self.originImage] effctStr:@"CIBlendWithAlphaMask"]];
        [_stylizeItems addObject:[DmEffectItem dmEffectItem:[DmStylize dmCIBlendWithMaskInputImage:self.originImage inputBackgroundImage:self.originImage inputMaskImage:self.originImage] effctStr:@"CIBlendWithMask"]];

        [_stylizeItems addObject:[DmEffectItem dmEffectItem:[DmStylize dmCIBloomInputImage:self.originImage] effctStr:@"CIBloom"]];
        [_stylizeItems addObject:[DmEffectItem dmEffectItem:[DmStylize dmCIComicEffectInputImage:self.originImage] effctStr:@"CIComicEffect"]];
        [_stylizeItems addObject:[DmEffectItem dmEffectItem:[DmStylize dmCIConvolution3X3InputImage:self.originImage] effctStr:@"CIConvolution3X3"]];
        [_stylizeItems addObject:[DmEffectItem dmEffectItem:[DmStylize dmCIConvolution5X5InputImage:self.originImage] effctStr:@"CIConvolution5X5"]];
        [_stylizeItems addObject:[DmEffectItem dmEffectItem:[DmStylize dmCIConvolution7X7InputImage:self.originImage] effctStr:@"CIConvolution7X7"]];

        [_stylizeItems addObject:[DmEffectItem dmEffectItem:[DmStylize dmCIConvolution9HorizontalInputImage:self.originImage] effctStr:@"CIConvolution9Horizontal"]];
        [_stylizeItems addObject:[DmEffectItem dmEffectItem:[DmStylize dmCICrystallizeInputImage:self.originImage] effctStr:@"CICrystallize"]];
        [_stylizeItems addObject:[DmEffectItem dmEffectItem:[DmStylize dmCIDepthOfFieldInputImage:self.originImage] effctStr:@"CIDepthOfField"]];
        [_stylizeItems addObject:[DmEffectItem dmEffectItem:[DmStylize dmCIEdgesInputImage:self.originImage] effctStr:@"CIEdges"]];
        [_stylizeItems addObject:[DmEffectItem dmEffectItem:[DmStylize dmCIEdgeWorkInputImage:self.originImage] effctStr:@"CIEdgeWork"]];

        [_stylizeItems addObject:[DmEffectItem dmEffectItem:[DmStylize dmCIGloomInputImage:self.originImage] effctStr:@"CIGloom"]];
        [_stylizeItems addObject:[DmEffectItem dmEffectItem:[DmStylize dmCIHeightFieldFromMaskInputImage:self.originImage] effctStr:@"CIHeightFieldFromMask"]];
        [_stylizeItems addObject:[DmEffectItem dmEffectItem:[DmStylize dmCIHexagonalPixellateInputImage:self.originImage] effctStr:@"CIHexagonalPixellate"]];
        [_stylizeItems addObject:[DmEffectItem dmEffectItem:[DmStylize dmCIHighlightShadowAdjustInputImage:self.originImage] effctStr:@"CIHighlightShadowAdjust"]];
        [_stylizeItems addObject:[DmEffectItem dmEffectItem:[DmStylize dmCILineOverlayInputImage:self.originImage] effctStr:@"CILineOverlay"]];

        [_stylizeItems addObject:[DmEffectItem dmEffectItem:[DmStylize dmCIPixellateInputImage:self.originImage] effctStr:@"CIPixellate"]];
        [_stylizeItems addObject:[DmEffectItem dmEffectItem:[DmStylize dmCIPointillizeInputImage:self.originImage] effctStr:@"CIPointillize"]];
        [_stylizeItems addObject:[DmEffectItem dmEffectItem:[DmStylize dmCIShadedMaterialInputImage:self.originImage inputShadingImage:self.originImage] effctStr:@"CIShadedMaterial"]];
        [_stylizeItems addObject:[DmEffectItem dmEffectItem:[DmStylize dmCISpotColorInputImage:self.originImage] effctStr:@"CISpotColor"]];
        [_stylizeItems addObject:[DmEffectItem dmEffectItem:[DmStylize dmCISpotLightInputImage:self.originImage] effctStr:@"CISpotLight"]];
        

    }return _stylizeItems;
}
-(UIImageView *)currentImageView{
    if (!_currentImageView) {
        _currentImageView=[[UIImageView alloc]init];
        _currentImageView.image=[UIImage imageNamed:@"i17"];
        _currentImageView.contentMode=UIViewContentModeScaleAspectFit;
    }return _currentImageView;
}
-(NSMutableArray *)filterItems{
    if (!_filterItems) {
        _filterItems=[NSMutableArray array];
        [_filterItems addObject:[DmEffectItem dmEffectItem:self.originImage effctStr:@"原图"]];
        [_filterItems addObject:[DmEffectItem dmEffectItem:[DmColorAdjustmentFiter dmClolorClamp:self.originImage] effctStr:@"ClolorClamp"]];
        [_filterItems addObject:[DmEffectItem dmEffectItem:[DmColorAdjustmentFiter dmColorControls:self.originImage] effctStr:@"ColorControls"]];
         [_filterItems addObject:[DmEffectItem dmEffectItem:[DmColorAdjustmentFiter dmColorMatrix:self.originImage] effctStr:@"ColorMatrix"]];
        [_filterItems addObject:[DmEffectItem dmEffectItem:[DmColorAdjustmentFiter dmColorPolynomial:self.originImage] effctStr:@"ColorPolynomial"]];
        [_filterItems addObject:[DmEffectItem dmEffectItem:[DmColorAdjustmentFiter dmCIExposureAdjust:self.originImage] effctStr:@"CIExposureAdjust"]];
        [_filterItems addObject:[DmEffectItem dmEffectItem:[DmColorAdjustmentFiter dmCIGammaAdjust:self.originImage] effctStr:@"CIGammaAdjust"]];
        [_filterItems addObject:[DmEffectItem dmEffectItem:[DmColorAdjustmentFiter dmCIHueAdjust:self.originImage] effctStr:@"CIHueAdjust"]];
        [_filterItems addObject:[DmEffectItem dmEffectItem:[DmColorAdjustmentFiter dmCILinearToSRGBToneCurve:self.originImage] effctStr:@"CILinearToSRGBToneCurve"]];
        [_filterItems addObject:[DmEffectItem dmEffectItem:[DmColorAdjustmentFiter dmCISRGBToneCurveToLinear:self.originImage] effctStr:@"CISRGBToneCurveToLinear"]];
        [_filterItems addObject:[DmEffectItem dmEffectItem:[DmColorAdjustmentFiter dmCITemperatureAndTint:self.originImage] effctStr:@"CITemperatureAndTint"]];
        [_filterItems addObject:[DmEffectItem dmEffectItem:[DmColorAdjustmentFiter dmCIToneCurve:self.originImage] effctStr:@"CIToneCurve"]];
        [_filterItems addObject:[DmEffectItem dmEffectItem:[DmColorAdjustmentFiter dmCIVibrance:self.originImage] effctStr:@"CIVibrance"]];
        [_filterItems addObject:[DmEffectItem dmEffectItem:[DmColorAdjustmentFiter dmCIWhitePointAdjust:self.originImage] effctStr:@"CIWhitePointAdjust"]];
        
    }return _filterItems;
}
-(UICollectionView *)styleCollectionView{
    if (_styleCollectionView==nil) {
        UICollectionViewFlowLayout*lay=[[UICollectionViewFlowLayout alloc] init];
        lay.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        _styleCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:lay];
        _styleCollectionView.dataSource                      = self;
        _styleCollectionView.delegate                        = self;
        _styleCollectionView.showsVerticalScrollIndicator    = NO;
        _styleCollectionView.showsHorizontalScrollIndicator  = NO;
        _styleCollectionView.scrollEnabled                   = YES;
        _styleCollectionView.backgroundColor                 = [UIColor clearColor];
        [_styleCollectionView registerNib:[UINib nibWithNibName:@"StyleCollectionCell" bundle:nil] forCellWithReuseIdentifier:KIDStyleCollectionCell];

    }
    return _styleCollectionView;
}
-(UICollectionView *)collectionView{
    if (_collectionView==nil) {
        UICollectionViewFlowLayout*lay=[[UICollectionViewFlowLayout alloc] init];
        lay.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:lay];
        _collectionView.dataSource                      = self;
        _collectionView.delegate                        = self;
        _collectionView.showsVerticalScrollIndicator    = NO;
        _collectionView.showsHorizontalScrollIndicator  = NO;
        _collectionView.scrollEnabled                   = YES;
        _collectionView.backgroundColor                 = [UIColor clearColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"FiterImageCollectCell" bundle:nil] forCellWithReuseIdentifier:KIDFiterImageCollectCell];

    }
    return _collectionView;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView==self.styleCollectionView) {
        return self.styleItems.count;
    }
    return self.selectFilterModel.filterItems.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView==self.styleCollectionView) {
        StyleCollectionCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:KIDStyleCollectionCell forIndexPath:indexPath];
        FilterModel*model=self.styleItems[indexPath.row];
        cell.styleLabel.text=model.styleStr;
        return cell;
    }
    FiterImageCollectCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:KIDFiterImageCollectCell forIndexPath:indexPath];
    cell.item=[self.selectFilterModel.filterItems objectAtIndex:indexPath.item];
    return cell;
}

#pragma mark - UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView==self.styleCollectionView) {
        self.selectFilterModel=[self.styleItems objectAtIndex:indexPath.item];
        [self.collectionView reloadData];
        return;
    }

    DmEffectItem*item=[self.selectFilterModel.filterItems objectAtIndex:indexPath.row];
    self.currentImageView.image=item.effctImage;
    
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView==self.styleCollectionView) {
        FilterModel*model=[self.styleItems objectAtIndex:indexPath.item];
        CGSize size=[model.styleStr sizeWithFont:[UIFont systemFontOfSize:14]];
        return CGSizeMake(size.width+20, 30);
    }
    return CGSizeMake(100,140);

}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 20;
}
    //设置section的内边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


@end
