//
//  pstAppDelegate.m
//  pssst
//
//  Created by Aaron Augsburger on 1/18/14.
//
//

#import "pstAppDelegate.h"
#import "DecryptViewController.h"

@implementation pstAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	
    // Override point for customization after application launch.
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"Setup"])
    {
        // app already launched
    }
    else
    {
        // This is the first launch ever
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"Setup"];
        //GONNA NEED A POPUP TO ASK FOR DISPLAY NAME
       // NSString * displayName = ;
       // [[NSUserDefaults standardUserDefaults] setObject:displayName forKey:@"Name"];
        //GENERATE KEYPAIR
        [[NSUserDefaults standardUserDefaults] setObject:@"demo" forKey:@"PrivateKey"];
        [[NSUserDefaults standardUserDefaults] setObject:@"demo" forKey:@"PublicKey"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    UITabBarController *nav = (UITabBarController*) self.window.rootViewController;
    [nav setSelectedIndex:1];
    
    DecryptViewController *decryptView = (DecryptViewController *) nav.selectedViewController;
    NSString *cipherText = [url host];
    [decryptView passData: cipherText];

    return YES;
}

@end
