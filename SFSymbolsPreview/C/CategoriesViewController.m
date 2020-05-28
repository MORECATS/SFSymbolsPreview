//
//  CategoriesViewController.m
//  SFSymbolsPreview
//
//  Created by YICAI YANG on 2020/5/28.
//  Copyright © 2020 YICAI YANG. All rights reserved.
//

#import "CategoriesViewController.h"
#import "SymbolsViewController.h"
#import "SFSymbolCategory.h"


@interface CategoriesViewController()<UITableViewDelegate, UITableViewDataSource>

@property( nonatomic, strong ) NSArray<SFSymbolCategory *>          *categories;

@property( nonatomic, strong ) UITableView                          *tableView;

@end

@implementation CategoriesViewController

- (NSArray<SFSymbolCategory *> *)categories
{
    if( _categories == nil )
    {
        _categories = @[ [SFSymbolCategory.alloc initWithCategoryName:@"All"],
                         [SFSymbolCategory.alloc initWithCategoryName:@"Communication"],
                         [SFSymbolCategory.alloc initWithCategoryName:@"Weather"],
                         [SFSymbolCategory.alloc initWithCategoryName:@"Object & Tools"],
                         [SFSymbolCategory.alloc initWithCategoryName:@"Devices"],
                         [SFSymbolCategory.alloc initWithCategoryName:@"Connectivity"],
                         [SFSymbolCategory.alloc initWithCategoryName:@"Transportation"],
                         [SFSymbolCategory.alloc initWithCategoryName:@"Human"],
                         [SFSymbolCategory.alloc initWithCategoryName:@"Nature"],
                         [SFSymbolCategory.alloc initWithCategoryName:@"Editing"],
                         [SFSymbolCategory.alloc initWithCategoryName:@"Text Formatting"],
                         [SFSymbolCategory.alloc initWithCategoryName:@"Media"],
                         [SFSymbolCategory.alloc initWithCategoryName:@"Keyboard"],
                         [SFSymbolCategory.alloc initWithCategoryName:@"Commerce"],
                         [SFSymbolCategory.alloc initWithCategoryName:@"Time"],
                         [SFSymbolCategory.alloc initWithCategoryName:@"Health"],
                         [SFSymbolCategory.alloc initWithCategoryName:@"Shapes"],
                         [SFSymbolCategory.alloc initWithCategoryName:@"Arrows"],
                         [SFSymbolCategory.alloc initWithCategoryName:@"Indices"],
                         [SFSymbolCategory.alloc initWithCategoryName:@"Math"] ];
    }
    return _categories;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:NSLocalizedString(@"Categories", nil)];
    [self.view setBackgroundColor:UIColor.systemBackgroundColor];
    [self.navigationController.navigationBar setPrefersLargeTitles:YES];
    
    [self setTableView:({
        UITableView *f = [UITableView.alloc initWithFrame:CGRectZero style:UITableViewStylePlain];
        [f setDelegate:self];
        [f setDataSource:self];
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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categories.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 52.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class)];
    
    [cell.textLabel setText:self.categories[indexPath.row].name];
    [cell.textLabel setFont:[UIFont systemFontOfSize:20 weight:UIFontWeightRegular]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController pushViewController:[SymbolsViewController.alloc initWithCategory:self.categories[indexPath.row]] animated:YES];
}

@end
