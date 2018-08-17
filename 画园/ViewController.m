//
//  ViewController.m
//  画园
//
//  Created by caimengnan on 2018/7/31.
//  Copyright © 2018年 frameworkdemo. All rights reserved.
//

#import "ViewController.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) CAShapeLayer *circleLayer;
@property (nonatomic,strong) UIBezierPath *path;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIImageView *imageView1;
@property (nonatomic,strong) UIImageView *imageView2;
@property (nonatomic,assign) CGPoint centerPoint;
@property (nonatomic,assign) CGFloat radius;
@end

@implementation ViewController

- (CAShapeLayer *)circleLayer {
    if (!_circleLayer) {
        _circleLayer = [CAShapeLayer layer];
        _circleLayer.frame = self.imageView1.bounds;
        self.path = [UIBezierPath bezierPathWithOvalInRect:(CGRectMake(0, 0, 0, 0))];
        _circleLayer.path = self.path.CGPath;
    }
    return _circleLayer;
}


- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:(CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height))];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 2);
    }
    return _scrollView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];
    [self setUpUI];
}


- (void)setUpUI {
    
    _imageView1 = [[UIImageView alloc]initWithFrame:(CGRectMake(0, 400, kWidth, 200))];
    _imageView1.image = [UIImage imageNamed:@"123.jpg"];
    self.imageView1 = _imageView1;
    
    _imageView2 = [[UIImageView alloc]initWithFrame:(CGRectMake(0, 400, kWidth, 200))];
    _imageView2.image = [UIImage imageNamed:@"456.jpg"];
    self.imageView2 = _imageView2;
    
    [self.scrollView addSubview:self.imageView1];
    [self.scrollView addSubview:self.imageView2];
    [self.scrollView insertSubview:self.imageView1 belowSubview:self.imageView2];
    
    self.imageView2.layer.mask = self.circleLayer;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //圆心 （图片的中心点）
    CGPoint center = CGPointMake(300, 100);
    //半径
    CGFloat radius = scrollView.contentOffset.y;
    
    if (radius < 0) {
        return;
    }
    
    self.path = [UIBezierPath bezierPathWithOvalInRect:(CGRectMake(center.x - radius, center.y - radius, radius * 2, radius * 2))];
    _circleLayer.path = self.path.CGPath;
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
