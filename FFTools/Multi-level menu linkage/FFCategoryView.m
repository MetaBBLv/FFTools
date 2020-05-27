//
//  FFCategoryView.m
//  bosheng
//
//  Created by zhou on 2019/12/14.
//  Copyright © 2019 bosheng. All rights reserved.
//

#import "FFCategoryView.h"
#import "FFCategoryCollectionViewCell.h"
#import "ReactiveObjC.h"
#import "SVProgressHUD.h"

#define WIDTH_6_SCALE 375.0 * [UIScreen mainScreen].bounds.size.width
//屏幕宽高
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define FONTANDBOLD(FONTSIZE) [UIFont boldSystemFontOfSize:FONTSIZE]

//!未折叠状态展示的item数量
#define currentShowNumber 3

@interface FFCategoryView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray*currentArray;
    NSMutableArray *dataArray; //保留的原始数据
    NSArray*allArray;
    UILabel *titleLabel;
    UIButton *showAllbtn;
    bool chooseState;  //选择状态开启或者关闭
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *bottomView;
//!阴影层 ***************************************************************************
@property (nonatomic, strong) UIView *shadowView;
//!移除层 ***************************************************************************
@property (nonatomic, strong) UIButton *removeBtn;
//!展示层 ***************************************************************************
@property (nonatomic, strong) UIView *showView;

@end

@implementation FFCategoryView

#pragma mark - init Method
- (instancetype)initWithFrame:(CGRect)frame data:(NSArray *)data {
    if (self = [super init]) {
        currentArray = [[NSMutableArray alloc] init];
        dataArray = [[NSMutableArray alloc] init];
        allArray = data;
        [dataArray addObject:allArray];
        NSInteger num = allArray.count > currentShowNumber ? currentShowNumber : allArray.count;
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        for (int i = 0; i < num; i ++) {
            [arr addObject:allArray[i]];
        }
        [currentArray addObject:arr];
        [currentArray[0][0] setValue:@"0" forKey:@"chooseState"];
        [self customShadowView];
    }
    return self;
}

- (void)customShadowView {
    _shadowView = [[UIView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    _shadowView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    [[UIApplication sharedApplication].keyWindow addSubview:_shadowView];
    [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
    [_shadowView addSubview:self.removeBtn];
    [_shadowView addSubview:self.showView];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.shadowView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        self.showView.frame = CGRectMake(95/WIDTH_6_SCALE, 0, SCREEN_WIDTH-95/WIDTH_6_SCALE, SCREEN_HEIGHT);
    } completion:^(BOOL finished) {

    }];
}

#pragma mark - lazyloading
- (UIView *)showView {
    if (!_showView) {
        _showView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH-95/WIDTH_6_SCALE, SCREEN_HEIGHT)];
        _showView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1.00];
        _showView.layer.cornerRadius = 5/WIDTH_6_SCALE;
        _showView.layer.masksToBounds = YES;
        [_showView addSubview:self.collectionView];
        [_showView addSubview:self.bottomView];
    }
    return _showView;
}

