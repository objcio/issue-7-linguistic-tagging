//
//  WordReceiver.h
//  BagOfWords
//
//  Created by Oliver Mason on 04/12/2013.
//  Copyright (c) 2013 Phrasys. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WordReceiver <NSObject>

-(void)receiveWord:(NSDictionary*)word;

@end
