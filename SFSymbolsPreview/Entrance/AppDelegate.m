//
//  AppDelegate.m
//  SFSymbolsPreview
//
//  Created by YICAI YANG on 2020/5/27.
//  Copyright © 2020 YICAI YANG. All rights reserved.
//

#import "AppDelegate.h"
#import "SFSymbolDatasource.h"


@interface AppDelegate()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [NSUserDefaults.standardUserDefaults setValue:@(NO) forKey:@"_UIConstraintBasedLayoutLogUnsatisfiable"];
    
//    NSString *imageNamed = @"gear";
//
//    UIImage *image = [UIImage systemImageNamed:imageNamed];
//
//    image = [image toSize:CGSizeMake(1024, 1024 * image.size.height / image.size.width)];
//
//    NSString *path = [@"/Users/caine/Downloads/" stringByAppendingFormat:@"%@.png", [imageNamed stringByReplacingOccurrencesOfString:@"."
//                                                                                                                          withString:@""]];
//    NSLog(@"%@ %d", image, [UIImagePNGRepresentation(image) writeToFile:path atomically:YES]);
    
    return YES;
}

#pragma mark - UISceneSession lifecycle

- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options
{
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [UISceneConfiguration.alloc initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}

@end