- (UIButton *)removeBtn {
    if (!_removeBtn) {
        _removeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 95/WIDTH_6_SCALE, SCREEN_HEIGHT)];
        _removeBtn.backgroundColor = [UIColor clearColor];
        [_removeBtn addTarget:self action:@selector(removeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _removeBtn;
}

-(UICollectionView*)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout * folwlayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-95/WIDTH_6_SCALE, SCREEN_HEIGHT- 50/WIDTH_6_SCALE) collectionViewLayout:folwlayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator=NO;
        _collectionView.showsHorizontalScrollIndicator=NO;
        [_collectionView registerClass:[FFCategoryCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
    }
    return _collectionView;
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50/WIDTH_6_SCALE, SCREEN_WIDTH-95/WIDTH_6_SCALE, 50/WIDTH_6_SCALE)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
        [_bottomView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        UIButton *restartBtn = [[UIButton alloc] init];
        [restartBtn setTitle:@"重置" forState:UIControlStateNormal];
        [restartBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        restartBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        restartBtn.layer.cornerRadius = 20/WIDTH_6_SCALE;
        restartBtn.layer.masksToBounds = YES;
        restartBtn.layer.borderWidth = 1;
        restartBtn.layer.borderColor = [UIColor colorWithHexString:@"e5e5e5"].CGColor;
        [[restartBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            for (NSMutableDictionary *dic in self->currentArray[0]) {
                [dic setValue:@"0" forKey:@"select"];
            }
            [self->currentArray removeAllObjects];
            [self->currentArray addObject:self->allArray];
            [self.collectionView reloadData];
        }];
        [_bottomView addSubview:restartBtn];
        [restartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5/WIDTH_6_SCALE);
            make.left.mas_equalTo(10/WIDTH_6_SCALE);
            make.bottom.mas_equalTo(-5/WIDTH_6_SCALE);
            make.width.mas_equalTo((SCREEN_WIDTH-125/WIDTH_6_SCALE)/2);
        }];
        
        UIButton *submitBtn = [[UIButton alloc] init];
        [submitBtn setTitle:@"确定" forState:UIControlStateNormal];
        [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        submitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        submitBtn.backgroundColor = [UIColor colorWithHexString:@"d13931"];
        submitBtn.layer.cornerRadius = 20/WIDTH_6_SCALE;
        submitBtn.layer.masksToBounds = YES;
        [[submitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            NSString * str = @"";
            for (NSArray *arr in self->currentArray) {
                for (NSDictionary *dic in arr) {
                    if ([dic[@"select"] isEqualToString:@"1"]) {
                        NSString *ss = [NSString stringWithFormat:@"%@",dic[@"typeName"]];
                        str = [NSString stringWithFormat:@"%@%@",str,ss];
                    }
                }
            }
            [SVProgressHUD showSuccessWithStatus:str];
            [UIView animateWithDuration:0.5 animations:^{
                self.shadowView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
                self.showView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH-95/WIDTH_6_SCALE, SCREEN_HEIGHT);
            } completion:^(BOOL finished) {
                [self.shadowView removeFromSuperview];
                if (self.submitBlock) {
                    self.submitBlock(str);
                }
            }];
            
        }];
        [_bottomView addSubview:submitBtn];
        [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5/WIDTH_6_SCALE);
            make.right.mas_equalTo(-10/WIDTH_6_SCALE);
            make.bottom.mas_equalTo(-5/WIDTH_6_SCALE);
            make.width.mas_equalTo((SCREEN_WIDTH-125/WIDTH_6_SCALE)/2);
        }];
        
    }
    return _bottomView;
}

#pragma mark - collection Delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return currentArray.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [currentArray[section] count];
}

//定义item大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

     return CGSizeMake(80/WIDTH_6_SCALE, 25/WIDTH_6_SCALE);

}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    FFCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell sizeToFit];
    cell.model = currentArray[indexPath.section][indexPath.row];
    return cell;
}

//动态设置每行的间距大小
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10/WIDTH_6_SCALE;
}

//动态设置每列的间距大小
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5/WIDTH_6_SCALE;

}

