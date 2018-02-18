//
//  iOSExerciseTests.m
//  iOSExerciseTests
//
//  Created by Admin on 11/02/18.
//  Copyright © 2018 Admin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"

@interface iOSExerciseTests : XCTestCase

@property(nonatomic) ViewController *vcToTest;

@end

@implementation iOSExerciseTests

- (void)setUp {
    [super setUp];
    self.vcToTest = [[ViewController alloc] init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

// Check network connection test case
-(void)testNetworkconnection{
    [self.vcToTest connectionCheck];
//    BOOL checkValue = self.vcToTest.checkConnection;
    NSString *checkValue = (self.vcToTest.checkConnection) ? @"true" : @"false";
    XCTAssertTrue([checkValue isEqualToString:@"false"],@"Correct");
}

// Check Webservice URL test case
-(void)testWebServiceAPI{
    NSString *testURL = @"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json";
    [self.vcToTest apiURlMethod];
    NSString *resultStr = self.vcToTest.webAPIURl;
    XCTAssertTrue([resultStr isEqualToString:testURL], @"Strings are equal");
}

// Check respone data Title Text test case
-(void)testResultData{
    NSString *testStr = @"About Canada";
    [self.vcToTest webDataMethod];
//    NSDictionary *dict = self.vcToTest.resultDict;
    NSString *resultStr = self.vcToTest.titleString;
    XCTAssertTrue([resultStr isEqualToString:testStr], @"Both tiltle Equal");
}

// Check respone data array count test case
-(void)testDataArrayCount {
    [self.vcToTest tableItemcount];
    NSInteger testCount = self.vcToTest.rowsCount;
    XCTAssertTrue(self.vcToTest.itemscount.count == testCount, @"Items Matches Correct array");
}
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}


@end
