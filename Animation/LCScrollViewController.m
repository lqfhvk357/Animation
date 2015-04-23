//
//  LCScrollViewController.m
//  Animation
//
//  Created by Mac on 14-10-22.
//  Copyright (c) 2014年 chao. All rights reserved.
//

#import "LCScrollViewController.h"

@interface LCScrollViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation LCScrollViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIScrollView *scrollView=[[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.delegate=self;
    
    scrollView.contentSize=CGSizeMake(self.view.width * (2+COUNT), 0);
    scrollView.ScrollEnabled=YES;
    scrollView.PagingEnabled=YES;
    [self.view addSubview:scrollView];
    self.scrollView=scrollView;
    
    //(i+COUNT)%COUNT
    UIImageView *imageViewFrist=[[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"0006.jpg"]]];
    [scrollView addSubview:imageViewFrist];
    imageViewFrist.frame=CGRectMake(0, 0, self.view.width, self.view.height);
    
    
    UIImageView *imageViewEnd=[[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"0000.jpg"]]];
    [scrollView addSubview:imageViewEnd];
    imageViewEnd.frame=CGRectMake(self.view.width*(COUNT+1), 0, self.view.width, self.view.height);
    
    
    for (int i=0; i<COUNT; i++) {
        
        UIImageView *imageView=[[UIImageView alloc] init];
        imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"000%d.jpg", i]];
        
        [scrollView addSubview:imageView];
        imageView.frame=CGRectMake((i+1)*self.view.width, 0, self.view.width, self.view.height);
    }
    
    [scrollView setContentOffset:CGPointMake(self.view.width, 0)];
    
    
    [self addTimer];
    
}

- (void)addTimer
{
    self.timer=[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];

}

- (void)nextImage
{
    int i=self.scrollView.contentOffset.x / self.view.width;
    
    [self.scrollView setContentOffset:CGPointMake((i+1)*self.view.width, 0) animated:YES];
    
    [self scrollViewDidEndDecelerating:self.scrollView];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x==self.view.width*(COUNT+1)) {
        [scrollView setContentOffset:CGPointMake(self.view.width, 0)] ;
    }
    
    if (scrollView.contentOffset.x==0) {
        [scrollView setContentOffset:CGPointMake(self.view.width*COUNT, 0)] ;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{

    [self addTimer];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
    self.timer=nil;
}
@end
