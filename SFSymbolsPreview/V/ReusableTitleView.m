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
            [f setTextColor:UIColor.secondaryLabelColor];
            [f setFont:[UIFont systemFontOfSize:13 weight:UIFontWeightRegular]];
            [self addSubview:f];
            [f setTranslatesAutoresizingMaskIntoConstraints:NO];
            [f.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:16].active = YES;
            [f.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
            f;
        })];
    }
    return self;
}

@end
