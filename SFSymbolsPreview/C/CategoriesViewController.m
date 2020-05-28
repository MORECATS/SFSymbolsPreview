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
        _categories = @[ [SFSymbolCategory.alloc initWithCategoryName:@"All" imageNamed:@"square.grid.2x2.fill"],
                         [SFSymbolCategory.alloc initWithCategoryName:@"Communication" imageNamed:@"message"],
                         [SFSymbolCategory.alloc initWithCategoryName:@"Weather" imageNamed:@"cloud.sun"],
                         [SFSymbolCategory.alloc initWithCategoryName:@"Object & Tools" imageNamed:@"folder"],
                         [SFSymbolCategory.alloc initWithCategoryName:@"Devices" imageNamed:@"desktopcomputer"],
                         [SFSymbolCategory.alloc initWithCategoryName:@"Connectivity" imageNamed:@"antenna.radiowaves.left.and.right"],
                         [SFSymbolCategory.alloc initWithCategoryName:@"Transportation" imageNamed:@"car.fill"],
                         [SFSymbolCategory.alloc initWithCategoryName:@"Human" imageNamed:@"person.crop.circle"],
                         [SFSymbolCategory.alloc initWithCategoryName:@"Nature" imageNamed:@"flame"],
                         [SFSymbolCategory.alloc initWithCategoryName:@"Editing" imageNamed:@"slider.horizontal.3"],
                         [SFSymbolCategory.alloc initWithCategoryName:@"Text Formatting" imageNamed:@"textformat"],
                         [SFSymbolCategory.alloc initWithCategoryName:@"Media" imageNamed:@"playpause"],
                         [SFSymbolCategory.alloc initWithCategoryName:@"Keyboard" imageNamed:@"command"],
                         [SFSymbolCategory.alloc initWithCategoryName:@"Commerce" imageNamed:@"cart"],
                         [SFSymbolCategory.alloc initWithCategoryName:@"Time" imageNamed:@"timer"],
                         [SFSymbolCategory.alloc initWithCategoryName:@"Health" imageNamed:@"staroflife"],
                         [SFSymbolCategory.alloc initWithCategoryName:@"Shapes" imageNamed:@"square.on.circle"],
                         [SFSymbolCategory.alloc initWithCategoryName:@"Arrows" imageNamed:@"arrow.right"],
                         [SFSymbolCategory.alloc initWithCategoryName:@"Indices" imageNamed:@"a.circle"],
                         [SFSymbolCategory.alloc initWithCategoryName:@"Math" imageNamed:@"x.squareroot"] ];
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
    [cell.imageView setImage:[UIImage systemImageNamed:self.categories[indexPath.row].imageNamed]];
    [cell.imageView setTintColor:cell.textLabel.textColor];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController pushViewController:[SymbolsViewController.alloc initWithCategory:self.categories[indexPath.row]] animated:YES];
}

@end
