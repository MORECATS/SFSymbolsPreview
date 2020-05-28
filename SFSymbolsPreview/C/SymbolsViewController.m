//
//  SymbolsViewController.m
//  SFSymbolsPreview
//
//  Created by YICAI YANG on 2020/5/27.
//  Copyright © 2020 YICAI YANG. All rights reserved.
//

#import "SymbolSearchResultsViewController.h"
#import "SymbolsViewController.h"

#import "ReusableTitleView.h"
#import "SymbolPreviewCell.h"
#import "TextCell.h"

#import "SFSymbol.h"


@interface SymbolsViewController()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property( nonatomic, strong ) NSString                             *category;
@property( nonatomic, strong ) NSArray<SFSymbol *>                  *symbols;

@property( nonatomic, strong ) UICollectionView                     *collectionView;

@end

@implementation SymbolsViewController

- (instancetype)initWithCategory:(NSString *)category
{
    if( [super init] )
    {
        [self setCategory:category];
        [self setTitle:NSLocalizedString([category isEqualToString:@"All"] ? @"SF Symbols" : category, nil)];
    }
    return self;
}

- (NSArray<SFSymbol *> *)symbols
{
    if( _symbols == nil )
    {
        __block NSMutableArray<SFSymbol *> *symbolsPool = @[].mutableCopy;
        NSArray<NSString *> *symbolNames = [NSArray arrayWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"SFSymbol.All" ofType:@"plist"]];
        [symbolNames enumerateObjectsUsingBlock:^(NSString *name, NSUInteger index, BOOL *stop){
            [symbolsPool addObject:[SFSymbol symbolWithName:name]];
        }];
        _symbols = (NSArray *)symbolsPool;
    }
    return _symbols;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:UIColor.systemBackgroundColor];
    [self.navigationController.navigationBar setPrefersLargeTitles:YES];
    [self.navigationController.navigationItem setHidesSearchBarWhenScrolling:NO];
    [self.navigationController.navigationItem setSearchController:[UISearchController.alloc initWithSearchResultsController:({
        SymbolSearchResultsViewController.new;
    })]];
    
    [self setCollectionView:({
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout.alloc init];
        [layout setMinimumLineSpacing:16];
        [layout setMinimumInteritemSpacing:16];
        [layout setSectionInset:UIEdgeInsetsMake(16, 16, 16, 16)];
        
        UICollectionView *f = [UICollectionView.alloc initWithFrame:CGRectZero collectionViewLayout:layout];
        [f setDelegate:self];
        [f setDataSource:self];
        [f setAlwaysBounceVertical:YES];
        [f setAlwaysBounceHorizontal:NO];
        [f setShowsVerticalScrollIndicator:YES];
        [f setShowsHorizontalScrollIndicator:NO];
        [f setAllowsMultipleSelection:YES];
        [f setBackgroundColor:UIColor.clearColor];
        [f setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.view addSubview:f];
        [f.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
        [f.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
        [f.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
        [f.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
        [f registerClass:ReusableTitleView.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
     withReuseIdentifier:NSStringFromClass(ReusableTitleView.class)];
        [f registerClass:TextCell.class forCellWithReuseIdentifier:NSStringFromClass(TextCell.class)];
        [f registerClass:SymbolPreviewCell.class forCellWithReuseIdentifier:NSStringFromClass(SymbolPreviewCell.class)];
        (f);
    })];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.collectionView deselectItemAtIndexPath:self.collectionView.indexPathsForVisibleItems.firstObject animated:YES];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.symbols.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat itemWidth = (CGRectGetWidth(collectionView.bounds) - 48) / 2.0f;
    return CGSizeMake(itemWidth, itemWidth * .7f + 48);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SymbolPreviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(SymbolPreviewCell.class)
                                                                        forIndexPath:indexPath];
    [cell setSymbol:self.symbols[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