//动态设置每个分区的EdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0/WIDTH_6_SCALE, 10/WIDTH_6_SCALE, 0/WIDTH_6_SCALE, 10/WIDTH_6_SCALE);

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(SCREEN_WIDTH, 50/WIDTH_6_SCALE);
    }
    else
    {
        return CGSizeMake(SCREEN_WIDTH, 75/WIDTH_6_SCALE);
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        for(UIView *subView in header.subviews) {
        [subView removeFromSuperview];
        }
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
        [header addSubview:view];
        showAllbtn = [[UIButton alloc] init];
        showAllbtn.titleLabel.font = [UIFont systemFontOfSize:12];
        showAllbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [showAllbtn setTitle:@"全部▽" forState:UIControlStateNormal];
        [showAllbtn setTitle:@"全部△" forState:UIControlStateSelected];
        [showAllbtn setTitleColor:[UIColor colorWithHexString:@"b4b5b1"] forState:UIControlStateNormal];
        [showAllbtn setTitleColor:[UIColor colorWithHexString:@"d13931"] forState:UIControlStateSelected];
        showAllbtn.tag = indexPath.section;
        [showAllbtn addTarget:self action:@selector(showAllBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [header addSubview: showAllbtn];
        if ([currentArray[indexPath.section] count] > currentShowNumber - 1) {
            showAllbtn.hidden = NO;
        }
        else
        {
            showAllbtn.hidden = YES;
        }
        
        if ([currentArray[indexPath.section][0][@"chooseState"] isEqualToString:@"1"]) {
            
            showAllbtn.selected = YES;
        }
        else
        {
            showAllbtn.selected = NO;
        }
        
        titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = FONTANDBOLD(14);
        if (indexPath.section == 0) {
            view.frame = CGRectMake(0, 0, SCREEN_WIDTH-95/WIDTH_6_SCALE, 0);
            titleLabel.frame = CGRectMake(10/WIDTH_6_SCALE, 0, 100/WIDTH_6_SCALE, 50/WIDTH_6_SCALE);
            titleLabel.text = @"请选择分类";
            [showAllbtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.right.mas_equalTo(-10/WIDTH_6_SCALE);
                make.size.mas_equalTo(CGSizeMake(80/WIDTH_6_SCALE, 50/WIDTH_6_SCALE));
            }];
        }
        else
        {
            view.frame = CGRectMake(0, 15/WIDTH_6_SCALE, SCREEN_WIDTH-95/WIDTH_6_SCALE, 10/WIDTH_6_SCALE);
            titleLabel.frame = CGRectMake(10/WIDTH_6_SCALE, 25/WIDTH_6_SCALE, 100/WIDTH_6_SCALE, 50/WIDTH_6_SCALE);
            if ([currentArray[indexPath.section][indexPath.row][@"nextTitle"] isEqual:[NSNull null]]) {
                titleLabel.text = @"请选择";
            }
            else {
                titleLabel.text = [NSString stringWithFormat:@"请选择%@",currentArray[indexPath.section - 1][indexPath.row][@"nextTitle"]];
            }
            [showAllbtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(25/WIDTH_6_SCALE);
                make.right.mas_equalTo(-10/WIDTH_6_SCALE);
                make.size.mas_equalTo(CGSizeMake(80/WIDTH_6_SCALE, 50/WIDTH_6_SCALE));
            }];
        }
        [header addSubview:titleLabel];
        return header;
    }
    return [UICollectionReusableView new];
}

//点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0){
        NSInteger num = currentArray.count - indexPath.section - 1;
        [currentArray removeObjectsInRange:NSMakeRange(indexPath.section + 1, num)];
        NSDictionary *dic = currentArray[indexPath.section][indexPath.row];
        if ([dic[@"children"] count] != 0) {
            for (NSMutableDictionary *dd in dic[@"children"]) {
                [dd setValue:@"0" forKey:@"select"];
            }
            NSInteger num = [dic[@"children"] count] > currentShowNumber ? currentShowNumber : [dic[@"children"] count];
            NSMutableArray *arr = [[NSMutableArray alloc] init];
            for (int i = 0; i < num; i ++) {
                [arr addObject:dic[@"children"][i]];
            }
            [currentArray addObject:arr];
        }
        for (NSMutableDictionary *dic in currentArray[0]) {
            [dic setValue:@"0" forKey:@"select"];
        }
    }
    else if (indexPath.section < currentArray.count -1) {
        NSInteger num = currentArray.count - indexPath.section - 1;
        [currentArray removeObjectsInRange:NSMakeRange(indexPath.section + 1, num)];
        NSDictionary *dic = currentArray[indexPath.section][indexPath.row];
        if ([dic[@"children"] count] != 0) {
            for (NSMutableDictionary *dd in dic[@"children"]) {
                [dd setValue:@"0" forKey:@"select"];
            }
            NSInteger num = [dic[@"children"] count] > currentShowNumber ? currentShowNumber : [dic[@"children"] count];
            NSMutableArray *arr = [[NSMutableArray alloc] init];
            for (int i = 0; i < num; i ++) {
                [arr addObject:dic[@"children"][i]];
            }
            [currentArray addObject:arr];
        }
        for (NSMutableDictionary *dic in currentArray[indexPath.section]) {
            [dic setValue:@"0" forKey:@"select"];
        }
    }
    else {
        NSDictionary *dic = currentArray[indexPath.section][indexPath.row];
        if ([dic[@"children"] count] != 0) {
            for (NSMutableDictionary *dd in dic[@"children"]) {
                [dd setValue:@"0" forKey:@"select"];
            }
            NSInteger num = [dic[@"children"] count] > currentShowNumber ? currentShowNumber : [dic[@"children"] count];
            NSMutableArray *arr = [[NSMutableArray alloc] init];
            for (int i = 0; i < num; i ++) {
                [arr addObject:dic[@"children"][i]];
            }
            [currentArray addObject:arr];
        }
        for (NSMutableDictionary *dic in currentArray[indexPath.section]) {
            [dic setValue:@"0" forKey:@"select"];
        }
    }
    if (!currentArray[indexPath.section][0][@"chooseState"]) {
        [currentArray[indexPath.section][0] setValue:@"0" forKey:@"chooseState"];
    }
    if (indexPath.section != (currentArray.count -1))
    {
        [currentArray[indexPath.section + 1][0] setValue:@"0" forKey:@"chooseState"];
    }
    [self->currentArray[indexPath.section][indexPath.row] setValue:@"1" forKey:@"select"];
    [self.collectionView reloadData];
}

