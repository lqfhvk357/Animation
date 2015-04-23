//
//  LCViewController.m
//  Animation
//
//  Created by Mac on 14-10-22.
//  Copyright (c) 2014年 chao. All rights reserved.
//

#import "LCViewController.h"

@interface LCViewController ()
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, assign) int index;

@end


@implementation LCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:self.view.bounds];
	imageView.contentMode=UIViewContentModeScaleAspectFill;
    imageView.image=[UIImage imageNamed:@"0000.jpg"];
    self.index=0;
    [self.view addSubview:imageView];
    self.imageView=imageView;
    
    UISwipeGestureRecognizer *left=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft)];
    left.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:left];
    
    UISwipeGestureRecognizer *right=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight)];
    right.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:right];
    
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}

- (void)nextImage
{
    
}

- (void)swipeLeft
{
    [self swipeAnimation:1];
}

- (void)swipeRight
{
    [self swipeAnimation:-1];
}

- (void)swipeAnimation:(int)n
{
    //设置转场动画
    CATransition *transition=[[CATransition alloc] init];
    
    //转场动画效果：cube, oglFlip, suckEffect, pageCurl, pageUnCurl, rippleEffect, moveIn, reveal
    transition.type=@"cube";
    transition.duration=1.0f;
    transition.subtype=n>0 ? kCATransitionFromRight : kCATransitionFromLeft;
    
    self.index=(self.index+n+COUNT)%COUNT;
    self.imageView.image=[UIImage imageNamed:[[NSString stringWithFormat:@"000%d",self.index] stringByAppendingString:@".jpg"]];
    
    //添加转场动画
    [self.imageView.layer addAnimation:transition forKey:@"kCATransitionAnimation"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
