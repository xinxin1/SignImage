//
//  SignView.m
//  PDF
//
//  Created by valiant on 2019/11/26.
//  Copyright © 201xin. All rights reserved.
//

#import "SignView.h"

@interface SignView ()
//存储Undo出来的线条
@property(nonatomic, strong) NSMutableArray *cancleArray;
@end

@implementation SignView

//进行一些初始化工作
-(void)initMyView
{
    self.color = [UIColor redColor];
    self.lineWidth = 1;
    self.allLine = [NSMutableArray arrayWithCapacity:50];
    self.cancleArray = [NSMutableArray arrayWithCapacity:50];
}

//Clear操作
- (void)cleanAction {
    [self.cancleArray removeAllObjects];
    [self.allLine removeAllObjects];
    [self setNeedsDisplay];
}
//UnDo操作
 -(void)backImage
 {
     if (self.allLine.count > 0)
     {
         int index = (int)self.allLine.count - 1;
         [self.cancleArray addObject:self.allLine[index]];
         [self.allLine removeObjectAtIndex:index];
         [self setNeedsDisplay];
   }
}

//ReDo操作
-(void)forwardImage
{
    if (self.cancleArray.count > 0)
    {
        int index = (int)self.cancleArray.count - 1;
        [self.allLine addObject:self.cancleArray[index]];
        [self.cancleArray removeObjectAtIndex:index];
        [self setNeedsDisplay];
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
 {
    //新建贝塞斯曲线
     if (!self.bezier) {
         self.bezier = [UIBezierPath bezierPath];
     }
    //获取触摸的点
    UITouch *myTouche = [touches anyObject];
    CGPoint point = [myTouche locationInView:self];
    //把刚触摸的点设置为bezier的起点
    [self.bezier moveToPoint:point];
    //把每条线存入字典中
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithCapacity:3];
    [tempDic setObject:self.color forKey:@"color"];
    [tempDic setObject:[NSNumber numberWithFloat:self.lineWidth] forKey:@"lineWidth"];
    [tempDic setObject:self.bezier forKey:@"line"];
    //把线加入数组中
    [self.allLine addObject:tempDic];
}


 -(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
 {
     UITouch *myTouche = [touches anyObject];
     CGPoint point = [myTouche locationInView:self];
     [self.bezier addLineToPoint:point];
     //重绘界面
     [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect
 {
     //对之前的线的一个重绘过程
     for (int i = 0; i < self.allLine.count; i ++)
     {
         NSDictionary *tempDic = self.allLine[i];
         UIColor *color = tempDic[@"color"];
       CGFloat width = [tempDic[@"lineWidth"] floatValue];
        UIBezierPath *path = tempDic[@"line"];

       [color setStroke];
       [path setLineWidth:width];
       [path stroke];
   }
}

@end
