//
//  SymbolDetailsViewController.m
//  SFSymbolsPreview
//
//  Created by YICAI YANG on 2020/5/30.
//  Copyright © 2020 YICAI YANG. All rights reserved.
//

#import "SymbolDetailsViewController.h"
#import "SFSymbolDatasource.h"


@interface SymbolDetailsViewController()<UITableViewDelegate, UITableViewDataSource>

@property( nonatomic, strong ) SFSymbol                     *symbol;

@property( nonatomic, strong ) UIImageView                  *imageView;
@property( nonatomic, strong ) UITableView                  *tableView;

@end

@implementation SymbolDetailsViewController

- (instancetype)initWithSymbol:(SFSymbol *)symbol
{
    if( [super init] )
    {
        [self setSymbol:symbol];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:NSLocalizedString(@"Details", nil)];
    [self.view setBackgroundColor:UIColor.systemBackgroundColor];
    [self.navigationController.navigationBar setPrefersLargeTitles:YES];
    
    [self.navigationItem setLargeTitleDisplayMode:UINavigationItemLargeTitleDisplayModeNever];
    
    [self setTableView:({
        UITableView *f = [UITableView.alloc initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self setImageView:UIImageView.new];
        [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [f setTableHeaderView:self.imageView];
        [f setDelegate:self];
        [f setDataSource:self];
        [f setRowHeight:UITableViewAutomaticDimension];
        [f setTableFooterView:UIView.new];
        [self.view addSubview:f];
        [f setTranslatesAutoresizingMaskIntoConstraints:NO];
        [f.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
        [f.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
        [f.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
        [f.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
        [f registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
        f;
    })];
    
    NSString *imageNamed = self.symbol.name;

    UIImage *image;
    {
        CGRect imageRect = CGRectMake(0, 0, 512, 512);
        CGRect contentRect = CGRectInset(imageRect, 88, 88);
        CGFloat scale = 3.0f;
        
        image = [UIImage systemImageNamed:imageNamed];
        image = [image toSize:CGSizeMake(contentRect.size.width, contentRect.size.width * image.size.height / image.size.width)];

        UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, scale);
        [image drawAtPoint:CGPointMake(CGRectGetMidX(imageRect) - image.size.width / 2.0f, CGRectGetMidY(imageRect) - image.size.height / 2.0f)];
        (image = UIGraphicsGetImageFromCurrentImageContext());
        UIGraphicsEndImageContext();
    }
    self.imageView.image = image;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.imageView setFrame:CGRectMake(0, 0, 0, CGRectGetWidth(self.tableView.bounds))];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class)];
 
    if( indexPath.row == 0 )
    {
        [cell.textLabel setText:[[NSLocalizedString(@"Copy", nil) stringByAppendingString:@" "] stringByAppendingString:self.symbol.name]];
        [cell.textLabel setNumberOfLines:0];
        [cell.textLabel setTextColor:self.view.tintColor];
        [cell.textLabel setFont:[UIFont systemFontOfSize:20 weight:UIFontWeightRegular]];
        [cell.imageView setImage:[UIImage systemImageNamed:@"doc.on.doc"]];
        [cell.imageView setTintColor:self.view.tintColor];
    }
    else
    {
        [cell.textLabel setText:NSLocalizedString(@"Share", nil)];
        [cell.textLabel setTextColor:self.view.tintColor];
        [cell.textLabel setFont:[UIFont systemFontOfSize:20 weight:UIFontWeightRegular]];
        [cell.imageView setImage:[UIImage systemImageNamed:@"square.and.arrow.up"]];
        [cell.imageView setTintColor:self.view.tintColor];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( indexPath.row == 0 )
    {
        UIPasteboard.generalPasteboard.string = self.symbol.name;
    }
    else if( indexPath.row == 1 )
    {
        UIActivityViewController *activityVC = [UIActivityViewController.alloc initWithActivityItems:@[ self.symbol.name, self.imageView.image ]
                                                                               applicationActivities:nil];
        if( UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad )
        {
            activityVC.popoverPresentationController.sourceView = [tableView cellForRowAtIndexPath:indexPath];
            activityVC.popoverPresentationController.sourceRect = activityVC.popoverPresentationController.sourceView.bounds;
        }
        [self presentViewController:activityVC animated:YES completion:nil];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
