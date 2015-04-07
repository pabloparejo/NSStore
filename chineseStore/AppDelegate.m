//
//  AppDelegate.m
//  chineseStore
//
//  Created by Pablo Parejo Camacho on 28/3/15.
//  Copyright (c) 2015 Pablo Parejo Camacho. All rights reserved.
//

#import "AppDelegate.h"
#import "PARStoreViewController.h"

#define SECTION_TITLE_KEY @"SECTION_TITLE"
#define PRODUCTS_KEY @"PRODUCTS_KEY"
#define NAME_KEY @"NAME_KEY"
#define URL_KEY @"URL_KEY"
#define PRICE_KEY @"PRICE_KEY"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    PARStoreViewController *vc = [[PARStoreViewController alloc] initWithModel:[self buildModel]];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:vc];
    
    
    [self configureAppearance];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setRootViewController:navVC];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(NSArray *) buildModel{
    NSDictionary *shoes = @{SECTION_TITLE_KEY: @"Hogar y moda",
                            PRODUCTS_KEY:@[
                                    @{NAME_KEY: @"De las zapatillas de pies de cuero de las confortables",
                                      URL_KEY: @"http://www.minutodigital.com/wp-content/uploads/image001.jpg",
                                      PRICE_KEY: @"12.99€"},
                                    @{NAME_KEY: @"Wrongulator",
                                      URL_KEY: @"http://k32.kn3.net/taringa/5/5/9/3/8/6/8/trcroft/60C.jpg?1225",
                                      PRICE_KEY: @"12.99€"},
                                    @{NAME_KEY: @"Set de manicura",
                                      URL_KEY: @"http://k45.kn3.net/taringa/5/5/9/3/8/6/8/trcroft/AB9.jpg?6255",
                                      PRICE_KEY: @"4.99€"},
                                    @{NAME_KEY: @"Polo USA",
                                      URL_KEY: @"http://k34.kn3.net/taringa/5/5/9/3/8/6/8/trcroft/206.jpg?3940",
                                      PRICE_KEY: @"14.99€"}
                                    ]};
    
    
    
    NSDictionary *sports = @{SECTION_TITLE_KEY: @"Deporte",
                             PRODUCTS_KEY:@[
                                     @{NAME_KEY: @"Venta caliente de los balones club",
                                       URL_KEY: @"http://www.risasinmas.com/wp-content/uploads/2012/06/balones-real-madrid-barcelona.jpg",
                                       PRICE_KEY: @"9.95€"},
                                     @{NAME_KEY: @"Mejor venta de chanclas deportivas",
                                       URL_KEY: @"http://k43.kn3.net/taringa/5/5/9/3/8/6/8/trcroft/571.jpg?5585",
                                       PRICE_KEY: @"9.99€"}
                                     ,
                                     @{NAME_KEY: @"Del balón de rugby Premier Basketball Asociation",
                                       URL_KEY: @"http://k32.kn3.net/taringa/5/5/9/3/8/6/8/trcroft/04A.jpg?6885",
                                       PRICE_KEY: @"9.99€"}
                                     ]};
    
    
    
    
    NSDictionary *gadgets = @{SECTION_TITLE_KEY: @"Tecnología",
                              PRODUCTS_KEY:@[
                                      @{NAME_KEY: @"Nintendo PolyStation",
                                        URL_KEY: @"http://static.latercera.com/20131210/1865342.jpg",
                                        PRICE_KEY: @"99.95€"},
                                      @{NAME_KEY: @"Oferta licencia MichaelSoft Bimbows",
                                        URL_KEY: @"http://k34.kn3.net/taringa/5/5/9/3/8/6/8/trcroft/5A6.jpg?696",
                                        PRICE_KEY: @"12.99€"}
                                      ]};

    return @[shoes, gadgets, sports];
}

-(void) configureAppearance{
    UIColor *background =[UIColor colorWithRed:0.7
                                         green:0
                                          blue:0.01
                                         alpha:1];
    
    [[UINavigationBar appearance] setBarTintColor:background];
    [[[UITableViewHeaderFooterView appearance] contentView] setBackgroundColor:background];
    
    UIColor *yellowColor = [UIColor colorWithRed:1 green:0.7 blue:0.28 alpha:1];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:yellowColor}
     ];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.window setBackgroundColor:yellowColor];
    
}


@end
