//
//  main.m
//  BagOfWords
//
//  Created by Oliver Mason on 04/12/2013.
//  Copyright (c) 2013 Phrasys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileProcessor.h"
#import "WordReceiver.h"
#import "LogReceiver.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        id<WordReceiver> receiver = [LogReceiver new];
        FileProcessor *fileProc = [FileProcessor new];
        [fileProc setDelegate:receiver];
        NSString *filename = [NSString stringWithCString:argv[1] encoding:NSASCIIStringEncoding];
        [fileProc processFile:filename];
    }
    return 0;
}

