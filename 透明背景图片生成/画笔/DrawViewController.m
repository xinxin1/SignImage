//
//  DrawViewController.m
//  PDF
//
//  Created by valiant on 2019/11/26.
//  Copyright © 2019 xin. All rights reserved.
//

#import "DrawViewController.h"
#import "SignViewController.h"

@interface DrawViewController ()
@property (nonatomic, strong) UIImageView *sourceImageView;

@end

@implementation DrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}


#pragma mark - View
- (void)setupView {
    self.view.backgroundColor = [UIColor blackColor];
    
    self.sourceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 100, 300, 500)];
    self.sourceImageView.image = [UIImage imageNamed:@"1"];
    [self.view addSubview:self.sourceImageView];
    self.sourceImageView.backgroundColor = [UIColor cyanColor];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    SignViewController *vc = [[SignViewController alloc] init];
    vc.modalPresentationStyle = 0;
    vc.handler = ^(UIImage * _Nonnull backImage) {
        UIImageView *addIv = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, backImage.size.width, backImage.size.height)];
        addIv.image = backImage;
        [self.sourceImageView addSubview:addIv];
    };
    [self presentViewController:vc animated:YES completion:nil];
}


@end
