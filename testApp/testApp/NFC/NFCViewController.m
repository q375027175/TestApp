//
//  NFCViewController.m
//  testApp
//
//  Created by 崔关 on 2019/2/11.
//  Copyright © 2019 juge. All rights reserved.
//

#import "NFCViewController.h"
#import <CoreNFC/CoreNFC.h>

@interface NFCViewController()<NFCNDEFReaderSessionDelegate>

@end

@implementation NFCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NFCNDEFReaderSession *session = [[NFCNDEFReaderSession alloc] initWithDelegate:self queue:dispatch_queue_create(NULL, DISPATCH_QUEUE_CONCURRENT) invalidateAfterFirstRead:YES];
    [session beginSession];
}

/**
 具体父子关系看官方文档
 */
- (void) readerSession:(nonnull NFCNDEFReaderSession *)session didDetectNDEFs:(nonnull NSArray<NFCNDEFMessage *> *)messages {
    
    for (NFCNDEFMessage *message in messages) {
        for (NFCNDEFPayload *payload in message.records) {
            NSLog(@"Payload data:%@",payload.payload);
        }
    }
}

- (void)readerSession:(NFCNDEFReaderSession *)session didInvalidateWithError:(NSError *)error{
    
}

@end
