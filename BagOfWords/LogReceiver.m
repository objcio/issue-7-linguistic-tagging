//
//  LogReceiver.m
//  BagOfWords
//
//  Created by Oliver Mason on 04/12/2013.
//  Copyright (c) 2013 Phrasys. All rights reserved.
//

#import "LogReceiver.h"

@implementation LogReceiver

-(void)receiveWord:(NSDictionary*)word {
    NSLog(@"RECEIVED: %@",word);
}


@end
