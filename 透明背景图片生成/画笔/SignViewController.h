//
//  SignViewController.h
//  PDF
//
//  Created by valiant on 2019/11/26.
//  Copyright © 2019 xin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SignViewController : UIViewController
@property (weak, nonatomic) IBOutlet SignView *signView;
@property (nonatomic, strong) CAShapeLayer *drawLayer;
@property (nonatomic, copy) void ((^handler)(UIImage *backImage));
@end

NS_ASSUME_NONNULL_END
