//
//  ViewController.m
//  CamouflageTest
//
//  Created by Kamil Burczyk on 28.04.2014.
//  Copyright (c) 2014 Sigmapoint. All rights reserved.
//

#import "ViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "NSData+Camouflage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self testStringWritingAndReading];
//    [self testImageWritingAndReading];
}

- (void)testStringWritingAndReading
{
    NSData *data = [@"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum." dataUsingEncoding:NSASCIIStringEncoding];
    
    NSLog(@"data length before save: %d", data.length);
    
    [data writeToBMPFileInCameraRollWithCompletion:^(NSURL *assetURL) {
        [NSData dataFromBMPFileInCameraRollForURL:assetURL withCompletion:^(NSData *data) {
            NSLog(@"data length after load from bmp: %d", data.length);
            NSLog(@"STRING: %@", [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding]);
        }];
    }];
}

- (void)testImageWritingAndReading
{
    //sorry for that, but synchronous call is simpler to show you the results
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://placekitten.com/200/200"]];
    
    NSLog(@"data length before save: %d", data.length);
    
    [data writeToBMPFileInCameraRollWithCompletion:^(NSURL *assetURL) {
        [NSData dataFromBMPFileInCameraRollForURL:assetURL withCompletion:^(NSData *data) {
            NSLog(@"data length after load from bmp: %d", data.length);
            UIImageView *image = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithData:data]];
            image.frame = CGRectMake(0, 0, 200, 200);
            [self.view addSubview:image];
        }];
    }];
}

@end
