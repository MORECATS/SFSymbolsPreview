//
//  TextCell.m
//  SFSymbolsPreview
//
//  Created by YICAI YANG on 2020/5/27.
//  Copyright © 2020 YICAI YANG. All rights reserved.
//

#import "TextCell.h"


@interface TextCell()

@property( nonatomic, strong ) UIImageView                  *accessoryImageView;

@end

@implementation TextCell

- (void)drawRect:(CGRect)rect
{
    // Draw Separator
    {
        [UIColor.separatorColor setStroke];
        
        CGFloat physicalPixelHeight = 1.0 / UIScreen.mainScreen.scale;
        
        UIBezierPath *path = UIBezierPath.bezierPath;
        [path moveToPoint:CGPointMake(CGRectGetMinX(rect), CGRectGetHeight(rect) - physicalPixelHeight)];
        [path addLineToPoint:CGPointMake(CGRectGetMaxX(rect), CGRectGetHeight(rect) - physicalPixelHeight)];
        [path setLineWidth:physicalPixelHeight];
        [path stroke];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if( [super initWithFrame:frame] )
    {
        [self setBackgroundColor:UIColor.clearColor];
        
        [self setTextLabel:({
            UILabel *f = UILabel.new;
            [f setFont:[UIFont systemFontOfSize:20 weight:UIFontWeightRegular]];
            [f setTextColor:self.tintColor];
            [self.contentView addSubview:f];
            [f setTranslatesAutoresizingMaskIntoConstraints:NO];
            [f.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
            [f.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
            f;
        })];
        
        [self setAccessoryImageView:({
            UIImageView *f = UIImageView.new;
            [self.contentView addSubview:f];
            [f setTranslatesAutoresizingMaskIntoConstraints:NO];
            [f.widthAnchor constraintEqualToConstant:44.0f].active = YES;
            [f.heightAnchor constraintEqualToConstant:44.0f].active = YES;
            [f.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor].active = YES;
            [f.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor].active = YES;
            f;
        })];
    }
    return self;
}

@end
