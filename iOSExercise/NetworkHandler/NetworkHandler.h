//
//  NetworkHandler.h
//  iOSExercise
//
//  Created by Admin on 11/02/18.
//  Copyright © 2018 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol  NetworkHandlerDelegate<NSObject>

@optional
-(void)didFinishDetails:(NSDictionary *)resultDict;

@end


@interface NetworkHandler : NSObject <NSURLConnectionDelegate>{
    
    NSMutableData *responseData;
}

@property(unsafe_unretained,nonatomic)id<NetworkHandlerDelegate>delegate;

-(void)didFinishWebService:(NSString *)webserviceAPI;

@end
