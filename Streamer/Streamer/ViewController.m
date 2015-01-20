//
//  ViewController.m
//  Streamer
//
//  Created by Nathan Birkholz on 1/1/15.
//  Copyright (c) 2015 Nate Birkholz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

NSURL *myURL = [[NSURL alloc] initWithString:@"http://jsonplaceholder.typicode.com/photos/"];
NSData *objects = [NSData dataWithContentsOfURL:myURL];
NSInputStream *stream = [[NSInputStream alloc] initWithData:objects];
[stream open];

NSMutableArray *arrayFromStream = [NSJSONSerialization JSONObjectWithStream:stream options:NSJSONReadingAllowFragments error:&error];

@end
