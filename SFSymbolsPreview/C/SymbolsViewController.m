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
#import "TextCell.h"

#import "SFSymbolDatasource.h"


@implementation UIImage( SharingImageExtension )

- (UIImage *)toSize:(CGSize)size
{
    UIImage *image = nil;
    {
        UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
        [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
        (image = UIGraphicsGetImageFromCurrentImageContext());
        UIGraphicsEndImageContext();
    }
    return image;
}

@end


@interface SymbolsViewController()
{
    dispatch_once_t _onceToken;
}

@end

@implementation SymbolsViewController

- (instancetype)initWithCategory:(SFSymbolCategory *)category
{
    if( [super init] )
    {
        [self setCategory:category];
        [self setTitle:NSLocalizedString([category.name isEqualToString:@"All"] ? @"SF Symbols" : category.name, nil)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setSymbolPreviewingStyle:SymbolpreviewingColletionStyle];
    
    [self.view setBackgroundColor:UIColor.systemBackgroundColor];
    [self.navigationController.navigationBar setPrefersLargeTitles:YES];
    
    [self.navigationItem setSearchController:({
        SymbolSearchResultsViewController *searchResultsVC = [SymbolSearchResultsViewController.alloc initWithCategory:self.category];
        UISearchController *searchController = [UISearchController.alloc initWithSearchResultsController:searchResultsVC];
        searchController.searchResultsUpdater = searchResultsVC;
        searchController.searchBar.placeholder = NSLocalizedString(@"Search", nil);
        searchController;
    })];
    [self.navigationItem setHidesSearchBarWhenScrolling:NO];
    
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
        [f setAllowsMultipleSelection:NO];
        [f setBackgroundColor:UIColor.clearColor];
        [f setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.view addSubview:f];
        [f.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
        [f.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
        [f.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
        [f.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
        [f registerClass:SymbolPreviewCell.class forCellWithReuseIdentifier:NSStringFromClass(SymbolPreviewCell.class)];
        [f registerClass:SymbolPreviewTableCell.class forCellWithReuseIdentifier:NSStringFromClass(SymbolPreviewTableCell.class)];
        (f);
    })];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.collectionView deselectItemAtIndexPath:self.collectionView.indexPathsForVisibleItems.firstObject animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if( [self isKindOfClass:SymbolsViewController.class] )
    {
        dispatch_once(&_onceToken, ^{
            [SFSymbolDatasource storeUserActivityLastOpenedCategory:self.category];
        });
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.category.symbols.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat itemWidth;
    
    if( self.symbolPreviewingStyle == SymbolpreviewingColletionStyle )
    {
//        itemWidth = (CGRectGetWidth(collectionView.bounds) - 48) / 2.0f;
        itemWidth = (CGRectGetWidth(collectionView.bounds) - 16 * 5) / 4.0f;
        return CGSizeMake(itemWidth, itemWidth * .68f + 64);
    }
    else
    {
        itemWidth = CGRectGetWidth(collectionView.bounds) - 32.0f;
        return CGSizeMake(itemWidth, 48);
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if( self.symbolPreviewingStyle == SymbolpreviewingColletionStyle )
    {
        SymbolPreviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(SymbolPreviewCell.class)
                                                                            forIndexPath:indexPath];
        [cell setSymbol:self.category.symbols[indexPath.row]];
        return cell;
    }
    else
    {
        SymbolPreviewTableCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(SymbolPreviewTableCell.class)
                                                                                 forIndexPath:indexPath];
        [cell setSymbol:self.category.symbols[indexPath.row]];
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *imageNamed = self.category.symbols[indexPath.item].name;
    
    UIImage *image;
    {
        CGRect imageRect = CGRectMake(0, 0, 512, 512);
        CGFloat scale = 3.0f;
        
        image = [UIImage systemImageNamed:imageNamed];
        image = [image toSize:CGSizeMake(imageRect.size.width, imageRect.size.width * image.size.height / image.size.width)];
        
        UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, scale);
        [image drawAtPoint:CGPointMake(CGRectGetMidX(imageRect) - image.size.width / 2.0f, CGRectGetMidY(imageRect) - image.size.height / 2.0f)];
        (image = UIGraphicsGetImageFromCurrentImageContext());
        UIGraphicsEndImageContext();
    }
    
    UIActivityViewController *activityViewController = [UIActivityViewController.alloc initWithActivityItems:@[ imageNamed, image ]
                                                                                       applicationActivities:nil];
    if( UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad )
    {
        activityViewController.popoverPresentationController.sourceView = [collectionView cellForItemAtIndexPath:indexPath];
        activityViewController.popoverPresentationController.sourceRect = activityViewController.popoverPresentationController.sourceView.bounds;
    }
    [self presentViewController:activityViewController animated:YES completion:nil];
}

@end