#pragma mark - event response
- (void)showAllBtnAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [currentArray[sender.tag][0] setValue:@"1" forKey:@"chooseState"];
        if (sender.tag == 0) {
            for (NSMutableDictionary *dd in allArray) {
                [dd setValue:@"0" forKey:@"select"];
            }
            [currentArray replaceObjectAtIndex:sender.tag withObject:allArray];
            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag]];
        }
        else
        {
            NSArray *arr = [self findIdWithArray:allArray section:sender.tag];
            if (arr.count != 0) {
                for (NSMutableDictionary *dd in arr) {
                    [dd setValue:@"0" forKey:@"select"];
                }
                [currentArray replaceObjectAtIndex:sender.tag withObject:arr];
                [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag]];
            }
        }
     }
     else
     {
        [currentArray[sender.tag][0] setValue:@"0" forKey:@"chooseState"];
         if (sender.tag == 0) {
             for (NSMutableDictionary *dd in allArray) {
                 [dd setValue:@"0" forKey:@"select"];
             }
             NSInteger num = allArray.count > currentShowNumber ? currentShowNumber : allArray.count;
             NSMutableArray *arr = [[NSMutableArray alloc] init];
             for (int i = 0; i < num; i ++) {
                 [arr addObject:self->allArray[i]];
             }
             if (arr.count != 0) {
                 [currentArray replaceObjectAtIndex:sender.tag withObject:arr];
                 [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag]];
             }
         }
         else
         {
             NSArray *arrData = [self findIdWithArray:allArray section:sender.tag];
            
             if (arrData.count != 0) {
                 for (NSMutableDictionary *dd in arrData) {
                     [dd setValue:@"0" forKey:@"select"];
                 }
                 NSInteger num = arrData.count > currentShowNumber ? currentShowNumber : arrData.count;
                 NSMutableArray *arr = [[NSMutableArray alloc] init];
                 for (int i = 0; i < num; i ++) {
                     [arr addObject:arrData[i]];
                 }
                 [currentArray replaceObjectAtIndex:sender.tag withObject:arr];
                 [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag]];
             }
         }
     }
}

- (void)removeAction{
    //关闭
    [UIView animateWithDuration:0.5 animations:^{
        self.shadowView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
        self.showView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH-95/WIDTH_6_SCALE, SCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        [self.shadowView removeFromSuperview];
        if (self.exitBlock) {
            self.exitBlock();
        }
    }];
}

- (NSArray *)findIdWithArray:(NSArray *)arr section:(NSInteger)section {
    static NSArray *array;
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj[@"id"] isEqualToString:currentArray[section][0][@"id"]]) {
            array = arr;
            *stop = YES;
        }
        else
        {
            [self findIdWithArray:obj[@"children"] section:section];
        }
    }];
    return array;
}

@end
