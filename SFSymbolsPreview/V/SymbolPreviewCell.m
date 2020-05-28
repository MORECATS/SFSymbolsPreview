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

- (void)setSymbol:(SFSymbol *)symbol
{
    _symbol = symbol;
    
    self.imageView.image = [UIImage systemImageNamed:symbol.name];
    self.textLabel.text = symbol.name;
}

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
        [self setTextLabel:({
            UILabel *f = UILabel.new;
            [f setTextAlignment:NSTextAlignmentCenter];
            [f setFont:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium]];
            [f setNumberOfLines:0];
            [self.contentView addSubview:f];
            [f setTranslatesAutoresizingMaskIntoConstraints:NO];
            [f.topAnchor constraintEqualToAnchor:self.imageView.bottomAnchor constant:4.0f].active = YES;
            [f.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor constant:-8.0f].active = YES;
            [f.centerXAnchor constraintEqualToAnchor:self.imageView.centerXAnchor].active = YES;
            f;
        })];
    }
    return self;
}

@end
