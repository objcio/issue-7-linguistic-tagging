//
//  FileProcessor.m
//  BagOfWords
//
//  Created by Oliver Mason on 04/12/2013.
//  Copyright (c) 2013 Phrasys. All rights reserved.
//

#import "FileProcessor.h"

@implementation FileProcessor

- (BOOL)processFile:(NSString*) filename {
    NSError *error = nil;
    NSString *fileContent = [NSString stringWithContentsOfFile:filename encoding:NSUTF8StringEncoding error:&error];
    if (error != nil) {
        NSLog(@"FileProcessor: cannot read file '%@': %@", filename, [error localizedDescription]);
        return NO;
    }
    NSLog(@"length: %ld",[fileContent length]);
    NSUInteger options = NSLinguisticTaggerJoinNames | NSLinguisticTaggerOmitWhitespace | NSLinguisticTaggerOmitPunctuation;
    NSLinguisticTagger *tagger = [[NSLinguisticTagger alloc] initWithTagSchemes:@[NSLinguisticTagSchemeLanguage, NSLinguisticTagSchemeLemma, NSLinguisticTagSchemeNameTypeOrLexicalClass] options:options];
    [tagger setString:fileContent];
    
    [tagger setOrthography:[NSOrthography orthographyWithDominantScript:@"Latn" languageMap:@{@"Latn": @[@"en"]}] range:NSMakeRange(0, [fileContent length])];
    
    NSUInteger sentenceCounter = 0;
    NSRange currentSentence = [tagger sentenceRangeForRange:NSMakeRange(0, 1)];
    NSLog(@"First sentence is %@", NSStringFromRange(currentSentence));
    while (currentSentence.location != NSNotFound) {
        __block NSUInteger tokenPosition = 0;
        [tagger enumerateTagsInRange:currentSentence
                              scheme:NSLinguisticTagSchemeNameTypeOrLexicalClass
                             options:options
                          usingBlock:^(NSString *tag, NSRange tokenRange, NSRange sentenceRange, BOOL *stop) {
                              NSString *token = [fileContent substringWithRange:tokenRange];
                              NSString *lemma = [tagger tagAtIndex:tokenRange.location scheme:NSLinguisticTagSchemeLemma tokenRange: NULL sentenceRange:NULL];
                              if (lemma == nil) {
                                  lemma = token;
                              }
                              [self.delegate receiveWord:@{@"token": token,@"postag": tag, @"lemma": lemma, @"position":  @(tokenPosition), @"sentence": @(sentenceCounter), @"filename": filename}];
                              tokenPosition++;
                          }];
        sentenceCounter++;
        if (currentSentence.location + currentSentence.length == [fileContent length]) {
            currentSentence.location = NSNotFound;
        } else {
            NSRange nextSentence = NSMakeRange(currentSentence.location + currentSentence.length + 1, 1);
            currentSentence = [tagger sentenceRangeForRange:nextSentence];
            NSLog(@"current sentence is %@", NSStringFromRange(currentSentence));
        }
    }
    return YES;
}


@end
