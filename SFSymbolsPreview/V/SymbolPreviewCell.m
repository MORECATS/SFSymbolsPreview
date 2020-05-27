//
//  SymbolPreviewCell.m
//  SFSymbolsPreview
//
//  Created by YICAI YANG on 2020/5/27.
//  Copyright © 2020 YICAI YANG. All rights reserved.
//

#import "SymbolPreviewCell.h"


@interface SymbolPreviewCell()

@property( nonatomic, strong ) UIImageView                      *imageView;
@property( nonatomic, strong ) UILabel                          *textLabel;

@end

@implementation SymbolPreviewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if( [super initWithFrame:frame] )
    {
        [self setImageView:({
            UIImageView *f = [UIImageView.alloc initWithImage:[UIImage systemImageNamed:@"paperplane.fill"]];
            [f setContentMode:UIViewContentModeScaleAspectFit];
            [f.layer setCornerRadius:4.0f];
            [f.layer setBorderWidth:1.0f];
            [f.layer setBorderColor:UIColor.separatorColor.CGColor];
            [self.contentView addSubview:f];
            [f setTranslatesAutoresizingMaskIntoConstraints:NO];
            [f.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
            [f.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor].active = YES;
            [f.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;
            [f.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-44.0f].active = YES;
            f;
        })];
    }
    return self;
}

@end
