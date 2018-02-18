//
//  CustomTableViewCell.h
//  iOSExercise
//
//  Created by Admin on 11/02/18.
//  Copyright © 2018 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

//static NSString * const kCellIDTitle = @"CellWithTitle";
static NSString *const kPlaceListCell = @"PlaceListCell";

@interface CustomTableViewCell : UITableViewCell{
    NSString *reuseID;
    float totalWidth;
    float totalheight;
    
}
@property (nonatomic, assign) BOOL hasSetupConstraints;
@property (nonatomic, weak) UILabel *headingLbl;
@property (nonatomic, weak) UIImageView *thumbImg;
@property (nonatomic, weak) UILabel *descriptionLbl;
@property(nonatomic, weak) NSLayoutConstraint *vehicleImageViewBottomConstraint;

@end
