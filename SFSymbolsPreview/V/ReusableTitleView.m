//
//  ReusableTitleView.m
//  SFSymbolsPreview
//
//  Created by YICAI YANG on 2020/5/27.
//  Copyright © 2020 YICAI YANG. All rights reserved.
//

#import "ReusableTitleView.h"


@interface ReusableTitleView()

@property( nonatomic, strong ) UILabel                  *titleLabel;

@end

@implementation ReusableTitleView

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if( [super initWithFrame:frame] )
    {
        [self setTitleLabel:({
            UILabel *f = UILabel.new;
            [f setTextColor:self.tintColor];
            [f setFont:[UIFont systemFontOfSize:12.5f weight:UIFontWeightBlack]];
            [self addSubview:f];
            [f setTranslatesAutoresizingMaskIntoConstraints:NO];
            [f.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:16].active = YES;
            [f.centerYAnchor constraintEqualToAnchor:self.centerYAnchor constant:2.0f].active = YES;
            f;
        })];
    }
    return self;
}

@end
