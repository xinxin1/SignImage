//
//  SignViewController.m
//  PDF
//
//  Created by valiant on 2019/11/26.
//  Copyright © 2019 xin. All rights reserved.
//

#import "SignViewController.h"
#import <objc/runtime.h>

@interface SignViewController ()

@end

@implementation SignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.drawLayer = [CAShapeLayer layer];
    [self.signView initMyView];
}


- (IBAction)clearAction:(id)sender {
    [self.signView cleanAction];
}
- (IBAction)downAction:(id)sender {
    self.drawLayer.path = self.signView.bezier.CGPath;

    UIImage *newImage = [self getImagewithBezierPath:self.signView.bezier];
    
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.handler) {
            self.handler(newImage);
        }
    }];
}

- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)colorChangeAction:(id)sender {
    switch ([sender selectedSegmentIndex]) {
        case 0:
            self.signView.color = [UIColor redColor];
            break;
        case 1:
            self.signView.color = [UIColor greenColor];
            break;
        case 2:
            self.signView.color = [UIColor blueColor];
            break;
            
        default:
            break;
    }
}

// 根据绘制一个图片
- (UIImage *)getImagewithBezierPath:(UIBezierPath *)path{
//    // 声明一个绘制
//    UIGraphicsBeginImageContext(path.bounds.size);
//    // 获取上下文对象
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    // 绘制
//    CGContextAddPath(context, path.CGPath);
//    // 设置填充颜色
//    CGContextSetFillColorWithColor(context, [UIColor colorWithWhite:0 alpha:0].CGColor);
//    CGContextFillRect(context, path.bounds);
//
////    [[UIColor redColor] setStroke];
//    [path stroke];
//    // 声明UIImage对象
//    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    
    
    //开启一个图片上下文.设置较大背景(苹果不允许修改bounds属性)
     CGSize tsize = CGSizeMake(CGRectGetMaxX(path.bounds), CGRectGetMaxY(path.bounds));
     UIGraphicsBeginImageContext(tsize);
    //设置一个透明的颜色
    UIColor * color = [UIColor clearColor];
    //使用上面设置的颜色进行填充.
    [color setFill];
     // 获取上下文对象
     CGContextRef context = UIGraphicsGetCurrentContext();
     // 绘制
     CGContextAddPath(context, path.CGPath);
     [[UIColor redColor] setStroke];
     [self.signView.bezier stroke];
    //从图片上下文中获取图片.
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
     
     
     CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, path.bounds);
     UIGraphicsBeginImageContext(path.bounds.size);
     CGContextRef context2 = UIGraphicsGetCurrentContext();
     CGContextDrawImage(context2, path.bounds, subImageRef);
     image = [UIImage imageWithCGImage:subImageRef];
     UIGraphicsEndImageContext();
     CGImageRelease(subImageRef);
     
     
     
    //设置图片的存储路径.
//    NSString * filepath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/1.png"];
    //将图片转换为png格式的数据,并且写入到后面的路径内.
//    [UIImagePNGRepresentation(image) writeToFile:filepath atomically:YES];
    //关闭图片上下文,否则会造成内存泄露.
    UIGraphicsEndImageContext();
    
    return image;
}
//获取一张PNG格式的透明图片.
 - (void)getClearColorPNGImage {
    //开启一个图片上下文.设置较大背景(苹果不允许修改bounds属性)
     CGSize tsize = CGSizeMake(CGRectGetMaxX(self.signView.bezier.bounds), CGRectGetMaxY(self.signView.bezier.bounds));
     UIGraphicsBeginImageContext(tsize);
    //设置一个透明的颜色
    UIColor * color = [UIColor clearColor];
    //使用上面设置的颜色进行填充.
    [color setFill];
     // 获取上下文对象
     CGContextRef context = UIGraphicsGetCurrentContext();
     // 绘制
     CGContextAddPath(context, self.signView.bezier.CGPath);
     [[UIColor redColor] setStroke];
     [self.signView.bezier stroke];
    //从图片上下文中获取图片.
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
     
     
     CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, self.signView.bezier.bounds);
     UIGraphicsBeginImageContext(self.signView.bezier.bounds.size);
     CGContextRef context2 = UIGraphicsGetCurrentContext();
     CGContextDrawImage(context2, self.signView.bezier.bounds, subImageRef);
     image = [UIImage imageWithCGImage:subImageRef];
     UIGraphicsEndImageContext();
     CGImageRelease(subImageRef);
     
     
     
    //设置图片的存储路径.
    NSString * path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/1.png"];
    //将图片转换为png格式的数据,并且写入到后面的路径内.
    [UIImagePNGRepresentation(image) writeToFile:path atomically:YES];
    //关闭图片上下文,否则会造成内存泄露.
    UIGraphicsEndImageContext();
}






@end
