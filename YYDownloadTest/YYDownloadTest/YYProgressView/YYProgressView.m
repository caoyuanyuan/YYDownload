//
//  YYProgressView.m
//  YYDownloadTest
//
//  Created by CaoYuanyuan on 2017/1/3.
//  Copyright © 2017年 cyy. All rights reserved.
//

#import "YYProgressView.h"

@interface YYProgressView ()

@property (nonatomic, weak) UIImageView *trackImageView;
@property (nonatomic, weak) UIImageView *progressImageView;

@end

@implementation YYProgressView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupProgressView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupProgressView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UIImageView *trackImageView = self.trackImageView;
    UIImageView *progressImageView = self.progressImageView;
    if (!trackImageView || !progressImageView) {
        return;
    }
    
    CGRect bounds = self.bounds;
    UIImage *trackImage = self.trackImage;
    CGFloat boundsTop = CGRectGetMinY(bounds);
    if (trackImage) {
        CGRect trackFrame = trackImageView.frame;
        CGFloat trackImageHeight = trackImage.size.height;
        trackImageView.frame = (CGRect){
            .origin.x = CGRectGetMinX(trackFrame),
            .origin.y = (boundsTop + ((CGRectGetHeight(bounds) - trackImageHeight)*0.5)),
            .size.width = trackFrame.size.width,
            .size.height = trackImageHeight
        };
    }
    
    UIImage *progressImage = self.progressImage;
    if (progressImage) {
        CGRect progressFrame = progressImageView.frame;
        CGFloat progressHeight = progressImage.size.height;
        progressImageView.frame = (CGRect){
            .origin.x = CGRectGetMinX(progressFrame),
            .origin.y = (boundsTop + ((CGRectGetHeight(bounds) - progressHeight)*0.5)),
            .size.width = progressFrame.size.width,
            .size.height = progressHeight
        };
    }
}

- (void)setProgressImage:(UIImage *)progressImage
{
    [super setProgressImage:progressImage];
    self.progressImageView.image = progressImage;
}

- (void)setTrackImage:(UIImage *)trackImage
{
    [super setTrackImage:trackImage];
    self.trackImageView.image = trackImage;
}

- (void)setupProgressView
{
    NSArray *subviews = self.subviews;
    if ([subviews count] != 2)
    {
        return;
    }
    
    for (UIView *subview in subviews)
    {
        if (![subview isKindOfClass:[UIImageView class]])
        {
            return;
        }
    }
    
    self.trackImageView = subviews[0];
    self.progressImageView = subviews[1];
    
    self.trackImageView.image = self.trackImage;
    self.progressImageView.image = self.progressImage;
}

@end
