//
//  NetworkHandler.m
//  iOSExercise
//
//  Created by Admin on 11/02/18.
//  Copyright © 2018 Admin. All rights reserved.
//

#import "NetworkHandler.h"

@implementation NetworkHandler
@synthesize delegate;

-(void)didFinishWebService:(NSString *)webserviceAPI{
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:webserviceAPI]];
    responseData = [NSMutableData data];
    NSURLConnection * connection = [[NSURLConnection alloc]
                                    initWithRequest:urlRequest
                                    delegate:self startImmediately:YES];
    [connection scheduleInRunLoop:[NSRunLoop mainRunLoop]
                          forMode:NSDefaultRunLoopMode];
    [connection start];
}

#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
    NSData *data = [responseString dataUsingEncoding:NSUnicodeStringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//    NSLog(@"mydata ::: %@",json);
    if([self.delegate respondsToSelector:@selector(didFinishDetails:)]){
        [self.delegate didFinishDetails:json];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}

@end
