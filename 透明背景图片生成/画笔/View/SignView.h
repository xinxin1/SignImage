//
//  SignView.h
//  PDF
//
//  Created by valiant on 2019/11/26.
//  Copyright © 2019 xin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SignView : UIView
//用来设置线条的颜色
@property (nonatomic, strong) UIColor *color;
//用来设置线条的宽度
@property (nonatomic, assign) CGFloat lineWidth;
//用来记录已有线条
@property (nonatomic, strong) NSMutableArray *allLine;
//声明贝塞尔曲线
@property(nonatomic, strong) UIBezierPath *bezier;

//初始化相关参数
-(void)initMyView;
//Clear操作
- (void)cleanAction;
//unDo操作
-(void)backImage;
//reDo操作
-(void)forwardImage;
@end

NS_ASSUME_NONNULL_END
