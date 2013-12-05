//
//  FileProcessor.h
//  BagOfWords
//
//  Created by Oliver Mason on 04/12/2013.
//  Copyright (c) 2013 Phrasys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WordReceiver.h"

@interface FileProcessor : NSObject

@property (nonatomic, weak) id<WordReceiver> delegate;

-(BOOL)processFile:(NSString*) filename;


@end
