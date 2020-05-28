//
//  SceneDelegate.m
//  SFSymbolsPreview
//
//  Created by YICAI YANG on 2020/5/27.
//  Copyright © 2020 YICAI YANG. All rights reserved.
//

#import "SceneDelegate.h"

#import "CategoriesViewController.h"
#import "SymbolsViewController.h"
#import "SFSymbolDatasource.h"


@interface SceneDelegate()

@end

@implementation SceneDelegate

- (UIWindow *)window
{
    if( _window == nil )
    {
        _window = [UIWindow.alloc initWithFrame:UIScreen.mainScreen.bounds];
    }
    return _window;
}

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions
{
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    
    if( [scene isKindOfClass:UIWindowScene.class] )
    {
        [self.window setWindowScene:(UIWindowScene *)scene];
    }
    [self.window setRootViewController:({
        UINavigationController *navigationC = [UINavigationController.alloc initWithRootViewController:CategoriesViewController.new];
        [navigationC.topViewController setTitle:NSLocalizedString(@"Categories", nil)];
        [navigationC pushViewController:[SymbolsViewController.alloc initWithCategory:SFSymbolDatasource.lastOpenedCategeory] animated:NO];
        (navigationC);
    })];
    [self.window makeKeyAndVisible];
}

@end