//
//  SymbolSearchResultsViewController.m
//  SFSymbolsPreview
//
//  Created by YICAI YANG on 2020/5/27.
//  Copyright © 2020 YICAI YANG. All rights reserved.
//

#import "SymbolSearchResultsViewController.h"
#import "ReusableTitleView.h"


@interface SymbolSearchResultsViewController()

@property( nonatomic, strong ) SFSymbolCategory         *searchResult;

@end

@implementation SymbolSearchResultsViewController

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *text = [NSString stringWithFormat:@"%@", searchController.searchBar.text];
    UIColor *tintColor = self.view.tintColor;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        __block NSMutableArray<SFSymbol *> *searchResults = @[].mutableCopy;
        [self.category.symbols enumerateObjectsUsingBlock:^(SFSymbol *symbol, NSUInteger index, BOOL *stop){
            NSRange range = [symbol.name rangeOfString:text options:NSCaseInsensitiveSearch];
            if( range.location != NSNotFound )
            {
                NSMutableAttributedString *attributedName = [NSAttributedString.alloc initWithString:symbol.name attributes:@{
                    NSForegroundColorAttributeName: UIColor.labelColor,
                    NSFontAttributeName: [UIFont systemFontOfSize:15 weight:UIFontWeightRegular]
                }].mutableCopy;
                [attributedName setAttributes:@{
                    NSForegroundColorAttributeName: tintColor,
                    NSFontAttributeName: [UIFont systemFontOfSize:15 weight:UIFontWeightMedium]
                } range:range];
                
                [searchResults addObject:[SFSymbol symbolWithAttributedName:attributedName]];
            }
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setSearchResult:[SFSymbolCategory.alloc initWithSearchResultsCategoryWithSymbols:searchResults]];
            [self.collectionView reloadData];
        });
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view setBackgroundColor:UIColor.secondarySystemBackgroundColor];
    [self.collectionView setKeyboardDismissMode:UIScrollViewKeyboardDismissModeOnDrag];
    [self.collectionView registerClass:ReusableTitleView.class
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:NSStringFromClass(ReusableTitleView.class)];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.searchResult.symbols.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(CGRectGetWidth(collectionView.bounds), 36);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if( kind == UICollectionElementKindSectionHeader )
    {
        ReusableTitleView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                     withReuseIdentifier:NSStringFromClass(ReusableTitleView.class)
                                                                            forIndexPath:indexPath];
        view.title = [NSString stringWithFormat:@"%@: %ld", NSLocalizedString(@"RESULTS", nil), self.searchResult.symbols.count];
        return view;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat itemWidth;
    
    if( self.numberOfItemInColumn > 1 )
    {
        itemWidth = (CGRectGetWidth(collectionView.bounds) - 16 * (self.numberOfItemInColumn + 1)) / self.numberOfItemInColumn;
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
    if( self.numberOfItemInColumn > 1 )
    {
        SymbolPreviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(SymbolPreviewCell.class)
                                                                            forIndexPath:indexPath];
        [cell setSymbol:self.searchResult.symbols[indexPath.item]];
        return cell;
    }
    else
    {
        SymbolPreviewTableCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(SymbolPreviewTableCell.class)
                                                                                 forIndexPath:indexPath];
        [cell setSymbol:self.searchResult.symbols[indexPath.item]];
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    return [self.navigationC pushViewController:UIViewController.new animated:YES];
    
    NSString *imageNamed = self.searchResult.symbols[indexPath.item].name;
    
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
